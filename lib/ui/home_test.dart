import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/colis/colis_form.dart';
import 'package:flutter_travel_app/ui/home/offers_page.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/shapes/bottom_bar.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({super.key});

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  bool isTappedProgram = true;

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  final _startDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDayController.text = "Mercredi, 30 Août";
    _loginUserIfPossible();
  }

  @override
  void dispose() {
    _startDayController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: width / 5,
                automaticallyImplyLeading: false,
                expandedHeight: width / 3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1,
                  title: Container(
                    margin: EdgeInsets.fromLTRB(
                      width / 20,
                      0,
                      width / 20,
                      0,
                    ),
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 142, 78, 0),
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
                                isTappedProgram = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: isTappedProgram
                                    ? const Color(0xFFF7941F)
                                    : const Color.fromARGB(255, 142, 78, 0),
                                boxShadow: isTappedProgram
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
                                "Programme",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isTappedProgram
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFFD0D0D0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
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
                                isTappedProgram = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: !isTappedProgram
                                    ? const Color(0xFFF7941F)
                                    : const Color.fromARGB(255, 142, 78, 0),
                                boxShadow: !isTappedProgram
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
                                "Colis",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !isTappedProgram
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFFD0D0D0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
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
              SliverList.list(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      width / 20,
                      0,
                      width / 5,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: ScopedModelDescendant<AppModel>(
                      builder: (BuildContext context, Widget? child,
                          AppModel model) {
                        if (model.isLoadingProgramme) {
                          model.loadAllProgrammes(null);
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(width / 10),
                              child: const WaveAnimation(
                                color: Color(0xFFF7941F),
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE7E7E8),
                                  borderRadius: BorderRadius.all(
                                    !isTappedProgram
                                        ? const Radius.circular(0)
                                        : const Radius.circular(30),
                                  ),
                                ),
                                child: CarouselSlider.builder(
                                  itemCount: !isTappedProgram
                                      ? 1
                                      : model.programmes!.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return !isTappedProgram
                                        ? const ColisReservation()
                                        : (model.programmes!.isNotEmpty
                                            ? OffersList(
                                                width: width,
                                                index: index,
                                              )
                                            : Center(
                                                child: Text(
                                                  "Nothing yet",
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF146CC2),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: width / 12,
                                                  ),
                                                ),
                                              ));
                                  },
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                    height: !isTappedProgram
                                        ? 1.55 * width
                                        : 5 * width / 4,
                                    viewportFraction:
                                        !isTappedProgram ? 1 : 0.9,
                                    aspectRatio: 16 / 9,
                                    initialPage: 0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: width / 80,
                              ),
                              isTappedProgram
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: _currentIndex > 0
                                                    ? const Color(0xFF146CC2)
                                                    : const Color(0xFFD0D0D0),
                                                width: 2,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_back,
                                              ),
                                              color: const Color(0xFF146CC2),
                                              onPressed: _currentIndex > 0
                                                  ? () {
                                                      setState(() {
                                                        _currentIndex--;
                                                        _carouselController
                                                            .previousPage();
                                                      });
                                                    }
                                                  : null,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: _currentIndex <
                                                        model.programmes!
                                                                .length -
                                                            1
                                                    ? const Color(0xFF146CC2)
                                                    : const Color(0xFFD0D0D0),
                                                width: 2,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_forward,
                                              ),
                                              color: _currentIndex <
                                                      model.programmes!.length -
                                                          1
                                                  ? const Color(0xFF146CC2)
                                                  : null,
                                              onPressed: _currentIndex <
                                                      model.programmes!.length -
                                                          1
                                                  ? () {
                                                      setState(
                                                        () {
                                                          _currentIndex++;
                                                          _carouselController
                                                              .nextPage();
                                                        },
                                                      );
                                                    }
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomBar(
              height: 0,
              isTapedHome: true,
            ),
          ),
        ],
      ),
    );
  }

  void onPressedReserv() {}

  Future _loginUserIfPossible() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("userToken") ?? "";

    // ignore: use_build_context_synchronously
    final model = ScopedModel.of<AppModel>(context);

    if (token.isNotEmpty && !model.isUserConnected) {
      final jwtData = jwtDecode(token);
      if (!jwtData.isExpired!) {
        await model.loginUser(token);
      }
    }
  }
}

