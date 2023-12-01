import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/services/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio api = Api.api();

class UserService {
  String? _token;
  String? _message;

  VoyageClient? _user;

  Future authenticateUser(
      String? phone, String? password, String? token) async {
    try {
      final response = await api.post(
        'api/login',
        data: {
          "contact": phone,
          "password": password,
          "token": token,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = response.data;

        if (loginData.containsKey('token')) {
          final String token = loginData['token'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("userToken", token);
          setToken(token);

          final List<VoyageClient> voyageClients =
              (loginData['user'] as List).map(
            (user) {
              return VoyageClient.fromMap(user);
            },
          ).toList();
          setUser(voyageClients[0]);
          setMessage(loginData['message']);
          return token;
        } else {
          setMessage(loginData['message']);
          return loginData['message'];
        }
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 400) {
        setMessage(e.response!.data["error"]);
        Exception('Erreur 400: ${e.response!.data}');
      } else {
        setMessage("Vérifiez votre connexion internet");
        Exception('Erreur inattendue: $e');
      }
    }
  }

  void setToken(String token) {
    _token = token;
  }

  void setMessage(loginData) {
    _message = loginData;
  }

  void setUser(VoyageClient voyageClient) {
    _user = voyageClient;
  }

  Future registreUser(
    String fName,
    String lName,
    String email,
    String numTel,
    String numWhatsapp,
    String password,
  ) async {
    try {
      final response = await api.post(
        'api/register',
        data: {
          "nom": lName,
          "prenom": fName,
          "email": email,
          "contact": numTel,
          "tel_whatsapp": numWhatsapp,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = response.data;
        final message = loginData['message'];
        setMessage(message);
        return _message;
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 400) {
        setMessage(e.response!.data["error"]);
        Exception('Erreur 400: ${e.response!.data}');
      } else if (e is SocketException) {
        setMessage("Vérifiez votre connexion internet");
      } else {
        Exception('Erreur inattendue: $e');
      }
    }
  }

  Future updateUser(
    String fName,
    String lName,
    String email,
    String numTel,
    String numWhatsapp,
  ) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("userToken") ?? "";

      if (token != "") {
        api.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await api.post(
        'api/updateUser/$numTel',
        data: {
          "nom": lName,
          "prenom": fName,
          "email": email,
          "tel_whatsapp": numWhatsapp,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = response.data;
        final message = loginData['message'];
        setMessage(message);
        return _message;
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 400) {
        setMessage(e.response!.data["error"]);
        Exception('Erreur 400: ${e.response!.data}');
      } else if (e is SocketException) {
        setMessage("Vérifiez votre connexion internet");
      } else {
        Exception('Erreur inattendue: $e');
      }
    }
  }

  Future updateUserPassword(
    String numTel,
    String password,
    String newPassword,
  ) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("userToken") ?? "";

      if (token != "") {
        api.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await api.post(
        'api/updateUserPassword/$numTel',
        data: {
          "password": password,
          "new_password": newPassword,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = response.data;
        final message = loginData['message'];
        setMessage(message);
        return _message;
      }

    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 400) {
        setMessage(e.response!.data["error"]);
        Exception('Erreur 400: ${e.response!.data}');
      } else if (e is SocketException) {
        setMessage("Vérifiez votre connexion internet");
      } else {
        Exception('Erreur inattendue: $e');
      }
    }
  }

  String getMessage() {
    return _message ?? "";
  }

  VoyageClient? getUser() {
    return _user;
  }

  String getToken() {
    return _token ?? "";
  }

  bool isAuthenticated() {
    return _token != null;
  }

  void logout() {
    _token = null;
  }
}
