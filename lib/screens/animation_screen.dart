import 'package:flutter/material.dart';

const String imageConst =
    "https://images.pexels.com/photos/1295138/pexels-photo-1295138.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  double rotationAngle = 0;

  var decorationImage = DecorationImage(
    image: NetworkImage(imageConst),
    fit: BoxFit.cover,
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animationController.repeat(reverse: true);

    animationController.addStatusListener((status) {
      print(status);
    });

    animationController.addListener(() {
      setState(() {
        rotationAngle = animationController.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: decorationImage,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Card(
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: GestureDetector(
                  child: Container(
                      height: 250,
                      width: 250,
                      color: Colors.black.withOpacity(0.8),
                      child: Transform.rotate(
                        angle: rotationAngle,
                        child: Icon(
                          Icons.wb_sunny,
                          size: 124.0,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
