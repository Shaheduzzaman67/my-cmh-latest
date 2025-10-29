import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/date_time_utils.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:my_cmh_updated/model-new/appointment_list_response.dart';
import 'package:my_cmh_updated/ui/dashboard/appointment/qr_code_dialog_widget.dart';
import 'package:my_cmh_updated/ui/widgets/disable_button.dart';

class AppointmentCard extends StatelessWidget {
  final dynamic selectedPatient;
  final List<Appointments> appointmentList;
  final BuildContext context;
  final VoidCallback? onCancel;
  final Color? backgroundColor;
  final Color? cancelButtonColor;

  AppointmentCard({
    Key? key,
    this.onCancel,
    this.backgroundColor,
    this.cancelButtonColor,
    this.selectedPatient,
    required this.appointmentList,
    required this.context,
  }) : super(key: key);

  void _showQrCode(BuildContext context, String personalNumber, String apptID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QrCodeDialogWidget(
          personalNumber: personalNumber,
          apptID: apptID,
        );
      },
    );
  }

  var appointmentController = GetControllers.shared.getAppointmentController();

  void showCancelReasonDialog(BuildContext context, int apptId) {
    TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancel Confirmation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: reasonController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Please enter the reason for cancellation...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
            ],
          ),
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
          actionsPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          actions: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (reasonController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter a cancel reason'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        Navigator.of(context).pop();

                        appointmentController.cancelAppointment(
                          cancelReason: reasonController.text,
                          appointmentNo: apptId,
                          callBack: onCancel,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Cancel reason submitted: ${reasonController.text}',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return selectedPatient != null
        ? appointmentList.isNotEmpty
              ? ListView.builder(
                  itemCount: appointmentList.length,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = appointmentList[index];
                    DateTime date = DateTime.parse(
                      appointment.appointmentDate!,
                    );
                    String formattedDate = DateFormat(
                      'dd MMM yyyy',
                    ).format(date);

                    // Extract the repeated condition
                    final bool canCancel =
                        onCancel != null &&
                        appointment.appointmentDate != null &&
                        DateTime.parse(
                          appointment.appointmentDate!,
                        ).isAfter(DateTime.now()) &&
                        DateTime.parse(appointment.appointmentDate!).day !=
                            DateTime.now().day &&
                        appointment.appointmentStatus == 'active';

                    return InkWell(
                      onTap: () => _showQrCode(
                        context,
                        appointment.personalNumber.toString(),
                        appointment.appointmentID.toString(),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!DateTimeUtils.isSameDate(
                                appointment.appointmentDate ?? '',
                                appointment.newStartTime ?? '',
                              )) ...[
                                Center(
                                  child: Text(
                                    'This appointment is not valid',
                                    style: GoogleFonts.sansita(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      height: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],

                              // First Row - Serial, Date, Time
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Serial Number
                                  Expanded(
                                    //flex: 1,
                                    child: _buildInfoColumn(
                                      label: "serial_no".tr,
                                      value: appointment.slotSl.toString(),
                                    ),
                                  ),
                                  // Date
                                  Expanded(
                                    flex: 2,
                                    child: _buildInfoColumn(
                                      label: 'Date',
                                      value: formattedDate,
                                    ),
                                  ),

                                  _buildInfoColumn(
                                    label: "time".tr,
                                    value:
                                        appointment.newStartTime != null &&
                                            appointment.newEndTime != null
                                        ? '${DateTimeUtils.extractTime(appointment.newStartTime!)} - ${DateTimeUtils.extractTime(appointment.newEndTime!)}'
                                        : '',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Divider
                              Divider(),

                              const SizedBox(height: 10),
                              // Second Row - Room, Department, Cancel Button
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Room Number
                                  Expanded(
                                    flex: 4,
                                    child: _buildInfoColumn(
                                      label: "department_room".tr,
                                      value:
                                          appointment.departmentName
                                              .toString() +
                                          " - (" +
                                          appointment.roomDesc.toString() +
                                          ")",
                                    ),
                                  ),
                                  if (canCancel ||
                                      appointment.appointmentStatus != 'active')
                                    Spacer(),
                                  // Cancel Button
                                  if (canCancel)
                                    Container(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showCancelReasonDialog(
                                            context,
                                            appointment.appointmentID!,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              cancelButtonColor ??
                                              const Color(0xFFFFEBEE),
                                          foregroundColor: const Color(
                                            0xFFE57373,
                                          ),
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'cancel'.tr,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (appointment.appointmentStatus != 'active')
                                    DisabledButton(label: 'Canceled'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "no_appointment_found".tr,
                    style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
                  ),
                )
        : Center(
            child: Text(
              "select_patient_first".tr,
              style: TextStyle(fontSize: 25, fontFamily: FONT_NAME),
            ),
          );
  }

  Widget _buildInfoColumn({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.sansita(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
