import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/model-new/appointment_request.dart';
import 'package:my_cmh_updated/model-new/cancel_appt_request.dart';
import 'package:my_cmh_updated/model-new/care_of_request.dart';
import 'package:my_cmh_updated/model-new/room_list_request.dart';
import 'package:my_cmh_updated/model-new/room_list_response_model.dart';
import 'package:my_cmh_updated/model-new/time_slot_list_response_model.dart';
import 'package:my_cmh_updated/model-new/time_slot_request.dart';
import 'package:my_cmh_updated/services/appointment_service.dart';
import 'package:my_cmh_updated/model-new/care_of_response.dart' as careOf;
import 'package:my_cmh_updated/model-new/department_list_response_model.dart';
import 'package:my_cmh_updated/model-new/get_appointment_request.dart';
import 'package:my_cmh_updated/model-new/appointment_list_response.dart'
    as appointment;
import 'package:my_cmh_updated/services/background_service.dart';
import 'package:my_cmh_updated/services/dislog_service.dart';
import 'package:my_cmh_updated/utils/string_utils.dart';
import 'package:workmanager/workmanager.dart';

class AppointmentController extends GetxController {
  final AppointmentNetworkService _networkHelper = AppointmentNetworkService();

  static const RELEASE_TASK_NAME = "timeSlotReleaseTask";

  var isLoading = false.obs;
  var departmentList = <DepartmentItem>[].obs;
  var careOfPaientInfo = careOf.Info().obs;

  var roomListData = <RoomList>[].obs;
  var timeSlot = <TimeSlotList>[].obs;
  var selectedPatient;
  var selectedDepartment;
  var chiefComplaint = '';
  var roomNumber = 0.obs;
  var slotNoBody = 0.obs;

  var roomDesc = ''.obs;
  var startTime = ''.obs;
  var endTime = ''.obs;
  var appDate = ''.obs;
  var selectedDate = ''.obs;
  var appointmentStatus = ''.obs;

  // Add appointment list observables
  var appointmentList = <appointment.Appointments>[].obs;
  var newAppointmentList = <appointment.Appointments>[].obs;

  Rx<Timer?> slotTimer = Rx<Timer?>(null);

  @override
  void onInit() {
    super.onInit();
    initializeWorkManager();
  }

