import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/services/user_service.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({
    super.key,
    required this.onRegistrationState,
    this.signByProfile,
    this.user,
  });

  final bool? signByProfile;
  final VoyageClient? user;

  final Function(bool? state) onRegistrationState;
  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numWhathController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _userMailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _phoneNumberRegex = RegExp(r'^\d{8}$');
  final _emailRegex = RegExp(r'^[a-z0-9._%+_]+@[a-z0-9.-]+\.[a-z]{2,6}$');

  final TextEditingController _numTelController = TextEditingController();

  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _userNameController.text = "${widget.user!.prenom} ${widget.user!.nom}";
      _userMailController.text = widget.user!.email;
      _numTelController.text = widget.user!.contact;
      _numWhathController.text = widget.user!.whatsapp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                width / 15,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        widget.user == null
                            ? "Renseignez vos "
                            : "Changer vos  ",
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
                        widget.user == null ? "coordonnées " : "informations",
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "  Champs obligatoire  ";
                  }
                  return null;
                },
                controller: _userNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Nom & Prénom *  ",
                  hintText: "Ex: KARIM Ahossi Elodie",
                  errorStyle: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xAAF7941F),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            /*
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0x10000000),
              ),
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Champs obligatoire";
                  }
                  return null;
                },
                controller: _userFirstNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Prénom *  ",
                  hintText: "Ex: Elodie",
                  errorStyle: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xAAF7941F),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            */
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0x10000000),
              ),
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _userMailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Email  ",
                  hintText: 'Ex: elo_kari@gmail.com',
                  errorStyle: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
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
            if (widget.user == null)
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
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "  Numéro de téléphone *  ",
                    hintText: 'Ex: 90907090',
                    errorStyle: TextStyle(
                      backgroundColor: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xAAF7941F),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
                controller: _numWhathController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  labelText: "  Numéro WhatsApp  ",
                  hintText: 'Ex: +229 54548989',
                  errorStyle: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
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
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final phone = _numTelController.text;
                final email = _userMailController.text.toLowerCase();
                if (_phoneNumberRegex.hasMatch(phone) && phone.length == 8) {
                  if (email.isEmpty || _emailRegex.hasMatch(email)) {
                    if (widget.user != null) {
                      final userNames = _userNameController.text.split(" ");
                      String firstName = '';
                      for (int i = 1; i < userNames.length; i++) {
                        if (i == 1) {
                          firstName = userNames[i];
                        } else {
                          firstName = "$firstName ${userNames[i]}";
                        }
                      }
                      await _userService.updateUser(
                        userNames[0],
                        firstName,
                        email,
                        widget.user!.contact,
                        _numWhathController.text,
                      );
                      final message = _userService.getMessage();
                      setState(() {
                        widget.onRegistrationState(
                          message == "Success Updating",
                        );
                      });
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF146CC2),
                          content: Text(
                            _userService.getMessage(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    } else {
                      _showPasswordFormField(width);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color(0xFF146CC2),
                        content: Text(
                          "Email format incorrect",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
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
                        "Numéro incorrect",
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
    );
  }

  void _showPasswordFormField(double width) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetAnimationDuration: const Duration(
            seconds: 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.all(width / 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock,
                  color: Color(0xFFF7941F),
                ),
                Text(
                  "Sécurisez votre compte",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFF7941F),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: width / 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Au moins six(06) caractères', //
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: width / 30,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xAAFFFFFF),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      labelText: "Mot de passe",
                      hintText: '',
                      labelStyle: TextStyle(
                        color: Color(0xFF000000),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
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
                SizedBox(height: width / 80),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 8,
                      vertical: width / 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final email = _userMailController.text.toLowerCase();
                    if (_passwordController.text.length >= 6) {
                      final userNames = _userNameController.text.split(" ");
                      String firstName = '';
                      for (int i = 1; i < userNames.length; i++) {
                        firstName = "$firstName ${userNames[i]}";
                      }
                      firstName.replaceFirst(" ", "", 0);
                      final message = await _userService.registreUser(
                        userNames[0],
                        firstName,
                        email,
                        _numTelController.text,
                        _numWhathController.text,
                        _passwordController.text,
                      );
                      setState(() {
                        widget.onRegistrationState(
                          message == "Success Registration",
                        );
                      });
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xFF146CC2),
                          content: Text(
                            _userService.getMessage(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF146CC2),
                          content: Text(
                            "Au moins 06 caractères",
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
                  child: Text(
                    "Continuer",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: width / 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
