import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/profile/profile_page.dart';
import 'package:flutter_travel_app/ui/profile/update_password/update_password.dart';
import 'package:flutter_travel_app/ui/profile/update_profile/update_profil_page.dart';
import 'package:flutter_travel_app/ui/shapes/profile_container_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({
    super.key,
    required this.user,
    required this.ondeconnexion,
  });
  final VoyageClient user;
  final Function(bool? deconnected) ondeconnexion;

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  // ignore: unused_field
  String? _profileImagePath;
  final ScrollController _scrollController = ScrollController();
  double _profileImageSize = 200.0;
  final double _minProfileImageSize = 100.0;

  bool isEditMode = false;

  File? _profileImageFile;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _profileImageSize = 200.0 - _scrollController.offset;

        if (_profileImageSize < _minProfileImageSize) {
          _profileImageSize = 0.0;
        }

        if (_profileImageSize < _minProfileImageSize) {
          _profileImageSize = _minProfileImageSize;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final user = widget.user;
    return Column(
      children: [
        Container(
          color: const Color(0xFF146CC2),
          height: width / 20,
        ),
        Expanded(
          child: Container(
            color: const Color(0xFF146CC2),
            child: ListView(
              controller: _scrollController,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: width / 20,
                    ),
                    _buildContactPicture(),
                    SizedBox(
                      height: width / 20,
                    ),
                    if (user.prenom.isNotEmpty || user.nom.isNotEmpty)
                      Container(
                        padding: EdgeInsets.only(bottom: width / 20),
                        child: Text(
                          "${user.prenom}  ${user.nom}",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: width / 20,
                          ),
                        ),
                      ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Complete your profile",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: width / 25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: width / 25,
                          ),
                        ),
                      ],
                    ),
                    */
                    if (user.email.isNotEmpty)
                      Container(
                        padding: EdgeInsets.only(bottom: width / 20),
                        child: Text(
                          user.email.isEmpty ? "" : user.email,
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: width / 25,
                          ),
                        ),
                      ),
                  ],
                ),
                ClipPath(
                  clipper: ProfileContainerClipper(),
                  child: Container(
                    color: const Color(0xFFE7E7E8),
                    constraints: BoxConstraints(
                      minWidth: width,
                      minHeight: height / 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(width / 30),
                          child: Center(
                            child: Text(
                              user.contact,
                              style: TextStyle(
                                color: const Color(0xFF146CC2),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: width / 25,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width / 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(width / 20, 0, 0, 0),
                              child: Text(
                                "Mon compte",
                                style: TextStyle(
                                  color: const Color(0xFF146CC2),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: width / 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: width / 10),
                              color: const Color(0xFFD0D0D0),
                              height: 2,
                            ),
                            SizedBox(
                              height: width / 20,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(width / 12, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => UpdateProfilePage(
                                            user: widget.user,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Changer les informations de profil",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => UpdatePassword(
                                              user: widget.user,
                                              success: (state) async {
                                                await logOutTreatment();
                                              }),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Changer son mot de passe",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await logOutTreatment();
                                    },
                                    child: Text(
                                      "Se déconnecter",
                                      style: TextStyle(
                                        color: const Color(0xFF212121),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: width / 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: width / 40,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(width / 20, 0, 0, 0),
                              child: Text(
                                "Paramètres",
                                style: TextStyle(
                                  color: const Color(0xFF146CC2),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: width / 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: width / 10),
                              color: const Color(0xFFD0D0D0),
                              height: 2,
                            ),
                            SizedBox(
                              height: width / 20,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              margin: EdgeInsets.fromLTRB(width / 12, 0, 0, 0),
                              child: TextButton(
                                onPressed: null,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Langage",
                                          style: TextStyle(
                                            color: const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: width / 25,
                                          ),
                                        ),
                                        Text(
                                          "Français",
                                          style: TextStyle(
                                            color: const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            fontSize: width / 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(
                                        width / 40,
                                      ),
                                      margin: EdgeInsets.only(left: width / 20),
                                      child: Image.asset(
                                        "assets/images/traduction.png",
                                        height: width / 15,
                                        width: width / 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              margin: EdgeInsets.fromLTRB(width / 12, 0, 0, 0),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Supprimer le compte",
                                  style: TextStyle(
                                    color: const Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: width / 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: width / 20,
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    width / 12, width / 20, 0, 0),
                                child: Text(
                                  "À propos",
                                  style: TextStyle(
                                    color: const Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 15,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: width / 10),
                                color: const Color(0xFFD0D0D0),
                                height: 2,
                              ),
                              SizedBox(
                                height: width / 10,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(width / 12, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        "Signaler un problème",
                                        style: TextStyle(
                                          color: const Color(0xFF212121),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: width / 25,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            "Version",
                                            style: TextStyle(
                                              color: const Color(0xFF212121),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: width / 25,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            "1.0.0",
                                            style: TextStyle(
                                              color: const Color(0xFF212121),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300,
                                              fontSize: width / 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: width / 4,
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> logOutTreatment() async {
    setState(() {
      widget.ondeconnexion(true);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userToken", "");
    goToNext();
  }

  void goToNext() {
    final model = ScopedModel.of<AppModel>(context);

    model.deconnectUser();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return const ProfilePage(
            isDeconnected: true,
          );
        },
      ),
    );
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 3;
    return GestureDetector(
      onTap: _onProfileImageTapped,
      child: CircleAvatar(
        radius: halfScreenDiameter / 2,
        child: ClipOval(
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                _buildCircleAvatarContent(halfScreenDiameter),
                Positioned.fill(
                  child: Container(
                    color: const Color(0x55FFFFFF),
                    child: const Icon(
                      Icons.camera_alt,
                      //color: Color(0xFF146CC2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagePicker imagePicker = ImagePicker();
  void _onProfileImageTapped() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _profileImageFile = File(pickedFile!.path);
    });
  }

  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (widget.user.nom.isNotEmpty && widget.user.prenom.isNotEmpty) {
      return _buildEditModeCircleAvatarContent(halfScreenDiameter);
    } else {
      return Image.asset(
        "assets/images/person.png",
        width: halfScreenDiameter,
        height: halfScreenDiameter,
      );
    }
  }

  Widget _buildEditModeCircleAvatarContent(double halfScreenDiameter) {
    if (_profileImageFile == null) {
      return Center(
        child: Text(
          "${widget.user.prenom[0]}${widget.user.nom[0]}",
          style: TextStyle(
            fontSize: halfScreenDiameter / 2,
            //color: const Color(0xFFFFFFFF),
          ),
        ),
      );
    } else {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _profileImageSize,
        height: _profileImageSize,
        child: Image.file(
          _profileImageFile!,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
