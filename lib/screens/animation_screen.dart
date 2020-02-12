import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class AnimationScreen extends StatelessWidget {
  final int armySize = 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ArmySize: $armySize AnimationArmy!"),
      ),
      body: Container(
        child: ListView(
          children: createArmySize(),
        ),
      ),
    );
  }

  List<Row> createArmySize() {
    List<Row> army = List();
    for (int i = 0; i < armySize; i++) {
      army.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomLoadingSpinner(
            bodyColor: RandomColor().randomColor(),
          ),
          CustomLoadingSpinner(
            bodyColor: RandomColor().randomColor(),
          ),
          CustomLoadingSpinner(
            bodyColor: RandomColor().randomColor(),
          )
        ],
      ));
    }
    return army;
  }
}

class CustomLoadingSpinner extends StatefulWidget {
  final Color bodyColor;

  const CustomLoadingSpinner({Key key, this.bodyColor}) : super(key: key);

  @override
  _CustomLoadingSpinnerState createState() => _CustomLoadingSpinnerState();
}

class _CustomLoadingSpinnerState extends State<CustomLoadingSpinner>
    with TickerProviderStateMixin {
  AnimationController firstDotAnimationController;

  AnimationController secondDotAnimationController;

  AnimationController thirdDotAnimationController;

  @override
  void dispose() {
    firstDotAnimationController.dispose();
    secondDotAnimationController.dispose();
    thirdDotAnimationController.dispose();
    super.dispose();
  }

  Tween<Offset> firstTween = Tween<Offset>(
    begin: Offset(0, 0),
    end: Offset(0, -30),
  );

  Tween<Offset> secondTween = Tween<Offset>(
    begin: Offset(0, 0),
    end: Offset(0, -10),
  );

  Tween<Offset> thirdTween = Tween<Offset>(
    begin: Offset(0, 0),
    end: Offset(0, -15),
  );
  var mainAxisAlignment = MainAxisAlignment.start;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    firstDotAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    secondDotAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    thirdDotAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    firstDotAnimationController.repeat(reverse: true);

    Future.delayed(Duration(milliseconds: 200)).then((value) {
      secondDotAnimationController.repeat(reverse: true);
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        thirdDotAnimationController.repeat(reverse: true);
      });
    });

    firstDotAnimationController.addStatusListener((status) {
      counter++;
      if (counter % 10 == 0) {
        setState(() {
          mainAxisAlignment = mainAxisAlignment == MainAxisAlignment.start
              ? MainAxisAlignment.end
              : MainAxisAlignment.start;
        });
      }
    });

    firstDotAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.translate(
          offset: firstTween.animate(firstDotAnimationController).value,
          child: Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.bodyColor,
            ),
          ),
        ),
        Transform.translate(
          offset: secondTween.animate(secondDotAnimationController).value,
          child: Container(
            height: 80,
            width: 80,
            margin: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.bodyColor,
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: thirdTween.animate(thirdDotAnimationController).value,
          child: Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.bodyColor,
            ),
          ),
        )
      ],
    );
  }
}
