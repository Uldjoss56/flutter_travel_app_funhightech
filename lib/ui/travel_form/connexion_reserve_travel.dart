import 'package:flutter/material.dart';

class ReserveTravel02 extends StatefulWidget {
  const ReserveTravel02({
    super.key,
    required this.idProgramme,
    required this.nbrePlace,
    required this.statutBagage,
    required this.onConnexion,
    this.startDate,
    this.startHour,
    this.lieuArrivee,
    this.lieuDepart,
    this.prix,
  });

  final int idProgramme;
  final int nbrePlace;
  final bool statutBagage, onConnexion;
  final String? startDate, startHour, lieuArrivee, lieuDepart, prix;

  @override
  State<ReserveTravel02> createState() => _ReserveTravel02State();
}

class _ReserveTravel02State extends State<ReserveTravel02> {
  bool isPressedBack = false;

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
                      margin: EdgeInsets.fromLTRB(
                          width / 16, 0, 11 * width / 16, 0),
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
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      width / 20,
                    ),
                    /*
                    child: widget.onConnexion
                        ? UserConnexion(
                            idProgramme: widget.idProgramme,
                            nbrePlace: widget.nbrePlace,
                            statutBagage: widget.statutBagage,
                            startDate: widget.startDate,
                            startHour: widget.startHour,
                            lieuArrivee: widget.lieuArrivee,
                            lieuDepart: widget.lieuDepart,
                            prix: widget.prix,
                            isConnexionWhenReservation: true,
                            width: width,
                            onConnexionState: (status) {},
                          )
                        : UserRegistration(
                            idProgramme: widget.idProgramme,
                            nbrePlace: widget.nbrePlace,
                            statutBagage: widget.statutBagage,
                            startDate: widget.startDate,
                            startHour: widget.startHour,
                            lieuArrivee: widget.lieuArrivee,
                            lieuDepart: widget.lieuDepart,
                            prix: widget.prix,
                            isRegistrateWhenReservation: true,
                            onRegistrationState: (value) {},
                          ),
                  
                    */
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
