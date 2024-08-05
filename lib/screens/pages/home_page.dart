// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:galaxy_planets/provider/like_provider.dart';
import 'package:galaxy_planets/provider/theme_provider.dart';
import 'package:galaxy_planets/screens/pages/detail_page.dart';
import 'package:galaxy_planets/utils/height_width.dart';
import 'package:provider/provider.dart';

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

  List themeList = [
    "Light",
    "Dark",
    "System",
  ];

  String defaultThemeMode = "Light";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green[100]),
                margin: EdgeInsets.zero,
                currentAccountPicture: const CircleAvatar(),
                accountName: const Text(
                  "Prince Patel",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: const Text(
                  "princepatel699@gmail.com",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 20),
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Theme Mode",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Icon(Icons.dark_mode),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  ...List.generate(
                    themeList.length,
                    (index) => RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(themeList[index]),
                      value: themeList[index],
                      groupValue:
                          Provider.of<ThemeProvider>(context).defaultThemeMode,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleThemeMode(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const LikedPlanetsItemAlertBox();
                  },
                );
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(context) / 20),
                margin: const EdgeInsets.only(bottom: 10),
                height: getHeight(context) / 14,
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Liked Planets",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Icon(Icons.favorite),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 20),
              margin: const EdgeInsets.only(bottom: 10),
              height: getHeight(context) / 14,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Settings",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  Icon(Icons.settings),
                ],
              ),
            ),
          ],
        ),
      ),
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

class LikedPlanetsItemAlertBox extends StatefulWidget {
  const LikedPlanetsItemAlertBox({
    super.key,
  });

  @override
  State<LikedPlanetsItemAlertBox> createState() =>
      _LikedPlanetsItemAlertBoxState();
}

class _LikedPlanetsItemAlertBoxState extends State<LikedPlanetsItemAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text("Liked Planets"),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (Provider.of<LikeProvider>(context).likedData.isEmpty)
              ? Container(
                  height: getHeight(context) / 3,
                  alignment: Alignment.center,
                  child: const Text("No liked planets..."),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      Provider.of<LikeProvider>(context).likedData.length,
                      (index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    data: Provider.of<LikeProvider>(context)
                                        .likedData[index]),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              Provider.of<LikeProvider>(context)
                                  .likedData[index]['image'],
                            ),
                          ),
                          title: Text(
                            Provider.of<LikeProvider>(context).likedData[index]
                                ['name'],
                          ),
                          subtitle: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            Provider.of<LikeProvider>(context).likedData[index]
                                ['description'],
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  Provider.of<LikeProvider>(
                                    context,
                                    listen: false,
                                  ).likedData.removeAt(index);
                                  setState(() {});
                                },
                                child: const Text("Remove"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
          // Text(
          //     Provider.of<LikeProvider>(context)
          //         .likedData
          //         .toString(),
          //   ),
        ],
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
