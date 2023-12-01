import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/programme.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/home/home_page.dart';
import 'package:flutter_travel_app/ui/payment/payment_mode.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class ReserveTravel extends StatefulWidget {
  const ReserveTravel({
    super.key,
    required this.codeProgramme,
    required this.nbrePlace,
    required this.statutBagage,
    required this.startDate,
    required this.startHour,
    required this.lieuArrivee,
    required this.lieuDepart,
    required this.prix,
  });
  final int? nbrePlace;
  final bool? statutBagage;

  final String? codeProgramme, startDate, startHour;
  final String? prix, lieuDepart, lieuArrivee;

  @override
  State<ReserveTravel> createState() => _ReserveTravelState();
}

class _ReserveTravelState extends State<ReserveTravel> {
  bool isPressedBack = false;

  bool isMoovPay = false;
  bool isMTNPay = false;
  bool isMasterCardPay = false;
  bool isVisaPay = false;

  String? _idClient;

  String? _idBus;
  final NumberFormat format = NumberFormat("#,###", "fr");

  @override
  void initState() {
    super.initState();
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
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) {
                          return const HomePage();
                        },
                      ),
                    ),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: width / 50,
                      ),
                      child: ScopedModelDescendant<AppModel>(
                        builder: (context, child, model) {
                          final VoyageProgramme programme;
                          if (model.isLoadingProgramme) {
                            model.loadAllProgrammes(widget.codeProgramme);
                            return Container(
                              margin: EdgeInsets.all(width / 10),
                              child: const WaveAnimation(
                                color: Color(0xFFF7941F),
                              ),
                            );
                          } else {
                            programme = model.programmes![0];
                            _idClient = (model.user?.contact ?? "");
                            _idBus = programme.idBus;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0, width / 20, 0, 0),
                                  padding: EdgeInsets.fromLTRB(
                                    width / 30,
                                    width / 30,
                                    width / 30,
                                    width / 30,
                                  ),
                                  child: Text(
                                    programme.lieuDepart,
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 25,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0, width / 20, 0, 0),
                                  padding: EdgeInsets.fromLTRB(
                                    width / 30,
                                    width / 30,
                                    width / 30,
                                    width / 30,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFF7941F),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    "XOF ${format.format(double.parse(programme.prix).toInt())}",
                                    style: TextStyle(
                                      color: const Color(0xFFF7941F),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0, width / 20, 0, 0),
                                  padding: EdgeInsets.fromLTRB(
                                    width / 30,
                                    width / 30,
                                    width / 30,
                                    width / 30,
                                  ),
                                  child: Text(
                                    programme.lieuArrivee,
                                    style: TextStyle(
                                      color: const Color(0xFF212121),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 25,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        width / 50,
                      ),
                      child: Column(
                        children: [
                          /*
                          (isFirstTime != null)
                              ? ((isFirstTime && !(_registrationState ?? false))
                                  ? UserRegistration(
                                      idProgramme: widget.idProgramme,
                                      nbrePlace: widget.nbrePlace,
                                      onRegistrationState: (value) {
                                        _registrationState = value;
                                      },
                                    )
                                  : UserConnexion(
                                      width: width,
                                    ))
                              : const SizedBox(),
                          */
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              width / 15,
                              0,
                              width / 15,
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Text(
                                      "Choisissez votre ",
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
                                      "moyen ",
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
                                      "de ",
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
                                      "paiement ",
                                      style: TextStyle(
                                        color: const Color(0xFFF7941F),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isMTNPay = false;
                                      isMasterCardPay = false;
                                      isVisaPay = false;
                                      isMoovPay = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(width / 60),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: isMoovPay
                                          ? const Color(0xFFE7E7E8)
                                          : Colors.transparent,
                                    ),
                                    child: Image.asset(
                                      "assets/images/moov0africa_logo.png",
                                      width: width / 6,
                                      height: width / 6,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isMTNPay = false;
                                      isMasterCardPay = false;
                                      isMoovPay = false;
                                      isVisaPay = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(width / 60),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: isVisaPay
                                          ? const Color(0xFFE7E7E8)
                                          : Colors.transparent,
                                    ),
                                    child: Image.asset(
                                      "assets/images/visa_logo.png",
                                      width: width / 6,
                                      height: width / 6,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isMoovPay = false;
                                      isMasterCardPay = false;
                                      isVisaPay = false;
                                      isMTNPay = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(width / 60),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: isMTNPay
                                          ? const Color(0xFFE7E7E8)
                                          : Colors.transparent,
                                    ),
                                    child: ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFFFFBD06),
                                        BlendMode.srcIn,
                                      ),
                                      child: Image.asset(
                                        "assets/images/mtn_logo.png",
                                        width: width / 6,
                                        height: width / 6,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isMTNPay = false;
                                      isMoovPay = false;
                                      isVisaPay = false;
                                      isMasterCardPay = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(width / 60),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: isMasterCardPay
                                          ? const Color(0xFFE7E7E8)
                                          : Colors.transparent,
                                    ),
                                    child: Image.asset(
                                      "assets/images/master0card_logo.png",
                                      width: width / 6,
                                      height: width / 6,
                                    ),
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
                              if (isMTNPay ||
                                  isMasterCardPay ||
                                  isMoovPay ||
                                  isVisaPay) {
                                goToPay();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 92, 169, 247),
                                    content: Text(
                                      "Aucun choix effectué",
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
                              backgroundColor: const Color(0xFFF7941F),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: width / 4,
                                vertical: width / 30,
                              ),
                            ),
                            child: Text(
                              "Soumettre",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
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
            ),
          ],
        ),
      ),
    );
  }

  void goToPay() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PaymentMode(
          codeProgramme: widget.codeProgramme,
          isMoovPay: isMoovPay,
          isMTNPay: isMTNPay,
          isMasterCardPay: isMasterCardPay,
          isVisaPay: isVisaPay,
          idClient: _idClient,
          idBus: _idBus ?? "",
          nbrePlace: widget.nbrePlace!,
          statutBagage: widget.statutBagage!,
          startDate: widget.startDate,
          startHour: widget.startHour,
          lieuDepart: widget.lieuDepart,
          lieuArrivee: widget.lieuArrivee,
          prix: widget.prix,
        ),
      ),
    );
  }
}
