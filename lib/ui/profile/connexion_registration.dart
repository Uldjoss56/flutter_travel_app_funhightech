import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/connexion/user_connexion.dart';
import 'package:flutter_travel_app/ui/profile/profile_page.dart';
import 'package:flutter_travel_app/ui/registration/user_registration.dart';

class ConRegisProfile extends StatefulWidget {
  const ConRegisProfile({super.key});

  @override
  State<ConRegisProfile> createState() => _ConRegisProfileState();
}

class _ConRegisProfileState extends State<ConRegisProfile> {
  bool onTapConnexion = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Material(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              width / 20,
              width / 5,
              width / 20,
              width / 20,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Color(0xFFD0D0D0),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          onTapConnexion = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: !onTapConnexion
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFD0D0D0),
                          boxShadow: !onTapConnexion
                              ? const [
                                  BoxShadow(
                                    color: Color(0x22000000),
                                    offset: Offset(0, 1),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          "Inscrivez-vous",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !onTapConnexion
                                ? const Color(0xFF146CC2)
                                : const Color(0xFF212121),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          onTapConnexion = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: onTapConnexion
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFD0D0D0),
                          boxShadow: onTapConnexion
                              ? const [
                                  BoxShadow(
                                    color: Color(0x22000000),
                                    offset: Offset(0, 1),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          "Connectez-vous",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: onTapConnexion
                                ? const Color(0xFF146CC2)
                                : const Color(0xFF212121),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              onTapConnexion
                  ? UserConnexion(
                      width: width,
                      onConnexionState: (status) {
                        if (status == true) {
                          setState(() {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return const ProfilePage();
                            }));
                          });
                        }
                      },
                    )
                  : UserRegistration(
                      signByProfile: true,
                      onRegistrationState: (value) {
                        if (value == true) {
                          setState(() {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return const ProfilePage();
                            }));
                          });
                        }
                      },
                    ),
              SizedBox(
                height: width / 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
