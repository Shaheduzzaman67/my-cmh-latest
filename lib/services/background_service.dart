import 'package:my_cmh_updated/common/sessions.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      switch (task) {
        case "timeSlotReleaseTask":
          final slotNo = inputData?['slotNo'];
          if (slotNo != null) {
            var tempSlotSl = await Session.shared.getSlotData();

            var controller = GetControllers.shared.getAppointmentController();

            if (tempSlotSl != null && tempSlotSl != '') {
              await controller.releaseRetainTimeSlot(tempSlotSl);
            }
          }
          break;
      }
      return Future.value(true);
    } catch (err) {
      return Future.value(false);
    }
  });
}
