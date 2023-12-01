import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_travel_app/data/programme.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/home/general_info.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:scoped_model/scoped_model.dart';

class ColisReservation extends StatefulWidget {
  const ColisReservation({super.key});

  @override
  State<ColisReservation> createState() => _ColisReservationState();
}

class _ColisReservationState extends State<ColisReservation> {
  int _nbreColis = 1;
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 1;

  final List<String?> _listOfColis = [];

  String? _lieuDepart;

  final CarouselController _carouselController = CarouselController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _numRecepteurController = TextEditingController();

  final TextEditingController _destinationController = TextEditingController();

  final _phoneNumberRegex = RegExp(r'^\d{8}$');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(width / 40),
                  decoration: const BoxDecoration(
                    color: Color(0xAAF7941F),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: _nbreColis,
                    //scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                          width / 160,
                          width / 40,
                          width / 160,
                          width / 40,
                        ),
                        padding: EdgeInsets.fromLTRB(
                          width / 20,
                          width / 40,
                          width / 20,
                          width / 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Colis ${index + 1}",
                              style: TextStyle(
                                color: const Color(0xAAF7941F),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: width / 30,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width / 20,
                                vertical: width / 480,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xAAD0D0D0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_listOfColis.length - 1 < index ||
                                      _listOfColis.isEmpty) {
                                    _listOfColis.add(value);
                                  } else {
                                    _listOfColis[index] = value;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: "Nom",
                                  hintText: "Ex: Sac de voyage",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index + 1;
                        });
                      },
                      //autoPlay: true,
                      height: width,
                      viewportFraction: 0.9,
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(width / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: _nbreColis > 1
                            ? () {
                                setState(
                                  () {
                                    _currentIndex--;
                                    _nbreColis--;
                                    _carouselController.previousPage();
                                  },
                                );
                              }
                            : null,
                        icon: const Icon(
                          FontAwesome.minus,
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: _currentIndex == _nbreColis
                            ? () {
                                setState(
                                  () {
                                    _currentIndex++;
                                    _nbreColis++;
                                    _carouselController.nextPage();
                                  },
                                );
                              }
                            : null,
                        icon: const Icon(FontAwesome.plus),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(width / 40),
                padding: EdgeInsets.fromLTRB(
                  width / 20,
                  width / 40,
                  width / 20,
                  width / 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(width / 40),
                      child: Text(
                        "Lieu de départ",
                        style: TextStyle(
                          color: const Color(0xAAF7941F),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: width / 30,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: width / 40),
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: width / 480,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xAAD0D0D0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: ScopedModelDescendant<AppModel>(
                        builder: (context, child, model) {
                          if (model.isLoadingProgramme) {
                            model.loadAllProgrammes(null);
                            return const LinearProgressIndicator();
                          } else {
                            List<String> listLieuDepart = [];
                            final listOfPrograms = model.programmes;
                            for (VoyageProgramme program in listOfPrograms!) {
                              if (!listLieuDepart
                                  .contains(program.lieuDepart)) {
                                listLieuDepart.add(program.lieuDepart);
                              }
                            }
                            final programsStartPlacesList = listLieuDepart.map(
                              (lieu) {
                                return DropdownMenuItem(
                                  value: lieu,
                                  child: Text(lieu),
                                );
                              },
                            ).toList();
                            _lieuDepart = listLieuDepart[0];
                            return DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              value: listOfPrograms[0].lieuDepart,
                              onChanged: (value) {
                                _lieuDepart = value;
                              },
                              items: programsStartPlacesList,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(width / 40),
                padding: EdgeInsets.fromLTRB(
                  width / 20,
                  width / 40,
                  width / 20,
                  width / 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(width / 40),
                      child: Text(
                        "Destinataire ",
                        style: TextStyle(
                          color: const Color(0xAAF7941F),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: width / 30,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: width / 40),
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: width / 480,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xAAD0D0D0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Nom",
                          hintText: "Ex : DJOSSOU Venance",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: width / 40),
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: width / 480,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xAAD0D0D0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: TextFormField(
                        controller: _numRecepteurController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Numéro de téléphone * ",
                          hintText: "Ex : +229 60454545",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: width / 40),
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: width / 480,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xAAD0D0D0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: TextFormField(
                        controller: _destinationController,
                        decoration: const InputDecoration(
                          labelText: "Adresse de réception * ",
                          hintText: "Ex : Natitingou",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width / 16,
              ),
              ElevatedButton(
                onPressed: () {
                  final phone = _numRecepteurController.text;
                  final validator1 =
                      phone.isNotEmpty && _phoneNumberRegex.hasMatch(phone);
                  final validator2 = _listOfColis.isNotEmpty;
                  final validator3 = _destinationController.text.isNotEmpty;
                  if (_formKey.currentState!.validate() && validator1) {
                    if (validator2) {
                      if (validator3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return InfoGeneral(
                                codeProgramme: null,
                                nbrePlace: null,
                                statutBagage: null,
                                startDate: null,
                                startHour: null,
                                lieuDepart: _lieuDepart,
                                isColisRegistration: true,
                                destinationColis: _destinationController.text,
                                listColis: _listOfColis,
                                nomRecepteurColis: _nameController.text,
                                telRecepteurColis: _numRecepteurController.text,
                              );
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xFF146CC2),
                            content: Text(
                              "Entrez le lieu de réception",
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
                            "Entrez le type de colis (nom)",
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
                          "Veuillez entrer un numéro de recepteur valide",
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
                  "Suivant",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: width / 20,
                  ),
                ),
              ),
              SizedBox(
                height: width / 16,
              ),
            ],
          ),
        );
      },
    );
  }
}
