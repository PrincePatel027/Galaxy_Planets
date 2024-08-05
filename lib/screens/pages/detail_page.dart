import 'package:flutter/material.dart';
import 'package:galaxy_planets/provider/like_provider.dart';
import 'package:galaxy_planets/utils/height_width.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.data,
  });

  final Map data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isLiked = false;

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

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.data['name'],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<LikeProvider>(context).likedData.contains(widget.data)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              Provider.of<LikeProvider>(context, listen: false)
                  .toogleLike(widget.data);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) / 40),
        child: Column(
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
                      image: AssetImage(widget.data['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context) / 40,
              ),
              child: Text(
                widget.data['description'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
