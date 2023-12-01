import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/programme.dart';
import 'package:flutter_travel_app/services/programme_service.dart';
import 'package:flutter_travel_app/ui/home/general_info.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailPlan extends StatefulWidget {
  const DetailPlan({
    super.key,
    required this.codeProgramme,
    required this.nombrePlaceRestant,
  });

  final String codeProgramme;
  final int nombrePlaceRestant;
  @override
  State<DetailPlan> createState() => _DetailPlanState();
}

class _DetailPlanState extends State<DetailPlan> {
  bool _isPressedBack = false;

  List<String> _existingHoursRecord = [""];

  String? _startHour = "";

  List<int> _existingPlceRecord = List.empty();

  int _nbrePlace = 1;

  String? _bagageUser;

  final List<String> _weekDays = [
    "lun",
    "mar",
    "mer",
    "jeu",
    "ven",
    "sam",
    "dim"
  ];

  final List<String> _months = [
    "jan",
    "fev",
    "mars",
    "avr",
    "mai",
    "juin",
    "jui",
    "août",
    "sep",
    "oct",
    "nov",
    "dec"
  ];

  String? _startDay;

  VoyageProgramme? _programme;

  final ProgrammeService _programmeService = ProgrammeService();

  @override
  void initState() {
    super.initState();
    final standingPlaces = widget.nombrePlaceRestant;
    final codeProgramme = widget.codeProgramme;
    _existingPlceRecord = List.generate(standingPlaces, (index) => index);

    _startDay = "${_weekDays[DateTime.now().weekday - 1]}, "
        "${DateTime.now().day.toString().padLeft(2, '0')} "
        "${_months[DateTime.now().month - 1]} "
        "${DateTime.now().year.toString()}";

    final model = ScopedModel.of<AppModel>(context);
    if (model.isLoadingProgramme) {
      model.loadAllProgrammes(codeProgramme);
    } else {
      _programme = model.programmes![0];
    }
    _loadProgramHours(
      _programme!.lieuDepart,
      _programme!.lieuArrivee,
    );
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
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      setState(() {
                        _isPressedBack = true;
                      });
                    },
                    onTapUp: (TapUpDetails details) {
                      setState(() {
                        _isPressedBack = false;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _isPressedBack = false;
                      });
                    },
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          width / 16, 0, 11 * width / 16, 0),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        boxShadow: _isPressedBack
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
                      padding: EdgeInsets.all(
                        width / 20,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, width / 15),
                            child: Text(
                              "Validation",
                              style: TextStyle(
                                color: const Color(0xFF146CC2),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: width / 15,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  right: width / 40,
                                ),
                                child: Text(
                                  "Date de départ :",
                                  style: TextStyle(
                                    color: const Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFF7941F),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          _startDay ?? "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFFF7941F),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: width / 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      elevation: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFF7941F),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            DateTime? date =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );
                                            setState(
                                              () {
                                                _startDay =
                                                    "${_weekDays[date!.weekday - 1]}, "
                                                    "${date.day.toString().padLeft(2, '0')} "
                                                    "${_months[date.month - 1]} "
                                                    "${date.year.toString().padLeft(2, '0')}";
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xFFF7941F),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width / 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Heure de départ :",
                                  style: TextStyle(
                                    color: const Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _existingHoursRecord.isNotEmpty
                                      ? _existingHoursRecord[0]
                                      : null,
                                  items: _existingHoursRecord.map(
                                    (label) {
                                      return DropdownMenuItem(
                                        value: label,
                                        child: Text(label),
                                      );
                                    },
                                  ).toList(),
                                  style: TextStyle(
                                    color: const Color(0xFFF7941F),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 25,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: "Heure",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _startHour = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width / 20,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  "Nombre de place : ",
                                  style: TextStyle(
                                    color: const Color(0xFF212121),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: DropdownButtonFormField<int>(
                                  value: _nbrePlace,
                                  items: _existingPlceRecord.map(
                                    (label) {
                                      return DropdownMenuItem(
                                        value: label + 1,
                                        child: Text("${label + 1}"),
                                      );
                                    },
                                  ).toList(),
                                  style: TextStyle(
                                    color: const Color(0xFFF7941F),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: width / 25,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Places",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _nbrePlace = value!;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width / 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Bagages : ",
                                style: TextStyle(
                                  color: const Color(0xFF212121),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 20,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text(
                                          "Non",
                                          style: TextStyle(
                                            color: _bagageUser == "Non"
                                                ? const Color(0xFFF7941F)
                                                : const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: width / 30,
                                          ),
                                        ),
                                        value: "Non",
                                        groupValue: _bagageUser,
                                        onChanged: handleRadioValueChange,
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text(
                                          "Oui",
                                          style: TextStyle(
                                            color: _bagageUser == "Oui"
                                                ? const Color(0xFFF7941F)
                                                : const Color(0xFF212121),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: width / 30,
                                          ),
                                        ),
                                        value: "Oui",
                                        groupValue: _bagageUser,
                                        onChanged: handleRadioValueChange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width / 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => InfoGeneral(
                                    codeProgramme: widget.codeProgramme,
                                    startDate: _startDay,
                                    startHour: _startHour,
                                    nbrePlace: _nbrePlace,
                                    statutBagage: (_bagageUser == null ||
                                            _bagageUser == "Non")
                                        ? false
                                        : true,
                                    destinationColis: null,
                                    listColis: null,
                                    nomRecepteurColis: null,
                                    telRecepteurColis: null,
                                    isColisRegistration: null,
                                  ),
                                ),
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
                              "Valider",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
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

  handleRadioValueChange(String? value) {
    setState(() {
      _bagageUser = value;
      //widget.onOptionSelected!(_bagageUser);
    });
  }

  Future _loadProgramHours(String lieuDepart, String lieuArrivee) async {
    _existingHoursRecord = await _programmeService.getAllProgrameHours(
      lieuDepart,
      lieuArrivee,
    );
    String currentTime = "${DateTime.now().hour}:${DateTime.now().minute}:"
        "${DateTime.now().second}";

    _existingHoursRecord.sort((a, b) {
      final listA = a.split(":");
      Duration timeA = Duration(
        hours: int.parse(listA[0]),
        minutes: int.parse(listA[1]),
      );
      final listB = b.split(":");
      Duration timeB = Duration(
        hours: int.parse(listB[0]),
        minutes: int.parse(listB[1]),
      );
      final current = currentTime.split(":");
      Duration currentTimeParsed = Duration(
        hours: int.parse(current[0]),
        minutes: int.parse(current[1]),
      );
      Duration? differenceA, differenceB;

      if (timeA < currentTimeParsed) {
        differenceA = const Duration(hours: 24) + timeA - currentTimeParsed;
      } else {
        differenceA = timeA - currentTimeParsed;
      }
      if (timeB < currentTimeParsed) {
        differenceB = const Duration(hours: 24) + timeB - currentTimeParsed;
      } else {
        differenceB = timeB - currentTimeParsed;
      }

      return differenceA.compareTo(differenceB);
    });

    setState(() {
      _startHour = _existingHoursRecord[0];
    });
  }
}
