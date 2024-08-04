// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:galaxy_planets/screens/pages/detail_page.dart';
import 'package:galaxy_planets/utils/height_width.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //
  Future<List> loadJsonData() async {
    String planetMap = await rootBundle.loadString("assets/json/data.json");
    Map galaxyPlanets = jsonDecode(planetMap);
    List Planets = galaxyPlanets['planets'];
    return Planets;
  }

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: FutureBuilder(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List? data = snapshot.data;
            return Container(
              height: getHeight(context),
              width: getWidth(context),
              padding:
                  const EdgeInsets.symmetric(vertical: 130, horizontal: 30),
              child: CardSwiper(
                cardBuilder: (context, index, horizontalOffsetPercentage,
                    verticalOffsetPercentage) {
                  return Card(
                    borderOnForeground: false,
                    color: Colors.accents[index],
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.primaries[index],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const Alignment(0, -2),
                            child: Hero(
                              tag: data[index]['name'],
                              child: Container(
                                height: 250,
                                width: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      data[index]['image'],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: getHeight(context) / 5.8,
                              ),
                              Text(
                                data[index]['name'],
                                style: const TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  data[index]['description'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: const Alignment(1.2, 1.1),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailPage(data: data[index]);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.accents[index],
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.arrow_right,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                cardsCount: data!.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}

// Center(
//               child: AnimatedBuilder(
//                 animation: animationController,
//                 builder: (_, __) {
//                   return Transform.rotate(
//                     angle: animationController.value * 2 * pi,
//                     child: AllPlanets(data: data),
//                   );
//                 },
//               ),
//             );

class AllPlanets extends StatelessWidget {
  const AllPlanets({
    super.key,
    required this.data,
  });

  final List? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) / 2.3,
      width: getWidth(context),
      decoration: const BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned(
            left: getWidth(context) / 2.8,
            child: PlanetImage(
              data: data,
              index: 0,
            ),
          ),
          Positioned(
            top: getHeight(context) / 10,
            left: 0,
            child: PlanetImage(
              data: data,
              index: 1,
            ),
          ),
          Positioned(
            top: getHeight(context) / 10,
            right: 14,
            child: PlanetImage(
              data: data,
              index: 3,
            ),
          ),
          Positioned(
            top: getHeight(context) / 4,
            left: getWidth(context) / 14,
            child: PlanetImage(
              data: data,
              index: 4,
            ),
          ),
          Positioned(
            top: getHeight(context) / 4,
            right: getWidth(context) / 14,
            child: PlanetImage(
              data: data,
              index: 5,
            ),
          ),
          Positioned(
            bottom: 0,
            left: getWidth(context) / 2.7,
            child: PlanetImage(
              data: data,
              index: 6,
            ),
          ),
          // Earth
          Positioned(
            top: getHeight(context) / 6.4,
            left: getWidth(context) / 2.7,
            child: PlanetImage(
              data: data,
              index: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class PlanetImage extends StatelessWidget {
  const PlanetImage({
    super.key,
    required this.data,
    required this.index,
  });

  final int index;
  final List? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print(data![index]);

        ///
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DetailPage(
              data: data![index],
            );
          },
        ));
      },
      child: Hero(
        tag: data![index]['name'],
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                data![index]['image'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
