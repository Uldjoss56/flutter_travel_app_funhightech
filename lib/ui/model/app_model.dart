import 'package:flutter_travel_app/data/bus.dart';
import 'package:flutter_travel_app/data/programme.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/services/user_service.dart';
import 'package:flutter_travel_app/services/programme_service.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  bool _isLoadingProgramme = true;
  bool get isLoadingProgramme => _isLoadingProgramme;

  bool _isLoadingSortedPrograms = true;
  bool get isLoadingSortedPrograms => _isLoadingSortedPrograms;

  bool _isValidToken = true;
  bool get isValidToken => _isValidToken;

  bool _isUserConnected = false;
  bool get isUserConnected => _isUserConnected;

  String _connexionMessage = "";
  String get connexionMessage => _connexionMessage;

  List<VoyageProgramme>? _programmes;
  List<VoyageProgramme>? get programmes => _programmes;

  List<VoyageBus>? _buses;
  List<VoyageBus>? get buses => _buses;

  VoyageClient? _user;
  VoyageClient? get user => _user;

  final ProgrammeService _programmeService = ProgrammeService();
  final UserService _userService = UserService();

  Future loginUser(String token) async {
    _isUserConnected = false;
    _isValidToken = true;
    notifyListeners();

    final jwtData = jwtDecode(token);
    if (!jwtData.isExpired! || token.isEmpty) {
      await _userService.authenticateUser(null, null, token);
      _user = _userService.getUser();
     _connexionMessage = _userService.getMessage();
      _isUserConnected = true;
      notifyListeners();
    } else {
      _isValidToken = false;
      _isUserConnected = false;
      notifyListeners();
    }
  }

  Future loadAllProgrammes(String? idProgramme) async {
    _isLoadingProgramme = true;
    notifyListeners();

    await _programmeService.getAllPrograme(idProgramme);

    _programmes = _programmeService.getProgrammes();

    _isLoadingProgramme = false;
    notifyListeners();
  }

  void changeIsLoadSortedProgram() {
    _isLoadingSortedPrograms = true;
  }

  Future userSearching(String targetValue) async {
    _isLoadingSortedPrograms = true;
    notifyListeners();

    _programmes = await _programmeService.getAll();
    if (targetValue.isNotEmpty) {
      _programmes = _programmes!
          .where(
            (programme) =>
                programme.lieuDepart
                    .toLowerCase()
                    .contains(targetValue.toLowerCase()) ||
                programme.lieuArrivee
                    .toLowerCase()
                    .contains(targetValue.toLowerCase()) ||
                programme.heureDepart
                    .toLowerCase()
                    .contains(targetValue.toLowerCase()),
          )
          .toList();
    }

    _isLoadingSortedPrograms = false;
    notifyListeners();
  }

  void deconnectUser() {
    _user = null;
    _isUserConnected = false;
    notifyListeners();
  }
}
