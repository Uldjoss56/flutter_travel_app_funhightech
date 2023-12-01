import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_travel_app/data/bus.dart';
import 'package:flutter_travel_app/services/api/api.dart';
import 'package:flutter_travel_app/data/programme.dart';
import 'package:flutter_travel_app/execption/auth_exception.dart';

Dio dio = Api.api();

class ProgrammeService {
  late List<VoyageProgramme> _programmes;

  String? _message;

  late List<VoyageBus> _buses;

  Future<void> getAllPrograme(String? idProgramme) async {
    try {
      final response = await dio.get(
        'api/getProgramme/$idProgramme',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<VoyageProgramme> voyageProgrammes =
            (data['programmes'] as List).map(
          (programme) {
            return VoyageProgramme.fromMap(programme);
          },
        ).toList();
        final List<VoyageBus> voyageBuses = (data["bus"] as List).map(
          (busData) {
            return VoyageBus.fromMap(busData);
          },
        ).toList();
        setProgramme(voyageProgrammes);
        setBuses(voyageBuses);
      }
    } on SocketException {
      _message = "Problème de connexion";
      throw NetworkException();
    } catch (e) {
      throw Exception('Authentication failed : $e');
    }
  }

  Future getAllProgrameHours(String lieuDepart, String lieuArrivee) async {
    try {
      final response = await dio.get(
        'api/getProgrammeHours/$lieuDepart/$lieuArrivee',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<String> voyageProgramHours =
            (data['heureDepart'] as List).map(
          (programmeHour) {
            return programmeHour["heure_depart"].toString();
          },
        ).toList();
        return voyageProgramHours;
      }
    } on SocketException {
      _message = "Problème de connexion";
      throw NetworkException();
    } catch (e) {
      throw AuthException('Authentication failed');
    }
  }

  Future getAll() async {
    try {
      final response = await dio.get(
        'api/getAllPrograms',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<VoyageProgramme> programs = (data['programs'] as List).map(
          (programme) {
            return VoyageProgramme.fromMap(programme);
          },
        ).toList();
        return programs;
      }
    } on SocketException {
      _message = "Problème de connexion";
      throw NetworkException();
    } catch (e) {
      throw AuthException('Authentication failed');
    }
  }

  void setProgramme(List<VoyageProgramme> programmes) {
    _programmes = programmes;
  }

  List<VoyageProgramme> getProgrammes() {
    return _programmes;
  }

  void setBuses(List<VoyageBus> buses) {
    _buses = buses;
  }

  List<VoyageBus> getBuses() {
    return _buses;
  }

  String message() {
    return _message!;
  }
}
