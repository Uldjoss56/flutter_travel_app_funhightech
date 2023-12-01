import 'package:flutter/material.dart';

class MakeReservationPage extends StatefulWidget {
  const MakeReservationPage({super.key});

  @override
  State<MakeReservationPage> createState() => _MakeReservationPageState();
}

class _MakeReservationPageState extends State<MakeReservationPage> {
  bool isTappedOneWay = true;
  bool isTappedRoundTrip = false;
  List<String> startPosition = [
    "Ma position actuelle",
    "Calavi",
    "Porto-Novo",
    "Cotonou",
    "Parakou",
    "Lokossa",
  ];
  final _startDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDayController.text = "Mercredi, 30 Août";
  }

  @override
  void dispose() {
    _startDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        /*
        Container(
          margin: EdgeInsets.fromLTRB(width / 20, 20, width / 20, 10),
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
                      isTappedOneWay = true;
                      isTappedRoundTrip = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: isTappedOneWay
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFFD0D0D0),
                      boxShadow: isTappedOneWay
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
                      "Aller uniquement",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isTappedOneWay
                            ? const Color(0xFF146CC2)
                            : const Color(0xFF212121),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isTappedOneWay = false;
                      isTappedRoundTrip = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: isTappedRoundTrip
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFFD0D0D0),
                      boxShadow: isTappedRoundTrip
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
                      "Aller - Retour",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isTappedRoundTrip
                            ? const Color(0xFF146CC2)
                            : const Color(0xFF212121),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        */
        Container(
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  width / 20,
                  05,
                  width / 20,
                  width / 10,
                ),
                padding: EdgeInsets.fromLTRB(20, 20, 20, width / 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E7E8),
                  border: Border.all(
                    color: const Color(0xFF146CC2),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: "Calavi",
                        items: startPosition.map(
                          (label) {
                            return DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(
                            () {},
                          );
                        },
                        decoration: const InputDecoration(
                          labelText: "Ma position",
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF146CC2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: "Lokossa",
                        items: startPosition.map(
                          (label) {
                            return DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(
                            () {},
                          );
                        },
                        decoration: const InputDecoration(
                          labelText: "Ma destination",
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF146CC2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: TextFormField(
                        controller: _startDayController,
                        decoration: const InputDecoration(
                          labelText: 'Ma date de départ',
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: Color(0xFF146CC2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (date != null) {
                            // ignore: use_build_context_synchronously
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(DateTime.now()),
                            );
                            if (time != null) {
                              setState(
                                () {
                                  // _startTaskDay = DateTime(
                                  //   date.year,
                                  //   date.month,
                                  //   date.day,
                                  //   time.hour,
                                  //   time.minute,
                                  // );
                                  // _startDayController.text =
                                  //     DateFormat.yMd().add_jm().format(
                                  //           _startTaskDay,
                                  //         );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -width / 200,
                left: width / 5,
                right: width / 5,
                child: ElevatedButton(
                  onPressed: _subscribeATravel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF146CC2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Soumettre un trajet",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _subscribeATravel() {}
}
