import 'package:cura/model/general/old_people_home.dart';

class MasterContext {
  List<OldPeopleHome> oldPeopleHomesList = [];

  OldPeopleHome? getById(String id) {
    for (OldPeopleHome oldPeopleHome in oldPeopleHomesList) {
      if (oldPeopleHome.id == id) {
        return oldPeopleHome;
      } else {
        return null;
      }
    }
  }
}
