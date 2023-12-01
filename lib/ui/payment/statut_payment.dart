import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/home/home_page.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentState extends StatefulWidget {
  const PaymentState({
    super.key,
    required this.isMTNPay,
    required this.isMasterCardPay,
    required this.isMoovPay,
    required this.isVisaPay,
    required this.isFailled,
    required this.datePaiement,
    required this.montant,
  });

  final bool isMoovPay;
  final bool isMTNPay;
  final bool isMasterCardPay;
  final bool isVisaPay;
  final bool isFailled;

  final String montant;
  final DateTime datePaiement;

  @override
  State<PaymentState> createState() => _PaymentStateState();
}

class _PaymentStateState extends State<PaymentState> {
  bool isPressedBack = false;

  // ignore: unnecessary_nullable_for_final_variable_declarations
  final String? _profileImagePath = "assets/images/profile.png";

  bool hasSelectedCustomImage = true;
  String? _moyenPaiement;

  @override
  void initState() {
    super.initState();
    _loginUserIfPossible();
    if (widget.isMTNPay) {
      _moyenPaiement = "MTN";
    } else if (widget.isMoovPay) {
      _moyenPaiement = "Moov";
    } else if (widget.isMasterCardPay) {
      _moyenPaiement = "MasterCard";
    } else {
      _moyenPaiement = "Visa";
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isFailled = widget.isFailled;
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
                  isFailled
                      ? GestureDetector(
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
                        )
                      : Container(),
                ],
              ),
            ),
            ScopedModelDescendant<AppModel>(
              builder: (context, child, model) {
                if (!model.isUserConnected) {
                  _loginUserIfPossible();
                  return Center(
                    child: Container(
                      margin: EdgeInsets.all(width / 10),
                      child: const WaveAnimation(
                        color: Color(0xFFF7941F),
                      ),
                    ),
                  );
                } else {
                  final user = model.user;
                  return Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.all(
                            width / 10,
                          ),
                          padding: EdgeInsets.all(
                            width / 20,
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
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
                              _buildContactPicture(),
                              Text(
                                "${user!.nom} ${user.prenom}",
                                style: TextStyle(
                                  color: const Color(0xFF146CC2),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  fontSize: width / 20,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: width / 20),
                                child: Text(
                                  user.email,
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: width / 25,
                                  ),
                                ),
                              ),
                              isFailled
                                  ? Container(
                                      padding: EdgeInsets.all(width / 40),
                                      margin: EdgeInsets.fromLTRB(
                                        width / 8,
                                        width / 40,
                                        width / 8,
                                        width / 40,
                                      ),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xFFDD0000),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Echoué",
                                            style: TextStyle(
                                              color: const Color(0xFFFFFFFF),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 20,
                                            ),
                                          ),
                                          Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                            size: width / 15,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(width / 40),
                                      margin: EdgeInsets.fromLTRB(
                                        width / 8,
                                        width / 40,
                                        width / 8,
                                        width / 40,
                                      ),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xFF00AA00),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Effectué",
                                            style: TextStyle(
                                              color: const Color(0xFFFFFFFF),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: width / 20,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.system_security_update_good,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                              Container(
                                padding: EdgeInsets.all(width / 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Montant payé : ",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "XOF ${widget.montant} ",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: width / 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width / 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date du payement : ",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${widget.datePaiement.year}-"
                                        "${widget.datePaiement.month}-"
                                        "${widget.datePaiement.day}  "
                                        "${widget.datePaiement.hour}:"
                                        "${widget.datePaiement.minute}:"
                                        "${widget.datePaiement.second}",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: width / 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width / 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Moyen de paiement : ",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _moyenPaiement ?? "",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: width / 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            width / 10,
                            0,
                            width / 10,
                            width / 10,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              isFailled
                                  ? Navigator.of(context).pop()
                                  /*
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const ReserveTravel(
                                      isFirstTime: false,
                                    ),
                                  ),
                                )
                              */
                                  : Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => const HomePage(),
                                      ),
                                      (route) => false,
                                    );
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
                              isFailled ? "Réessayer" : "Terminer",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: width / 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width / 10,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 3;
    return CircleAvatar(
      radius: halfScreenDiameter / 2,
      child: _buildCircleAvatarContent(halfScreenDiameter),
    );
  }

  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (_profileImagePath == null) {
      return Icon(
        Icons.person,
        size: halfScreenDiameter / 2,
      );
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Image.asset(
              _profileImagePath!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  Future _loginUserIfPossible() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("userToken") ?? "";

    // ignore: use_build_context_synchronously
    final model = ScopedModel.of<AppModel>(context);

    if (token.isNotEmpty && !model.isUserConnected) {
      final jwtData = jwtDecode(token);
      if (!jwtData.isExpired!) {
        await model.loginUser(token);
      }
    }
  }
}
