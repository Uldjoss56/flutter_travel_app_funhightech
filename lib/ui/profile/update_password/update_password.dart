import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/services/user_service.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    super.key,
    this.user,
    required this.success,
  });

  final VoyageClient? user;
  final Function(bool? state) success;

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newConfPasswordController = TextEditingController();

  bool _confNewPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _lastPasswordVisible = false;

  final _userService = UserService();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modification de mot de passe",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: width / 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, width / 15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Text(
                          "Changer votre  ",
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
                          "mot de passe",
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
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color(0x10000000),
                ),
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_lastPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _lastPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFF7941F),
                      ),
                      onPressed: () {
                        setState(() {
                          _lastPasswordVisible = !_lastPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "Ancien mot de passe",
                    hintText: '',
                    labelStyle: const TextStyle(
                      color: Color(0xFF000000),
                    ),
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
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color(0x10000000),
                ),
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_newPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _newPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFF7941F),
                      ),
                      onPressed: () {
                        setState(() {
                          _newPasswordVisible = !_newPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "Nouveau mot de passe",
                    hintText: '',
                    labelStyle: const TextStyle(
                      color: Color(0xFF000000),
                    ),
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
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Color(0x10000000),
                ),
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _newConfPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_confNewPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFF7941F),
                      ),
                      onPressed: () {
                        setState(() {
                          _confNewPasswordVisible = !_confNewPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "Confirmer le mot de passe",
                    hintText: '',
                    labelStyle: const TextStyle(
                      color: Color(0xFF000000),
                    ),
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
              ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text.length >= 6) {
                    if (_newPasswordController.text.length >= 6) {
                      if (_newPasswordController.text ==
                          _newConfPasswordController.text) {
                        await _userService.updateUserPassword(
                          widget.user!.contact,
                          _passwordController.text,
                          _newPasswordController.text,
                        );
                        if (_userService.getMessage() ==
                            "Success password updating") {
                          setState(() {
                            widget.success(true);
                          });
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xFF146CC2),
                              content: Text(
                                _userService.getMessage(),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xFF146CC2),
                            content: Text(
                              "Confirmation : Mot de passe non correspondant",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF146CC2),
                          content: Text(
                            "Nouveau mot de passe très faible",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color(0xFF146CC2),
                        content: Text(
                          "Ancien mot de passe incorrect",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
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
                  "Valider",
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
      ),
    );
  }

  lastPasswordMatching(String lastPassword) {}
}
