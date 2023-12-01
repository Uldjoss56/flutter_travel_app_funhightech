import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_travel_app/data/reservation.dart';
import 'package:flutter_travel_app/services/api/api.dart';
import 'package:flutter_travel_app/execption/auth_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio api = Api.api();

class ReservationService {
  late String _codeReservation;

  Future<void> reservationUser(
    String idProgramme,
    String idClient,
    String idBus,
    String nbrePlace,
    String statutBagage,
    String date,
    String lieuDepart,
    String lieuArrivee,
    String heureDepart,
    String? heureArrivee,
    String prix,
    String numeroPaiement,
    moyenPaiement,
  ) async {
    try {
      final response = await api.post(
        'api/reserveUser',
        data: jsonEncode({
          "code_programme": idProgramme,
          "id_client": idClient,
          "heure_depart": heureDepart,
          "heure_arrivee": heureArrivee,
          "lieu_depart": lieuDepart,
          "lieu_arrivee": lieuArrivee,
          "date_voyage": date,
          "id_bus": idBus,
          "nbr_place": nbrePlace,
          "statut_bagage": (statutBagage == "true") ? 1 : 0,
          "prix": prix,
          "confirmation_voyage": "",
          "numero_paiement": numeroPaiement,
          "moyen_paiement": moyenPaiement,
          "dateSave": DateTime.now().toString(),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data["message"] == "Réservation réussie" ||
            data.containsKey("reservationID")) {
          setCode(data["reservationID"]);
        }
      }
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Reservation failed: $e');
    }
  }

  Future getAll(String userID) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("userToken") ?? "";

      if (token != "") {
        api.options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await api.get('api/userReservations/$userID');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<VoyageReservation> userReservations =
            (data["user_reservations"] as List).map(
          (e) {
            VoyageReservation reservation = VoyageReservation.fromMap(e);
            return reservation;
          },
        ).toList();
        final reserveUserReservations = userReservations.reversed.toList();
        return reserveUserReservations;
      }
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == 422) {
        Exception('Erreur 422: ${e.response!.data}');
      }
      throw Exception('Reservation failed: $e');
    }
  }

  Future<void> reservationColis(
    String idClient,
    String lieuDepart,
    String lieuArrivee,
    String nomColis,
    String numeroDestinataire,
    String nomDestinataire,
  ) async {
    try {
      final response = await api.post(
        'api/reserveColis',
        data: jsonEncode({
          "id_client": idClient,
          "nom_colis": nomColis,
          "lieu_depart": lieuDepart,
          "lieu_reception": lieuArrivee,
          "numero_destinataire": numeroDestinataire,
          "nom_destinataire": nomDestinataire,
          "dateSave": DateTime.now().toString(),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data["message"] == "Réservation réussie" ||
            data.containsKey("reservationID")) {
          setCode(data["reservationID"]);
        }
      }
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw AuthException('Reservation failed');
    }
  }

  void setCode(data) {
    _codeReservation = data;
  }

  String getCode() {
    return _codeReservation;
  }
}
