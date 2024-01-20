import 'package:flutter/cupertino.dart';
import 'package:talent_tree/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '', name: '', mobile: '', token: '', password: '', profileImage: '');
  bool _isSubscribed = false;
  bool _isRegistered = false;

  User get user => _user;
  bool get isSubscribed => _isSubscribed;
  bool get isRegistered => _isRegistered;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setIsSubscrbed(bool subscribed) {
    _isSubscribed = subscribed;
    notifyListeners();
  }

  void setIsRegistered(bool registered) {
    _isRegistered = registered;
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
