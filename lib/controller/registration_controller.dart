/*import 'package:fun_high_tech_travel_app/data/user.dart';
import 'package:fun_high_tech_travel_app/services/user_service.dart';

class AuthController {
  final UserService _userService = UserService();

  Future<void> loginUser(String phone, String password) async {
    await _userService.authenticateUser(phone, password, null);
  }

  bool isAuthenticated() {
    return _userService.isAuthenticated();
  }

  String getMessage() {
    return _userService.getMessage();
  }

  VoyageClient? getUser() {
    return _userService.getUser();
  }

  String getToken() {
    return _userService.getToken();
  }

  Future connectUserByToken(String token) async {
    await _userService.authenticateUser(null, null, token);
  }
}

class RegistrationController {
  final UserService _userService = UserService();

  Future registreUser(
    String fName,
    String lName,
    String email,
    String numTel,
    String numWhatsapp,
    String password,
  ) async {
    _userService.registreUser(
      fName,
      lName,
      email,
      numTel,
      numWhatsapp,
      password,
    );
  }

  String? getMessage()  {
    return _userService.getMessage();
  }
}
*/
