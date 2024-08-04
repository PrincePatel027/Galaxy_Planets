import 'package:flutter/material.dart';
import 'package:galaxy_planets/utils/height_width.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  State<DetailPage> createState() => _FirstDetailPageState();
}

class _FirstDetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.data['name']),
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.data['name'],
            child: RotationTransition(
              turns: animationController,
              child: Container(
                height: getHeight(context) / 2.4,
                width: getWidth(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      widget.data['image'],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context) / 40),
            child: Text(
              textAlign: TextAlign.center,
              widget.data['description'],
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
