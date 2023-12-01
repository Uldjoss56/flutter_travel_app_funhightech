import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/reservation.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:intl/intl.dart';

class PaymentDetail extends StatefulWidget {
  const PaymentDetail({
    super.key,
    required this.voyageReservation,
    required this.user,
  });

  final VoyageReservation voyageReservation;
  final VoyageClient user;

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  bool isPressedBack = false;
  final NumberFormat format = NumberFormat("#,###", "fr");

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
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.all(width / 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      offset: Offset(0, 2),
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.fromLTRB(width / 40, 0, width / 40, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                right: width / 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: const Text(
                                      "Entreprise",
                                      style: TextStyle(
                                        color: Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Adresse",
                                          style: TextStyle(
                                            color: Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "Arconville, Bénin jgfdfghjgjjnnnnnn j",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: width / 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 05,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Mail",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "contact@gmail.com",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: width / 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 05,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Contact",
                                          style: TextStyle(
                                            color: Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "+229 64548929",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: width / 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: width / 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: const Text(
                                      "Client",
                                      style: TextStyle(
                                        color: Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Nom",
                                    style: TextStyle(
                                      color: Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "${widget.user.nom} ${widget.user.prenom}",
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: width / 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        width / 40,
                        width / 10,
                        width / 40,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: width / 40,
                            ),
                            child: const Text(
                              "Détails de la transaction ",
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Motif : ",
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Ticket de bus  ${widget.voyageReservation.lieuDepart}"
                                    " - ${widget.voyageReservation.lieuArrivee}",
                                    softWrap: true,
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: width / 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Numéro de facture : ",
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    softWrap: true,
                                    "${widget.voyageReservation.codeReservation}",
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: width / 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Date : ",
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "    ${widget.voyageReservation.dateVoyage}",
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: width / 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total de payement : ",
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "XOF ${format.format(double.parse(widget.voyageReservation.prix!).toInt())}",
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: width / 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mode de paiement : ",
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${widget.voyageReservation.moyenPaiement}",
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontSize: width / 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width / 10,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.print,
                          ),
                        ),
                        Text(
                          "Télécharger ma facture",
                          style: TextStyle(
                            color: const Color(0xFF00AA00),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: width / 25,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
