import 'package:my_cmh_updated/model-new/time_slot_list_response_model.dart';

enum EntryType { header, item }

class TimeSlotListEntry {
  final EntryType type;
  final String title;
  final TimeSlotList? item;

  TimeSlotListEntry.header(this.title) : type = EntryType.header, item = null;

  TimeSlotListEntry.item(this.item) : type = EntryType.item, title = '';
}