/*
class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percentage =
        1.0 - (shrinkOffset / (200.0 - kToolbarHeight)).clamp(0.0, 1.0);

    double newSize = 56.0 + (150.0 - 56.0) * percentage;

    return SizedBox(
      height: newSize,
      child: AppBar(
        title: const Text(''),
        backgroundColor: Colors.blue, // Couleur de fond de l'AppBar réduite
      ),
    );
  }

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => kToolbarHeight + 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/colis/colis_form.dart';
import 'package:flutter_travel_app/ui/shapes/bottom_bar.dart';
import 'package:flutter_travel_app/ui/home/offers_page.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTappedProgram = true;

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  final _startDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDayController.text = "Mercredi, 30 Août";
    _loginUserIfPossible();
    setState(() {
      print("Hello");
    });
  }

  @override
  void dispose() {
    _startDayController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Material(
                elevation: 10,
                shadowColor: const Color(0xAA000000),
                color: const Color(0xFFF7941F),
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
                      color: Color.fromARGB(255, 142, 78, 0),
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
                                isTappedProgram = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: isTappedProgram
                                    ? const Color(0xFFF7941F)
                                    : const Color.fromARGB(255, 142, 78, 0),
                                boxShadow: isTappedProgram
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
                                "Programme",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isTappedProgram
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFFD0D0D0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
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
                                isTappedProgram = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: !isTappedProgram
                                    ? const Color(0xFFF7941F)
                                    : const Color.fromARGB(255, 142, 78, 0),
                                boxShadow: !isTappedProgram
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
                                "Colis",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !isTappedProgram
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFFD0D0D0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
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
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 80,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      ScopedModelDescendant<AppModel>(
                        builder: (BuildContext context, Widget? child,
                            AppModel model) {
                          if (model.isLoadingProgramme) {
                            model.loadAllProgrammes(null);

                            return Center(
                              child: Container(
                                margin: EdgeInsets.all(width / 10),
                                child: const WaveAnimation(
                                  color: Color(0xFFF7941F),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE7E7E8),
                                    borderRadius: BorderRadius.all(
                                      !isTappedProgram
                                          ? const Radius.circular(0)
                                          : const Radius.circular(30),
                                    ),
                                  ),
                                  child: CarouselSlider.builder(
                                    itemCount: !isTappedProgram
                                        ? 1
                                        : model.programmes!.length,
                                    itemBuilder: (context, index, realIndex) {
                                      return !isTappedProgram
                                          ? const ColisReservation()
                                          : (model.programmes!.isNotEmpty
                                              ? OffersList(
                                                  width: width,
                                                  index: index,
                                                )
                                              : Center(
                                                  child: Text(
                                                    "Nothing yet",
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xFF146CC2),
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width / 12,
                                                    ),
                                                  ),
                                                ));
                                    },
                                    carouselController: _carouselController,
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                      height: !isTappedProgram
                                          ? 1.55 * width
                                          : 5 * width / 4,
                                      viewportFraction:
                                          !isTappedProgram ? 1 : 0.9,
                                      aspectRatio: 16 / 9,
                                      initialPage: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: width / 80,
                                ),
                                isTappedProgram
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: _currentIndex > 0
                                                      ? const Color(0xFF146CC2)
                                                      : const Color(0xFFD0D0D0),
                                                  width: 2,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_back,
                                                ),
                                                color: const Color(0xFF146CC2),
                                                onPressed: _currentIndex > 0
                                                    ? () {
                                                        setState(() {
                                                          _currentIndex--;
                                                          _carouselController
                                                              .previousPage();
                                                        });
                                                      }
                                                    : null,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: _currentIndex <
                                                          model.programmes!
                                                                  .length -
                                                              1
                                                      ? const Color(0xFF146CC2)
                                                      : const Color(0xFFD0D0D0),
                                                  width: 2,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_forward,
                                                ),
                                                color: _currentIndex <
                                                        model.programmes!
                                                                .length -
                                                            1
                                                    ? const Color(0xFF146CC2)
                                                    : null,
                                                onPressed: _currentIndex <
                                                        model.programmes!
                                                                .length -
                                                            1
                                                    ? () {
                                                        setState(
                                                          () {
                                                            _currentIndex++;
                                                            _carouselController
                                                                .nextPage();
                                                          },
                                                        );
                                                      }
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: width / 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomBar(
              height: 0,
              isTapedHome: true,
            ),
          ),
        ],
      ),
    );
  }

  void onPressedReserv() {}

  Future _loginUserIfPossible() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("userToken") ?? "";

    // ignore: use_build_context_synchronously
    final model = ScopedModel.of<AppModel>(context);

    if (token.isNotEmpty && !model.isUserConnected) {
      final jwtData = jwtDecode(token);
      if (!jwtData.isExpired!) {
        await model.loginUser(token);
      }
    }
  }
}

*/