import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/date_time_utils.dart';
import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/custom_widgets/MateriaIconButton.dart';
import 'package:my_cmh_updated/ui/widgets/room_selection_container.dart';

import 'package:my_cmh_updated/model-new/user_info_response.dart';
import 'package:my_cmh_updated/ui/dashboard/appointment/empty_time_slot.dart';
import 'package:my_cmh_updated/model-new/department_list_response_model.dart';
import 'package:my_cmh_updated/ui/widget/ligend_Item.dart';

class OnlineAppointmentScreen extends StatefulWidget {
  final List? userInfo;

  const OnlineAppointmentScreen({Key? key, this.userInfo}) : super(key: key);

  @override
  _OnlineAppointmentScreenState createState() =>
      _OnlineAppointmentScreenState();
}

class _OnlineAppointmentScreenState extends State<OnlineAppointmentScreen>
    with WidgetsBindingObserver {
  var controller = GetControllers.shared.getAppointmentController();

  //TextEditingController dateController = TextEditingController();

  var selectedDate;

  String? slotNo = '';
  int? checkedIndex;
  int? checkedTimeSlotIndex;

  bool isSaturday = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     print("App Resumed");
  //     // Handle app resume logic here
  //   } else if (state == AppLifecycleState.paused) {
  //     var tempSlotSl = await Session.shared.getSlotData();

  //     if (tempSlotSl != null && tempSlotSl != '') {
  //       await controller.releaseRetainTimeSlot(tempSlotSl);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }

        var tempSlotSl = await Session.shared.getSlotData();
        if (tempSlotSl != null && tempSlotSl != '') {
          await controller.releaseRetainTimeSlot(tempSlotSl);
        }

        if (context.mounted) {
          controller.selectedPatient = null;
          controller.selectedDepartment = null;
          controller.roomListData.clear();
          controller.timeSlot.clear();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("new_appointment".tr),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: FONT_NAME,
            fontSize: 20.0,
            color: Color(0xff4B4B4B),
            fontWeight: FontWeight.normal,
          ),
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () async {
              var tempSlotSl = await Session.shared.getSlotData();
              if (tempSlotSl != null && tempSlotSl != '') {
                await controller.releaseRetainTimeSlot(tempSlotSl);
              }

              controller.selectedPatient = null;
              controller.selectedDepartment = null;
              controller.roomListData.clear();
              controller.timeSlot.clear();

              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Color(0xff4B4B4B)),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: MaterialIconButton(
            mColor: colorAccent,
            height: 50.0,
            width: double.infinity,
            circle: 8.0,
            mChild: Text(
              'create_appointment'.tr,
              style: GoogleFonts.nunitoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            onClicked: () async {
              FocusScope.of(context).unfocus();

              if (controller.selectedPatient == null) {
                buildAlertDialogWithChildren(
                  context,
                  true,
                  'information'.tr,
                  'please_select_Patient'.tr,
                );
                return;
              }
              if (selectedDate == null) {
                buildAlertDialogWithChildren(
                  context,
                  true,
                  'information'.tr,
                  'please_select_date'.tr,
                );
                return;
              }
              if (controller.selectedDepartment == null) {
                buildAlertDialogWithChildren(
                  context,
                  true,
                  'information'.tr,
                  'please_select_department'.tr,
                );
                return;
              }
              if (checkedIndex == null) {
                buildAlertDialogWithChildren(
                  context,
                  true,
                  'information'.tr,
                  'please_select_room'.tr,
                );
                return;
              }
              if (controller.startTime.value.isEmpty &&
                  controller.endTime.value.isEmpty) {
                buildAlertDialogWithChildren(
                  context,
                  true,
                  'information'.tr,
                  'please_select_time'.tr,
                );
                return;
              }

              controller.createAppointment();
            },
          ),
        ),
        body: Obx(
          () => LoadingOverlayPro(
            backgroundColor: Colors.black38,
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xffE2E2E2)),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('select_patient'.tr),
                            value: controller.selectedPatient,
                            onChanged: (newValue) async {
                              controller.timeSlot.clear();
                              controller.roomListData.clear();
                              checkedIndex = null;
                              slotNo = '';
                              controller.selectedDepartment = null;
                              setState(() {
                                controller.selectedPatient = newValue;
                                selectedDate = null;
                                controller.appDate.value = '';

                                controller.timeSlot.clear();
                                controller.roomListData.clear();
                                checkedIndex = null;
                                slotNo = '';
                                controller.getCareOf(
                                  controller.selectedPatient.personalNumber,
                                );

                                controller.getAllDptList();
                              });
                              var tempSlotSl = await Session.shared
                                  .getSlotData();
                              if (tempSlotSl != null && tempSlotSl != '') {
                                await controller.releaseRetainTimeSlot(
                                  tempSlotSl,
                                );
                              }
                            },
                            items: widget.userInfo!.map((userInformation) {
                              var name = "";
                              final personalNumber =
                                  userInformation.personalNumber;

                              bool containsSafe(
                                String str,
                                String pattern, {
                                int fromEnd = 1,
                                int length = 1,
                              }) {
                                if (str.length >= fromEnd + length - 1) {
                                  final sub = str.substring(
                                    str.length - fromEnd,
                                    str.length - fromEnd + length,
                                  );
                                  return sub == pattern;
                                }
                                return false;
                              }

                              if (containsSafe(
                                personalNumber,
                                "W",
                                fromEnd: 2,
                              )) {
                                name = "Wife";
                              } else if (containsSafe(
                                personalNumber,
                                "H",
                                fromEnd: 2,
                              )) {
                                name = "Husband";
                              } else if (containsSafe(
                                personalNumber,
                                "S",
                                fromEnd: 2,
                              )) {
                                name = "Son";
                              } else if (containsSafe(
                                personalNumber,
                                "D",
                                fromEnd: 2,
                              )) {
                                name = "Daughter";
                              } else if (containsSafe(
                                personalNumber,
                                "F",
                                fromEnd: 2,
                              )) {
                                name = "Father";
                              } else if (containsSafe(
                                personalNumber,
                                "M",
                                fromEnd: 2,
                              )) {
                                name = "Mother";
                              } else if (personalNumber.contains("FL")) {
                                name = "Father in Law";
                              } else if (personalNumber.contains("ML")) {
                                name = "Mother in Law";
                              } else if (personalNumber.contains("MISC")) {
                                name = "Miscellaneous";
                              } else if (personalNumber.contains("MS")) {
                                name = "Miscellaneous";
                              } else if (containsSafe(
                                personalNumber,
                                "B",
                                fromEnd: 2,
                              )) {
                                name = "Batman";
                              } else {
                                name = "Self";
                              }
                              return DropdownMenuItem<Item>(
                                child: Text(
                                  userInformation.patientName +
                                      ' ' +
                                      '(' +
                                      name +
                                      ')',
                                ),
                                value: userInformation,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Color(0xffE2E2E2)),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Select_department'.tr),
                              value: controller.selectedDepartment,
                              onChanged: (newValue) async {
                                setState(() {
                                  controller.selectedDepartment = newValue;

                                  // Reset the date selection
                                  selectedDate = null;
                                  controller.appDate.value = '';

                                  controller.timeSlot.clear();
                                  controller.roomListData.clear();
                                  checkedIndex = null;
                                  slotNo = '';
                                });

                                var tempSlotSl = await Session.shared
                                    .getSlotData();
                                if (tempSlotSl != null && tempSlotSl != '') {
                                  await controller.releaseRetainTimeSlot(
                                    tempSlotSl,
                                  );
                                }
                              },
                              items: controller.departmentList.map((
                                department,
                              ) {
                                return DropdownMenuItem<DepartmentItem>(
                                  child: Text(department.buName ?? ''),
                                  value: department,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        controller.roomListData.clear();
                        controller.timeSlot.clear();
                        DateTime now = DateTime.now();
                        DateTime maxSelectableDate = now.add(
                          Duration(days: 2),
                        ); // Allow selection up to 72 hours
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: now,
                          lastDate:
                              maxSelectableDate, // Set the last selectable date to 72 hours from now
                        );

                        if (pickedDate != null) {
                          if (pickedDate.weekday == DateTime.saturday) {
                            setState(() {
                              isSaturday = true;
                            });
                          }
                          String formattedDate = DateFormat(
                            'dd/MM/yyyy',
                          ).format(pickedDate);

                          if (controller.checkAppointmentAvailability(
                            pickedDate,
                          )) {
                            String submitDate = DateFormat(
                              "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                            ).format(pickedDate);

                            controller.appDate.value = submitDate;

                            //controller.selectedDepartment = null;
                            checkedIndex = null;
                            controller.timeSlot.clear();
                            controller.roomListData.clear();
                            slotNo = '';

                            setState(() {
                              selectedDate = formattedDate;
                              controller.selectedDate.value = formattedDate;
                              controller.getRoomList(
                                controller.selectedDepartment.id.toString(),
                              );
                            });
                            var tempSlotSl = await Session.shared.getSlotData();
                            if (tempSlotSl != null && tempSlotSl != '') {
                              await controller.releaseRetainTimeSlot(
                                tempSlotSl,
                              );
                            }
                          }
                        } else {
                          debugPrint("Date is not selected");
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 15, right: 5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Color(0xffE2E2E2)),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedDate != null
                                  ? selectedDate
                                  : 'select-date'.tr,
                            ),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    controller.roomListData.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "select_room".tr,
                                style: TextStyle(
                                  fontFamily: FONT_NAME,
                                  fontSize: 17.0,
                                  color: Color(0xff4B4B4B),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                itemCount: controller.roomListData.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 3.0,
                                      childAspectRatio: 2.5,
                                      mainAxisSpacing: 3.0,
                                    ),
                                itemBuilder: (BuildContext context, int index) {
                                  var room = controller.roomListData[index];
                                  bool checked = index == checkedIndex;
                                  return InkWell(
                                    onTap: () async {
                                      setState(() {
                                        checkedIndex = index;
                                      });
                                      controller.roomNumber.value =
                                          room.roomNo!;
                                      controller.roomDesc.value =
                                          room.roomName ?? '';

                                      checkedTimeSlotIndex = null;
                                      var tempSlotSl = await Session.shared
                                          .getSlotData();
                                      if (tempSlotSl != null &&
                                          tempSlotSl != '') {
                                        await controller.releaseRetainTimeSlot(
                                          tempSlotSl,
                                        );
                                      }
                                      controller.getTimeSlotPerRoom(
                                        roomNo: room.roomNo,
                                        dateTime: controller.appDate.value,
                                      );
                                    },
                                    child: RoomSelectionContainer(
                                      roomName: room.roomName ?? '',
                                      isSelected: checked,
                                      accentColor: colorAccent,
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: 10),
                    if (checkedIndex != null &&
                        controller.selectedDepartment != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "select_time".tr,
                            style: TextStyle(
                              fontFamily: FONT_NAME,
                              fontSize: 17.0,
                              color: Color(0xff4B4B4B),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(() {
                            var groupedTimeSlots = controller.groupedTimeSlots;

                            if (groupedTimeSlots.isEmpty) {
                              return Center(child: EmptyTimeSlotWidget());
                            }

                            return ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: groupedTimeSlots.entries.map((entry) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Group title (entry.key)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 10,
                                          ),
                                          color: Colors.grey.shade300,
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        //Spacer(),
                                        Row(
                                          children: [
                                            LegendItem(
                                              color: colorRed,
                                              label: 'Booked',
                                            ),
                                            SizedBox(width: 8),
                                            LegendItem(
                                              color: colorYellow,
                                              label: 'Retained',
                                            ),
                                            SizedBox(width: 8),
                                            LegendItem(
                                              color: colorAccent,
                                              label: 'Available',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // GridView for each group's time slots
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: entry.value.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 8.0,
                                            childAspectRatio: 2.5,
                                            mainAxisSpacing: 8.0,
                                          ),
                                      itemBuilder: (BuildContext context, int index) {
                                        var item = entry.value[index];
                                        var checked =
                                            (item.slotNo.toString() == slotNo);
                                        bool isBooked = item.bookedBy != null;
                                        bool isAlreadyRetained =
                                            (item.retainFlag != null &&
                                            item.retainFlag == 1);

                                        return InkWell(
                                          onTap: () async {
                                            if (isBooked) {
                                              buildAlertDialogWithChildren(
                                                context,
                                                true,
                                                'information'.tr,
                                                'This slot is already booked by other user',
                                              );
                                              return;
                                            }

                                            if (isAlreadyRetained) {
                                              buildAlertDialogWithChildren(
                                                context,
                                                true,
                                                'information'.tr,
                                                'This slot is already retained by other user',
                                              );
                                              return;
                                            }

                                            // Check if this is an Officers Reserved slot and user is eligible
                                            bool isOfficersReserved =
                                                item.allocationType != null &&
                                                item.allocationName ==
                                                    "Officers Reserved";

                                            if (isOfficersReserved &&
                                                !controller
                                                    .isEligibleForOfficersReserved()) {
                                              buildAlertDialogWithChildren(
                                                context,
                                                true,
                                                'information'.tr,
                                                'This slot is reserved for Officers only (Army/BAF/Navy personnel).',
                                              );
                                              return;
                                            }

                                            var tempTimeSlot = await Session
                                                .shared
                                                .getSlotData();
                                            if (tempTimeSlot != null &&
                                                tempTimeSlot != '') {
                                              await controller
                                                  .releaseRetainTimeSlot(
                                                    tempTimeSlot,
                                                  );
                                            }

                                            // Check if room number and selected date match
                                            if (isSlotMatching(
                                              roomNumber:
                                                  controller.roomNumber.value,
                                              itemRoomNo: item.roomNo ?? 0,
                                              selectedDate: selectedDate,
                                              itemStartTime: item.startTime,
                                            )) {
                                              controller.startRetainTimer(
                                                onExpire: () async {
                                                  var tempSlotSl = await Session
                                                      .shared
                                                      .getSlotData();
                                                  if (tempSlotSl != null &&
                                                      tempSlotSl != '') {
                                                    await controller
                                                        .releaseRetainTimeSlot(
                                                          tempSlotSl,
                                                        );
                                                  }

                                                  if (context.mounted) {
                                                    setState(() {
                                                      controller
                                                              .selectedPatient =
                                                          null;
                                                      controller
                                                              .selectedDepartment =
                                                          null;
                                                      controller.roomListData
                                                          .clear();
                                                      controller.timeSlot
                                                          .clear();
                                                      slotNo = '';
                                                      //Navigator.pop(context);
                                                    });
                                                  }
                                                },
                                              );
                                              await controller.retainTimeSlot(
                                                item.slotNo.toString(),
                                                () {
                                                  setState(() {
                                                    slotNo = item.slotNo
                                                        .toString();
                                                  });

                                                  Session.shared.saveSlotDate(
                                                    item.slotNo.toString(),
                                                  );

                                                  controller.startTime.value =
                                                      item.startTime ?? '';
                                                  controller.endTime.value =
                                                      item.endTime ?? '';
                                                  controller.slotNoBody.value =
                                                      item.slotNo!;
                                                },
                                              );
                                            } else {
                                              // Optionally, show a message or handle the case where the condition is not met
                                              buildAlertDialogWithChildren(
                                                context,
                                                true,
                                                'information'.tr,
                                                'Selected room or date does not match the slot.',
                                              );
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: isBooked
                                                  ? colorRed
                                                  : (isAlreadyRetained
                                                        ? colorYellow
                                                        : (checked
                                                              ? colorYellow
                                                              : colorAccent)),
                                              border: Border.all(
                                                color:
                                                    (item.allocationType !=
                                                            null &&
                                                        item.allocationName ==
                                                            "Officers Reserved")
                                                    ? Colors.orange
                                                    : Color(0xffE2E2E2),
                                                width:
                                                    (item.allocationType !=
                                                            null &&
                                                        item.allocationName ==
                                                            "Officers Reserved")
                                                    ? 2.0
                                                    : 1.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                if (item.startTime != null)
                                                  Text(
                                                    DateTimeUtils.extractTime(
                                                      item.startTime!,
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                Text(
                                                  '-',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                if (item.endTime != null)
                                                  Text(
                                                    DateTimeUtils.extractTime(
                                                      item.endTime!,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isSlotMatching({
    required int roomNumber,
    required int itemRoomNo,
    required String? selectedDate,
    required String? itemStartTime,
  }) {
    if (roomNumber != (itemRoomNo) ||
        selectedDate == null ||
        itemStartTime == null) {
      return false;
    }
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(itemStartTime)) ==
        DateFormat(
          'yyyy-MM-dd',
        ).format(DateFormat('dd/MM/yyyy').parse(selectedDate));
  }
}
