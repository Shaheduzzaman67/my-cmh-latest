import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/common/date_time_utils.dart';
import 'package:my_cmh_updated/model-new/appointment_list_response.dart';
import 'package:my_cmh_updated/ui/dashboard/appointment/qr_code_dialog_widget.dart';

class AppointmentCardWidget extends StatelessWidget {
  final dynamic selectedPatient;
  final List<Appointments> appointmentList;
  final BuildContext context;

  AppointmentCardWidget({
    required this.context,
    required this.selectedPatient,
    required this.appointmentList,
  });

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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

                    return InkWell(
                      onTap: () => _showQrCode(
                        context,
                        appointment.personalNumber.toString(),
                        appointment.appointmentID.toString(),
                      ),
                      child: _buildAppointmentCard(
                        width,
                        height,
                        formattedDate,
                        appointment.newStartTime != null
                            ? DateTimeUtils.extractTime(
                                appointment.newStartTime!,
                              )
                            : '',
                        appointment.newEndTime != null
                            ? DateTimeUtils.extractTime(appointment.newEndTime!)
                            : '',
                        appointment,
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

  Widget _buildAppointmentCard(
    double width,
    double height,
    String formattedDate,
    String startTime,
    String endTime,
    dynamic appointment,
  ) {
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Color(0xffE5E5E5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.20,
            width: width * 0.34,
            decoration: BoxDecoration(
              color: Color(0xff3FDA85),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FONT_NAME,
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: _buildAppointmentDetails(startTime, endTime, appointment),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails(
    String startTime,
    String endTime,
    dynamic appointment,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRow("appointment_no".tr, appointment.id.toString(), bold: true),
        SizedBox(height: 5),
        _buildRow("serial_no".tr, appointment.slotSl.toString(), bold: true),
        _buildRow("time".tr, "$startTime - $endTime"),
        Divider(thickness: 2),
        _buildRow("dept".tr, appointment.departmentName!, bold: true),
        _buildRowWithFlexibleText("room".tr, appointment.roomDesc.toString()),
        _buildRow(
          "status".tr,
          appointment.appointmentStatus == 'active'
              ? 'active'.tr
              : 'canceled'.tr,
          bold: true,
          color: appointment.appointmentStatus == 'active'
              ? Colors.black
              : Colors.red,
        ),
      ],
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool bold = false,
    Color color = Colors.black,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRowWithFlexibleText(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        // ),
        // Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
