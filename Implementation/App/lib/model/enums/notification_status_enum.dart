import 'package:json_annotation/json_annotation.dart';

enum NotificationStatus {
  @JsonValue("To do")
  toDo,
  @JsonValue("In Progress")
  inProgress,
  @JsonValue("Done")
  done
}

List<String> getNotificationStatusList() {
  return ['To Do', 'In Progress', 'Done'];
}
