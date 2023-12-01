import 'package:flutter/material.dart';
import 'package:flutter_travel_app/services/user_service.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

class UserConnexion extends StatefulWidget {
  const UserConnexion({
    super.key,
    required this.width,
    required this.onConnexionState,
  });

  final double width;
  final Function(bool? status) onConnexionState;

  @override
  State<UserConnexion> createState() => _UserConnexionState();
}

class _UserConnexionState extends State<UserConnexion> {
  bool isPressedBack = false;

  final TextEditingController _numTelController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  final _phoneNumberRegex = RegExp(r'^\d{8}$');

  final _formKey = GlobalKey<FormState>();

  final _userService = UserService();

  String? _message;

  String? token;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    return Column(
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
                    "Confirmer votre ",
                    style: TextStyle(
                      color: const Color(0xFF146CC2),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: width / 20,
                    ),
                  ),
                ),
                WidgetSpan(
                  child: Text(
                    "identité ",
                    style: TextStyle(
                      color: const Color(0xFFF7941F),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: width / 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
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
                  keyboardType: TextInputType.name,
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
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    labelText: "Mot de passe",
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFFF7941F),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final phone = _numTelController.text;
            if (_phoneNumberRegex.hasMatch(phone) && phone.length == 8) {
              setState(() {
                isLoading = true;
              });
              await connectUser(
                _numTelController.text,
                _passwordController.text,
              );

              _goToNext();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color(0xAA146CC2),
                  content: Text(
                    "Entrez un numéro correct",
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
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  "Se connecter",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: width / 20,
                  ),
                ),
        ),
        Container(
          margin: EdgeInsets.all(width / 30),
          padding: EdgeInsets.all(width / 30),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFF7941F),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Text(
            "Récupérez-votre compte ?",
            style: TextStyle(
              //color: const Color(0xFFF7941F),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: width / 30,
            ),
          ),
        ),
        SizedBox(
          height: width / 10,
        ),
      ],
    );
  }

  Future connectUser(String phone, String password) async {
    token = await _userService.authenticateUser(phone, password, null);

    _message = _userService.getMessage();
  }

  void _goToNext() {
    final model = ScopedModel.of<AppModel>(context);

    model.loginUser(token!);
    if (_userService.isAuthenticated()) {
      setState(() {
        isLoading = false;
        widget.onConnexionState(true);
      });
    } else {
      if (_message == null || _message == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFFAA0000),
            content: Text(
              "Erreur ",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xAA146CC2),
            content: Text(
              _message!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        );
      }
    }
  }
}
