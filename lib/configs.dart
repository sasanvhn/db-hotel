import 'db/guest/guest_model.dart';
import 'db/staff/staff_model.dart';

class Configs {
  static Guest? guest;
  static Staff? staff;

  static isGuestLoggedIn() {
    return guest != null;
  }

  static isStaffLoggedIn() {
    return staff != null;
  }
}
