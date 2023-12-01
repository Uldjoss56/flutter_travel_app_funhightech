import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/programme.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/home/detail_plan.dart';
import 'package:flutter_travel_app/ui/shapes/shape01.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OffersList extends StatefulWidget {
  const OffersList({
    super.key,
    required this.width,
    required this.index,
  });
  final double width;
  final int index;

  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  List<String>? jours;
  String? nowDate, codeProgramme;
  VoyageProgramme? programme;
  int? _standingPlace, duree;
  double? report;
  final NumberFormat format = NumberFormat("#,###", "fr");
  @override
  void initState() {
    super.initState();
    jours = [
      "lundi",
      "mardi",
      "mercredi",
      "jeudi",
      "vendredi",
      "samedi",
      "dimanche"
    ];

    /*
    Timer.periodic(
      const Duration(seconds: 20),
      (timer) {
        loadDatas();
      },
    );*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDatas();
  }

  void loadDatas() {
    nowDate = "${jours![DateTime.now().weekday - 1]}  "
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

    final model = ScopedModel.of<AppModel>(context);
    programme = model.programmes![widget.index];

    final hoMuSeDepart = programme!.heureDepart.split(":");
    final hoMuSeArrivee = programme!.heureArrivee.split(":");
    final heureD = Duration(
      hours: int.parse(hoMuSeDepart[0]),
      minutes: int.parse(hoMuSeDepart[1]),
      seconds: int.parse(hoMuSeDepart[2]),
    );
    final heureA = Duration(
      hours: int.parse(hoMuSeArrivee[0]),
      minutes: int.parse(hoMuSeArrivee[1]),
      seconds: int.parse(hoMuSeArrivee[2]),
    );
    final Duration duration;
    if (heureA > heureD) {
      duration = heureA - heureD;
    } else {
      duration = const Duration(hours: 24) - heureD + heureA;
    }
    duree = duration.inHours;

    codeProgramme = programme!.codePrograme;
    final nbrePlaceTotal = double.parse(programme!.nbrPlaceTotal);
    final nbreReservation = double.parse(programme!.totalReservation);
    report = nbreReservation / nbrePlaceTotal;
    _standingPlace = (nbrePlaceTotal - nbreReservation).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        widget.width / 80,
        widget.width / 20,
        widget.width / 80,
        widget.width / 40,
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 0, widget.width / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF146CC2),
          width: 3,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            offset: Offset(0, 2),
            blurRadius: 2.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, widget.width / 4, 0, 0),
            padding: EdgeInsets.fromLTRB(
              widget.width / 30,
              0,
              widget.width / 30,
              0,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        widget.width / 100,
                        widget.width / 100,
                        widget.width / 15,
                        widget.width / 100,
                      ),
                      padding: EdgeInsets.only(left: widget.width / 30),
                      child: const Icon(
                        Icons.chair_outlined,
                        color: Color(0xFF146CC2),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: widget.width / 30,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.all(
                                  widget.width / 70,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xFFF7941F),
                                  ),
                                ),
                                child: Text(
                                  "${_standingPlace ?? ""}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.all(widget.width / 100),
                                child: const Text(
                                  " places libres sur ",
                                  style: TextStyle(
                                    color: Color(0xFF146CC2),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.all(widget.width / 70),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xFFF7941F),
                                  ),
                                ),
                                child: Text(
                                  programme!.nbrPlaceTotal,
                                  style: const TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  minHeight: widget.width / 40,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  value: report,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    10,
                    10,
                    10,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xDD333333),
                          ),
                          Text(
                            programme!.lieuDepart,
                            style: const TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xDD146CC2),
                          ),
                          Text(
                            programme!.lieuArrivee,
                            style: const TextStyle(
                              color: Color(0xFF146CC2),
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: widget.width / 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${double.parse(programme!.distance).toInt()} Km",
                        style: const TextStyle(
                          color: Color(0xFFF7941F),
                          fontSize: 22,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(widget.width / 20),
                            child: const WaveAnimation(
                              color: Color(0xFFF7941F),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              widget.width / 10,
                              10,
                              widget.width / 10,
                              10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x55E7E7E8),
                              border: Border.all(
                                color: const Color(0xFFF7941F),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              "${duree.toString()} h en bus !",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(widget.width / 20),
                            child: const WaveAnimation(
                              color: Color(0x44F7941F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (report == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF146CC2),
                          content: Text(
                            "Places complètes",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    } else {
                      final prefs = await SharedPreferences.getInstance();

                      prefs.setString("codeProgramme", codeProgramme!);
                      goToNextPage(codeProgramme!, _standingPlace!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(report == 1 ? 0xFFD0D0D0 : 0xFFF7941F),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(
                      widget.width / 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Réservez ma place",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -widget.width / 30,
            left: -widget.width / 30,
            child: ClipPath(
              clipper: MyShapeClipper02(),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  widget.width / 15,
                  widget.width / 15,
                  widget.width / 30,
                  widget.width / 30,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x00FFFFFF),
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFF146CC2),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  "${format.format(double.parse(programme!.prix).toInt())} Fcfa",
                  style: TextStyle(
                    color: const Color(0xFF146CC2),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: widget.width / 20,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: ClipPath(
              clipper: MyShapeClipper(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF146CC2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  nowDate ?? "",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void goToNextPage(String codeProgramme, int standingPlace) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailPlan(
          codeProgramme: codeProgramme,
          nombrePlaceRestant: standingPlace,
        ),
      ),
    );
  }

  Future getProgramPlace() async {}
}