  void initializeWorkManager() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  }

  // Add the optimized fetchAppointmentList method
  Future<void> fetchAppointmentList(String personalNumber) async {
    isLoading.value = true;

    var req = GetAppointmentRequest()..personalNumber = personalNumber;

    try {
      final result = await _networkHelper.getAppointmentListNew(req);
      isLoading.value = false;

      if (result.success == 'true') {
        final now = DateTime.now();

        // Filter and sort past appointments
        appointmentList.value = result.items!;
        appointmentList.sort((a, b) {
          final dateA = DateTime.parse(a.appointmentDate!);
          final dateB = DateTime.parse(b.appointmentDate!);
          return dateB.compareTo(dateA);
        });

        // Filter and sort new appointments
        newAppointmentList.value = result.items!
            .where(
              (element) =>
                  !DateTime.parse(
                    element.appointmentDate!,
                  ).isBefore(DateTime(now.year, now.month, now.day)) &&
                  element.appointmentStatus == 'active',
            )
            .toList();
        newAppointmentList.sort((a, b) {
          final dateA = DateTime.parse(a.appointmentDate!);
          final dateB = DateTime.parse(b.appointmentDate!);
          return dateB.compareTo(dateA);
        });

        update(); // Trigger GetBuilder update
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          'no-data'.tr,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> getAllDptList() async {
    isLoading.value = true;

    try {
      final result = await _networkHelper.getDptList();
      isLoading.value = false;

      if (result.success == true) {
        departmentList.value =
            result.items
                ?.where(
                  (item) => item.onlineFlag == 1 && item.activeStatus == 1,
                )
                .toList() ??
            [];
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> getCareOf(String personalNumber) async {
    isLoading.value = true;

    var req = CareOfRequest()
      ..personalNumber = personalNumber
      ..serviceCategory = "0";

    try {
      final result = await _networkHelper.getCareOf(req);
      isLoading.value = false;

      if (result.success == true) {
        careOfPaientInfo.value = result.obj?.patientInfo ?? careOf.Info();
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          'went_wrong'.tr,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> getRoomList(String departmentNo) async {
    isLoading.value = true;

    var req = RoomListRequest()..departmentNo = departmentNo;

    try {
      final result = await _networkHelper.getRoomList(req);
      isLoading.value = false;

      if (result.success == true) {
        roomListData.value =
            result.items
                ?.where(
                  (room) => room.onlineFlag == 1 && room.activeStatus == 1,
                )
                .toList() ??
            [];
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          'went_wrong'.tr,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> getTimeSlotPerRoom({int? roomNo, String? dateTime}) async {
    isLoading.value = true;

    var req = TimeSlotRequest(
      roomNo: roomNo,
      shiftdtlNo: 1,
      slotDate: dateTime,
    );

    timeSlot.clear();
    groupedTimeSlots.clear();

    try {
      var result = await _networkHelper.getTimeSlotPerRoom(req);
      isLoading.value = false;

      if (result.success == true) {
        timeSlot.value = result.timeSlotList ?? [];
        groupFilteredTimeSlots();
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          'went_wrong'.tr,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> retainTimeSlot(String? timeSlot, VoidCallback? callBack) async {
    if (timeSlot == null || timeSlot.isEmpty) {
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'Error'.tr,
        'Invalid time slot',
      );

      return;
    }

    isLoading.value = true; // Start loading

    try {
      var result = await _networkHelper.callApiRetainSlotSl(timeSlot);

      isLoading.value = false; // Stop loading

      if (result.success == true) {
        callBack?.call();
      } else {
        // buildAlertDialogWithChildren(
        //     Get.context!, true, 'information'.tr, 'went_wrong'.tr);
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          result.message.toString(),
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }

  Future<void> releaseRetainTimeSlot(String slotNo) async {
    final result = await _networkHelper.callApiReleaseSlotSl(slotNo);
    if (result.success ?? false) {
      await Session.shared.clearSlotDate();
      await Workmanager().cancelByUniqueName(RELEASE_TASK_NAME);
    } else {
      //await Session.shared.clearSlotDate();
      //print('>>>>>>>>>>>>>>>>>>>>>>>>>>>Not Executed');
      // silent the error
    }
  }

  Future<void> createAppointment() async {
    isLoading.value = true;

    var req = AppointmentRequest(
      patientName: selectedPatient.patientName,
      personalNumber: selectedPatient.personalNumber,
      departmentNo: selectedDepartment.id,
      chifComplain: chiefComplaint.isEmpty ? 'N/A' : chiefComplaint,
      chiefComplaints: chiefComplaint.isEmpty ? 'N/A' : chiefComplaint,
      appointmentDate: appDate.value, // Assuming appointment date
      shiftDetailNo: 0,
      consulationType: 1,
      doctorNo: 0,
      priorityNo: 1082000000090,
      priorityDesc: 'Routine',
      registrationNo: careOfPaientInfo.value.id,
      gender: careOfPaientInfo.value.gender,
      maritalStatus: careOfPaientInfo.value.maritalStatus,
      email: careOfPaientInfo.value.email,
      bloodGroup: careOfPaientInfo.value.bloodGroup,
      mobileNumber: careOfPaientInfo.value.phoneMobile,
      multiAppointment: false,
      roomNo: roomNumber.value,
      roomDesc: roomDesc.value,
      startTime: startTime.value,
      endTime: endTime.value,
      slotNo: slotNoBody.value,
    );

    try {
      final result = await _networkHelper.createAppointment(req);

      if (result.success == true) {
        await Session.shared.clearSlotDate();
        await Workmanager().cancelByUniqueName(RELEASE_TASK_NAME);
        buildAlertDialogForAppointment(
          Get.context!,
          true,
          'serial_number'.tr,
          result.slotSl.toString(),
          departmentName: selectedDepartment.buName,
          roomName: roomDesc.value,
          onPressed: () async {
            var tempSlotSl = await Session.shared.getSlotData();
            if (tempSlotSl != null && tempSlotSl != '') {
              await releaseRetainTimeSlot(tempSlotSl);
            }

            if (Get.context!.mounted) {
              selectedPatient = null;
              selectedDepartment = null;
              roomListData.clear();
              timeSlot.clear();
              Get.back();
            }
          },
        );
      } else {
        buildAlertDialogForAppointmentError(
          Get.context!,
          true,
          'dr_appointment'.tr,
          result.message.toString(),
        );
        await releaseRetainTimeSlot(slotNoBody.value.toString());
        //await Session.shared.clearSlotDate();
      }
    } catch (e) {
      buildAlertDialogForAppointmentError(
        Get.context!,
        true,
        'dr_appointment'.tr,
        "Unable to create the appointment. Kindly try again later",
      );
      await releaseRetainTimeSlot(slotNoBody.value.toString());
    } finally {
      isLoading.value = false;
    }
  }

  var groupedTimeSlots = <String, List<TimeSlotList>>{}.obs;

  void groupFilteredTimeSlots() {
    var filteredSlots = getFilteredTimeSlots();

    Map<String, List<TimeSlotList>> tempGrouped = {};

    for (var slot in filteredSlots) {
      String key = slot.description ?? 'Others';

      if (tempGrouped.containsKey(key)) {
        tempGrouped[key]!.add(slot);
      } else {
        tempGrouped[key] = [slot];
      }
    }

    // After grouping, sort each group's slots by slotSl
    tempGrouped.forEach((key, slots) {
      slots.sort((a, b) {
        if (a.slotSl == null && b.slotSl == null) return 0;
        if (a.slotSl == null) return -1;
        if (b.slotSl == null) return 1;
        return a.slotSl!.compareTo(b.slotSl!);
      });
    });

    groupedTimeSlots.value = tempGrouped;
  }

  List<TimeSlotList> getFilteredTimeSlots() {
    // var sortedTimeSlot = List<TimeSlotList>.from(timeSlot)
    //   ..sort((a, b) {
    //     // Handle null values for slotSl
    //     if (a.shiftOrder == null && b.shiftOrder == null) return 0;
    //     if (a.shiftOrder == null) return -1;
    //     if (b.shiftOrder == null) return 1;
    //     return a.shiftOrder!.compareTo(b.shiftOrder!);
    //   });

    // Check if the selected date is today
    DateTime now = DateTime.now();
    String todayFormatted = DateFormat('dd/MM/yyyy').format(now);

    if (selectedDate.value == todayFormatted) {
      // Filter out past time slots for today
      return timeSlot.where((slot) {
        if (slot.startTime == null) return true;

        // Parse the endTime
        DateTime startTime;
        try {
          // Assuming endTime is in UTC format as in your example
          startTime = DateTime.parse(slot.startTime!);

          // Convert to local time if necessary
          startTime = startTime.toLocal();

          // Compare with current time
          return startTime.isAfter(now);
        } catch (e) {
          print("Error parsing date: ${e.toString()}");
          return true; // Include the slot if there's a parsing error
        }
      }).toList(); // Explicitly cast back to List<TimeSlotList>
    }

    // Return all slots for future dates
    return timeSlot;
  }

  // Check if appointment is available on a given date
  bool checkAppointmentAvailability(DateTime pickedDate) {
    if (selectedDepartment == null) {
      appointmentStatus.value = "Please select a department first.";
      DialogService.showWarningDialog(
        title: 'warning'.tr,
        content: 'Please select a department first.',
      );
      return false; // Return false if no department is selected
    }

    String selectedDay = DateFormat('EEEE').format(pickedDate).toLowerCase();
    Map<String, dynamic> activeDays = StringUtil.parseBusinessSchedule(
      selectedDepartment.businessSchedule ?? '{}',
    );

    print(activeDays);

    bool isDayAvailable = false;
    if (activeDays[selectedDay] is bool) {
      isDayAvailable = activeDays[selectedDay];
    } else if (activeDays[selectedDay] is Map) {
      isDayAvailable = activeDays[selectedDay]['value'] ?? false;
    }

    if (isDayAvailable) {
      appointmentStatus.value =
          "Appointment available on ${selectedDay.capitalize}";
      return true; // Return true if appointment is available
    } else {
      List<String?> availableDays = activeDays.entries
          .where((e) => e.value is bool ? e.value : (e.value['value'] ?? false))
          .map((e) => e.key.capitalize)
          .toList();

      appointmentStatus.value =
          "No appointments on ${selectedDay.capitalize}.\n Available on: ${availableDays.join(', ')}";
      DialogService.showWarningDialog(
        title: 'warning'.tr,
        content: appointmentStatus.value,
        isDismissible: true,
      );
      return false; // Return false if no appointment is available
    }
  }

  void startRetainTimer({VoidCallback? onExpire}) async {
    await Workmanager().cancelByUniqueName(RELEASE_TASK_NAME);
    // Schedule new task for 15 minutes
    await Workmanager().registerOneOffTask(
      RELEASE_TASK_NAME,
      RELEASE_TASK_NAME,
      initialDelay: Duration(minutes: 15),
      inputData: {'slotNo': await Session.shared.getSlotData()},
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
    slotTimer.value?.cancel();
    slotTimer.value = Timer(Duration(minutes: 4), () async {
      // only if needed

      if (onExpire != null) {
        await Workmanager().cancelByUniqueName(RELEASE_TASK_NAME);
        onExpire();
      }
      update();
    });
  }

  Future<void> cancelAppointment({
    int? appointmentNo,
    String? cancelReason,
    VoidCallback? callBack,
  }) async {
    isLoading.value = true;

    var req = CancelRequest(
      appointmentNo: appointmentNo,
      cencelReason: cancelReason,
      cencelType: 0,
    );

    try {
      var result = await _networkHelper.cancelAppointments(req);
      isLoading.value = false;

      if (result.success == true) {
        if (callBack != null) {
          callBack();
        }
      } else {
        buildAlertDialogWithChildren(
          Get.context!,
          true,
          'information'.tr,
          'went_wrong'.tr,
        );
      }
    } catch (e) {
      isLoading.value = false;
      buildAlertDialogWithChildren(
        Get.context!,
        true,
        'information'.tr,
        'went_wrong'.tr,
      );
    }
  }
}
