import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController rectangleRotation;

  double rotation = 0;

  @override
  void initState() {
    super.initState();
    rectangleRotation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    rectangleRotation.forward();
    rectangleRotation.addListener(() {
      setState(() {
        rotation = rectangleRotation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.pexels.com/photos/1295138/pexels-photo-1295138.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Card(
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    rectangleRotation.status == AnimationStatus.completed
                        ? rectangleRotation.reverse()
                        : rectangleRotation.forward();
                  },
                  child: Container(
                    transform: Matrix4.identity()
                      ..rotateX(rotation * 3)
                      ..rotateY(rotation * 6)
                      ..rotateZ(rotation * 9),
                    height: 100,
                    width: 100,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
