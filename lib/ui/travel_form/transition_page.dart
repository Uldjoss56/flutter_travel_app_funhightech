import 'package:flutter/material.dart';
import 'package:flutter_travel_app/services/reservation_service.dart';
import 'package:flutter_travel_app/ui/colis/reservating_colis_status.dart';
import 'package:flutter_travel_app/ui/connexion/user_connexion.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/registration/user_registration.dart';
import 'package:flutter_travel_app/ui/travel_form/reserve_travel.dart';
import 'package:scoped_model/scoped_model.dart';

class Transition extends StatefulWidget {
  const Transition({
    super.key,
    required this.codeProgramme,
    required this.nbrePlace,
    required this.statutBagage,
    this.startDate,
    this.startHour,
    this.lieuArrivee,
    this.lieuDepart,
    this.prix,
    required this.listColis,
    required this.nomRecepteurColis,
    required this.telRecepteurColis,
    required this.isColisRegistration,
    required this.isColis,
  });
  
  final int? nbrePlace;
  final bool? statutBagage, isColis;
  final String? codeProgramme, startDate, startHour, lieuArrivee, lieuDepart, prix;
  final List<String?>? listColis;
  final String? nomRecepteurColis, telRecepteurColis;
  final bool? isColisRegistration;

  @override
  State<Transition> createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  bool isPressedBack = false;

  int userHasChoosen = -1;

  bool userResgistrated = false;

  final _reservationService = ReservationService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width / 600,
        backgroundColor: const Color(0xFF146CC2),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: width / 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.all(
                //   Radius.circular(20),
                // ),
                boxShadow: [
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
                      isPressedBack = true;
                    });
                  },
                  onTapUp: (TapUpDetails details) {
                    setState(() {
                      isPressedBack = false;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isPressedBack = false;
                    });
                  },
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(width / 16, 0, 11 * width / 16, 0),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: isPressedBack
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: width / 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Text(
                            "Avez-vous déjà ",
                            style: TextStyle(
                              color: const Color(0xFF146CC2),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: width / 18,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            "voyagé ",
                            style: TextStyle(
                              color: const Color(0xFFF7941F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: width / 18,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            "avec l'agence de voyage ",
                            style: TextStyle(
                              color: const Color(0xFF146CC2),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: width / 18,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            "FUN ",
                            style: TextStyle(
                              color: const Color(0xFFF7941F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: width / 18,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            "?",
                            style: TextStyle(
                              color: const Color(0xFF146CC2),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: width / 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width / 30,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: width / 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(width / 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7E7E8),
                                border: Border.all(
                                  width: 2,
                                  color: userHasChoosen == 0
                                      ? const Color(0xFF146CC2)
                                      : Colors.transparent,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: userResgistrated
                                    ? null
                                    : () {
                                        setState(() {
                                          userHasChoosen = 0;
                                        });
                                        /*
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) {
                                      return widget.isColis ?? false
                                          ? const ColisRegistration()
                                          : ReserveTravel02(
                                              idProgramme:
                                                  widget.idProgramme ?? 0,
                                              nbrePlace: widget.nbrePlace ?? 0,
                                              statutBagage:
                                                  widget.statutBagage ?? false,
                                              startDate: widget.startDate,
                                              startHour: widget.startHour,
                                              lieuArrivee: widget.lieuArrivee,
                                              lieuDepart: widget.lieuDepart,
                                              prix: widget.prix,
                                              onConnexion: false,
                                            );
                                    }),
                                  );
                                  */
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE7E7E8),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: width / 60,
                                    horizontal: width / 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Non",
                                  style: TextStyle(
                                    color: userResgistrated
                                        ? const Color(0xFFFAFAFA)
                                        : const Color(0xFF146CC2),
                                    fontSize: width / 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(width / 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7E7E8),
                                border: Border.all(
                                  width: 2,
                                  color: userHasChoosen == 1
                                      ? const Color(0xFF146CC2)
                                      : Colors.transparent,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    userHasChoosen = 1;
                                  });
                                  /*
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return widget.isColis ?? false
                                            ? const ColisConnexion()
                                            : ReserveTravel02(
                                                idProgramme:
                                                    widget.idProgramme ?? 0,
                                                nbrePlace: widget.nbrePlace ?? 0,
                                                statutBagage:
                                                    widget.statutBagage ?? false,
                                                startDate: widget.startDate,
                                                startHour: widget.startHour,
                                                lieuArrivee: widget.lieuArrivee,
                                                lieuDepart: widget.lieuDepart,
                                                prix: widget.prix,
                                                onConnexion: true,
                                              );
                                      },
                                    ),
                                    
                                  );*/
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE7E7E8),
                                  foregroundColor: const Color(0xFFFFFFFF),
                                  padding: EdgeInsets.symmetric(
                                    vertical: width / 60,
                                    horizontal: width / 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Oui",
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontSize: width / 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (userHasChoosen == -1)
                        Image.asset(
                          "assets/images/passengers.jpg",
                          height: width / 2,
                          width: width,
                        )
                      else if (userHasChoosen == 0)
                        UserRegistration(
                          onRegistrationState: (value) {
                            if (value == true) {
                              setState(() {
                                userHasChoosen = 1;
                                userResgistrated = true;
                              });
                            }
                          },
                        )
                      else
                        UserConnexion(
                          width: width,
                          onConnexionState: (status) async {
                            final model = ScopedModel.of<AppModel>(context);
                            if (status == true) {
                              final user = model.user;
                              if (widget.isColis ?? false) {
                                for (String? colis in widget.listColis!) {
                                  await _reservationService.reservationColis(
                                    user!.contact,
                                    widget.lieuDepart!,
                                    widget.lieuArrivee!,
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
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return ReserveTravel(
                                        codeProgramme: widget.codeProgramme,
                                        nbrePlace: widget.nbrePlace,
                                        statutBagage: widget.statutBagage,
                                        startDate: widget.startDate,
                                        startHour: widget.startHour,
                                        lieuArrivee: widget.lieuArrivee,
                                        lieuDepart: widget.lieuDepart,
                                        prix: widget.prix,
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
