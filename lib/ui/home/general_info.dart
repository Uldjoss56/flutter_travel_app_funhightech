import 'package:flutter/material.dart';
import 'package:flutter_travel_app/services/reservation_service.dart';
import 'package:flutter_travel_app/ui/colis/reservating_colis_status.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/travel_form/reserve_travel.dart';
import 'package:flutter_travel_app/ui/travel_form/transition_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoGeneral extends StatefulWidget {
  const InfoGeneral({
    super.key,
    required this.codeProgramme,
    required this.nbrePlace,
    required this.statutBagage,
    required this.startDate,
    required this.startHour,
    required this.destinationColis,
    required this.listColis,
    required this.nomRecepteurColis,
    required this.telRecepteurColis,
    required this.isColisRegistration,
    this.lieuDepart,
  });
  final String? codeProgramme, startDate, startHour, lieuDepart;
  final int? nbrePlace;
  final bool? statutBagage;
  final List<String?>? listColis;
  final String? nomRecepteurColis, telRecepteurColis, destinationColis;
  final bool? isColisRegistration;
  @override
  State<InfoGeneral> createState() => _InfoGeneralState();
}

class _InfoGeneralState extends State<InfoGeneral> {
  bool _isPressedBack = false;
  String? _userToken;

  final _reservationService = ReservationService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: width / 16,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: width / 20),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Color(0x21000000),
                ),
              ]),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/LogoFUN.png",
                    height: width / 4,
                    width: width / 4,
                  ),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      setState(() {
                        _isPressedBack = true;
                      });
                    },
                    onTapUp: (TapUpDetails details) {
                      setState(() {
                        _isPressedBack = false;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _isPressedBack = false;
                      });
                    },
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          width / 16, 0, 11 * width / 16, 0),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        boxShadow: _isPressedBack
                            ? const [
                                BoxShadow(
                                  color: Color(0x22000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                ),
                              ]
                            : [],
                        border: Border.all(
                          color: const Color(0xFF146CC2),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: const Color(0xFFF7F7F8),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: Color(0xFF146CC2),
                          ),
                          Text(
                            "Retour",
                            style: TextStyle(
                              color: Color(0xFF146CC2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      width / 20,
                    ),
                    child: ScopedModelDescendant<AppModel>(
                      builder: (context, child, model) {
                        if (widget.isColisRegistration ?? false) {
                          return Column(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(0, 0, 0, width / 15),
                                child: Text(
                                  "Confirmation",
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 15,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: width / 20,
                                    ),
                                    child: Text(
                                      "Listes des colis :",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      children: List.generate(
                                        widget.listColis!.length,
                                        (index) {
                                          return Text(
                                            "${widget.listColis![index]} # ",
                                            style: TextStyle(
                                              color: const Color(0xFFF7941F),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 22,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: width / 20,
                                    ),
                                    child: Text(
                                      "Noms du destinataire :",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${widget.nomRecepteurColis}",
                                      style: TextStyle(
                                        color: const Color(0xFFF7941F),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: width / 20,
                                    ),
                                    child: Text(
                                      "Numéro :",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.telRecepteurColis ?? "",
                                      style: TextStyle(
                                        color: const Color(0xFFF7941F),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: width / 20,
                                    ),
                                    child: Text(
                                      "Départ :",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.lieuDepart ?? "",
                                      style: TextStyle(
                                        color: const Color(0xFFF7941F),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: width / 20,
                                    ),
                                    child: Text(
                                      "Destination :",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.destinationColis ?? "",
                                      style: TextStyle(
                                        color: const Color(0xFFF7941F),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: width / 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final model =
                                      ScopedModel.of<AppModel>(context);
                                  if (_userToken == null ||
                                      _userToken == "" ||
                                      !model.isUserConnected) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => Transition(
                                          isColis: true,
                                          codeProgramme: null,
                                          nbrePlace: null,
                                          statutBagage: null,
                                          lieuDepart: widget.lieuDepart,
                                          lieuArrivee: widget.destinationColis,
                                          listColis: widget.listColis,
                                          nomRecepteurColis:
                                              widget.nomRecepteurColis,
                                          telRecepteurColis:
                                              widget.telRecepteurColis,
                                          isColisRegistration: true,
                                        ),
                                      ),
                                    );
                                  } else {
                                    final user = model.user;
                                    for (String? colis in widget.listColis!) {
                                      await _reservationService
                                          .reservationColis(
                                        user!.contact,
                                        widget.lieuDepart!,
                                        widget.destinationColis!,
                                        colis!,
                                        widget.telRecepteurColis!,
                                        widget.nomRecepteurColis!,
                                      );
                                    }
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ReservatingColisStatus(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  backgroundColor: const Color(0xFF146CC2),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width / 4,
                                    vertical: width / 40,
                                  ),
                                ),
                                child: Text(
                                  "Confirmer",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: width / 10,
                              ),
                            ],
                          );
                        } else {
                          if (model.isLoadingProgramme) {
                            model.loadAllProgrammes(widget.codeProgramme);
                            return Container(
                              margin: EdgeInsets.all(width / 10),
                              child: const WaveAnimation(
                                color: Color(0xFFF7941F),
                              ),
                            );
                          } else {
                            final program = model.programmes![0];
                            return Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 0, 0, width / 15),
                                  child: Text(
                                    "Confirmation",
                                    style: TextStyle(
                                      color: const Color(0xFF146CC2),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 15,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: width / 20,
                                      ),
                                      child: Text(
                                        "Date et heure :",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${widget.startDate} à ${widget.startHour}",
                                        style: TextStyle(
                                          color: const Color(0xFFF7941F),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width / 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: width / 20,
                                      ),
                                      child: Text(
                                        "Départ :",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        program.lieuDepart,
                                        style: TextStyle(
                                          color: const Color(0xFFF7941F),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width / 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: width / 20,
                                      ),
                                      child: Text(
                                        "Destination :",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        program.lieuArrivee,
                                        style: TextStyle(
                                          color: const Color(0xFFF7941F),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width / 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: width / 20,
                                      ),
                                      child: Text(
                                        "Place : ",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.nbrePlace.toString(),
                                        style: TextStyle(
                                          color: const Color(0xFFF7941F),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width / 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: width / 20,
                                      ),
                                      child: Text(
                                        "Bagages : ",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.statutBagage ?? false
                                            ? "Oui"
                                            : "Non",
                                        style: TextStyle(
                                          color: const Color(0xFFF7941F),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: width / 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width / 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_userToken == null ||
                                        _userToken == "" ||
                                        !model.isUserConnected) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => Transition(
                                            codeProgramme: widget.codeProgramme,
                                            nbrePlace: widget.nbrePlace ?? 0,
                                            statutBagage:
                                                widget.statutBagage ?? false,
                                            startDate: widget.startDate,
                                            startHour: widget.startHour,
                                            lieuArrivee: program.lieuArrivee,
                                            lieuDepart: program.lieuDepart,
                                            prix: program.prix,
                                            isColis: null,
                                            listColis: null,
                                            nomRecepteurColis: null,
                                            telRecepteurColis: null,
                                            isColisRegistration: null,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ReserveTravel(
                                            codeProgramme: widget.codeProgramme,
                                            nbrePlace: widget.nbrePlace,
                                            statutBagage: widget.statutBagage,
                                            startDate: widget.startDate,
                                            startHour: widget.startHour,
                                            lieuArrivee: program.lieuArrivee,
                                            lieuDepart: program.lieuDepart,
                                            prix: program.prix,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    backgroundColor: const Color(0xFF146CC2),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width / 4,
                                      vertical: width / 40,
                                    ),
                                  ),
                                  child: Text(
                                    "Confirmer",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: width / 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: width / 10,
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString("userToken") ?? "";
    // ignore: use_build_context_synchronously
    final model = ScopedModel.of<AppModel>(context);
    if (_userToken != null && _userToken != "" && !model.isUserConnected) {
      model.loginUser(_userToken!);
    }
    setState(() {
    });
  }
}
