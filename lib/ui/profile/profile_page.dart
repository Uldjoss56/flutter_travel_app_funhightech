import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/profile/connexion_registration.dart';
import 'package:flutter_travel_app/ui/profile/profile_detail.dart';
import 'package:flutter_travel_app/ui/shapes/bottom_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.isDeconnected,
  });
  final bool? isDeconnected;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _token;

  @override
  void initState() {
    super.initState();

    _loadUserProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ScopedModelDescendant<AppModel>(
            builder: (context, child, model) {
              if (_token == null ||
                  _token == "" ||
                  !model.isValidToken ||
                  (widget.isDeconnected ?? false)) {
                return const ConRegisProfile();
              } else if (!model.isUserConnected) {
                model.loginUser(_token ?? "");
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(width / 10),
                    child: const WaveAnimation(
                      color: Color(0xFFF7941F),
                    ),
                  ),
                );
              } else if (model.connexionMessage != "Success") {
                return Center(
                  child: Card(
                    margin: EdgeInsets.all(width / 10),
                    child: Text(model.connexionMessage),
                  ),
                );
              } else {
                final user = model.user;
                return ProfileDetail(
                  user: user!,
                  ondeconnexion: (deconnected) {
                    if (deconnected == true) {
                      setState(() {
                        _token = "";
                      });
                    }
                  },
                );
              }
            },
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomBar(
              height: 100,
              isTapedProfile: true,
            ),
          ),
        ],
      ),
    );
  }

  void _loadUserProfileInfo() async {
    // ignore: use_build_context_synchronously
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString("userToken") ?? "";
    });
  }
}
