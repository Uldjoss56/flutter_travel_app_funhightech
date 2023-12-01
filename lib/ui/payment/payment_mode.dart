import 'package:flutter/material.dart';
import 'package:flutter_travel_app/services/reservation_service.dart';
import 'package:flutter_travel_app/ui/payment/statut_payment.dart';
import 'package:flutter_travel_app/ui/travel_form/reserve_travel.dart';

class PaymentMode extends StatefulWidget {
  const PaymentMode({
    super.key,
    required this.isMTNPay,
    required this.isMasterCardPay,
    required this.isMoovPay,
    required this.isVisaPay,
    required this.nbrePlace,
    required this.statutBagage,
    required this.codeProgramme,
    required this.idBus,
    this.startDate,
    this.startHour,
    this.lieuArrivee,
    this.lieuDepart,
    this.prix,
    this.idClient,
  });

  final bool isMoovPay, isMTNPay, isMasterCardPay, isVisaPay;
  final int nbrePlace;
  final bool statutBagage;
  final String? codeProgramme,
      idBus,
      startDate,
      startHour,
      prix,
      lieuDepart,
      lieuArrivee,
      idClient;

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  bool isPressedBack = false;

  final TextEditingController _numTelController = TextEditingController();
  final _reservationService = ReservationService();
  final _phoneNumberRegex = RegExp(r'^\d{8}$');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMoovPay = widget.isMoovPay;
    final isMTNPay = widget.isMTNPay;
    final isMasterCardPay = widget.isMasterCardPay;
    final isVisaPay = widget.isVisaPay;

    final codeProgramme = widget.codeProgramme;
    String moyenPaiement;
    if (isMoovPay) {
      moyenPaiement = "Moov Mobile Money";
    } else if (isMTNPay) {
      moyenPaiement = "MTN Mobile Money";
    } else if (isVisaPay) {
      moyenPaiement = "Visa";
    } else {
      moyenPaiement = "MasterCard";
    }

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
                ],
              ),
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
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => ReserveTravel(
                            nbrePlace: widget.nbrePlace,
                            statutBagage: widget.statutBagage,
                            codeProgramme: widget.codeProgramme,
                            startDate: widget.startDate,
                            startHour: widget.startHour,
                            lieuArrivee: widget.lieuArrivee,
                            lieuDepart: widget.lieuDepart,
                            prix: widget.prix,
                          ),
                        ),
                      );
                    },
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
                  // SizedBox(
                  //   height: width / 20,
                  // ),
                  Container(
                    padding: EdgeInsets.all(
                      width / 20,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            width / 15,
                          ),
                          child: Text(
                            "Moyen de paiement ",
                            style: TextStyle(
                              color: const Color(0xFF146CC2),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: width / 18,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            if (isMoovPay)
                              Image.asset(
                                "assets/images/moov0africa_logo.png",
                                width: width / 4,
                                height: width / 4,
                              ),
                            if (isVisaPay)
                              Image.asset(
                                "assets/images/visa_logo.png",
                                width: width / 4,
                                height: width / 4,
                              ),
                            if (isMTNPay)
                              ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFFFFBD06),
                                  BlendMode.srcIn,
                                ),
                                child: Image.asset(
                                  "assets/images/mtn_logo.png",
                                  width: width / 4,
                                  height: width / 4,
                                ),
                              ),
                            if (isMasterCardPay)
                              Image.asset(
                                "assets/images/master0card_logo.png",
                                width: width / 4,
                                height: width / 4,
                              ),
                          ],
                        ),
                        SizedBox(
                          height: width / 20,
                        ),
                        Column(
                          children: [
                            Text(
                              (isMoovPay || isMTNPay)
                                  ? "Numéro de paiement"
                                  : "Numéro de Carte",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: width / 20,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Color(0x10000000),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: _numTelController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  labelText: (isMoovPay || isMTNPay)
                                      ? "Numéro de paiement"
                                      : "Numéro de Carte",
                                  hintText: (isMoovPay || isMTNPay)
                                      ? "Ex: 64903300"
                                      : "--- --- ---",
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xAAF7941F),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (isVisaPay || isMasterCardPay)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                        width / 30,
                                        width / 30,
                                        0,
                                        width / 30,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date d'expiration",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 30,
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Color(0x10000000),
                                            ),
                                            //margin: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              controller: _numTelController,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20, 10, 20, 10),
                                                labelText: "MM/DD/YY",
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xAAF7941F),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        width / 30,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Code de sécurité",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 30,
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Color(0x10000000),
                                            ),
                                            //margin: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              controller: _numTelController,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                  20,
                                                  10,
                                                  20,
                                                  10,
                                                ),
                                                labelText: "CVC",
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xAAF7941F),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: width / 20,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_phoneNumberRegex
                                .hasMatch(_numTelController.text)) {
                              await _reservationService.reservationUser(
                                codeProgramme!,
                                widget.idClient.toString(),
                                widget.idBus!,
                                widget.nbrePlace.toString(),
                                widget.statutBagage.toString(),
                                widget.startDate.toString(),
                                widget.lieuDepart.toString(),
                                widget.lieuArrivee.toString(),
                                widget.startHour.toString(),
                                null,
                                widget.prix.toString(),
                                _numTelController.text,
                                moyenPaiement,
                              );
                              goToNext(
                                isMoovPay,
                                isMTNPay,
                                isMasterCardPay,
                                isVisaPay,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color(0xFF146CC2),
                                  content: Text(
                                    "Veuillez un numéro correct",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
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
                            "Envoyer",
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

  void goToNext(
    bool isMoovPay,
    bool isMTNPay,
    bool isMasterCardPay,
    bool isVisaPay,
  ) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PaymentState(
          isMoovPay: isMoovPay,
          isMTNPay: isMTNPay,
          isMasterCardPay: isMasterCardPay,
          isVisaPay: isVisaPay,
          isFailled: false,
          montant: widget.prix!,
          datePaiement: DateTime.now(),
        ),
      ),
    );
  }
}
