import 'package:BMIcalculator/Screens/workout_screen.dart';
import 'package:BMIcalculator/model/meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'input_page.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:vector_math/vector_math_64.dart' as math;

import 'meal_detail_screen.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var today = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFe9e9e9),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 40,
          selectedIconTheme: IconThemeData(
            color: const Color(0xff0a0e21),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black12,
          ),
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.home,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Calculate",
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.calculate,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            height: height * 0.35,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: const Radius.circular(40),
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: 50,
                  left: 32,
                  right: 16,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "چۆنی، ڕۆژیار",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      trailing: GestureDetector(
                        child: ClipOval(
                          child: Image.asset("assets/User.png"),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputPage()),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/trainer.png'),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: height * 0.13,
                                width: width * 0.27,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InputPage()),
                                );
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'قسە لەگەڵ ڕاهێنەر بکە',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _IngredientProgress(
                              ingredient: "Protein",
                              progress: 0.3,
                              progressColor: Colors.green,
                              leftAmount: 72,
                              width: width * 0.28,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            _IngredientProgress(
                              ingredient: "Carbs",
                              progress: 0.7,
                              progressColor: Colors.red,
                              leftAmount: 252,
                              width: width * 0.28,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            _IngredientProgress(
                              ingredient: "Fat",
                              progress: 0.1,
                              progressColor: Colors.yellow,
                              leftAmount: 300,
                              width: width * 0.28,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.38,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.52,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "ژەمەکانی ئەمڕۆ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32,
                          ),
                          for (int i = 0; i < meals.length; i++)
                            _MealCard(meal: meals[i]),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: OpenContainer(
                        closedElevation: 0,
                        transitionType: ContainerTransitionType.fade,
                        transitionDuration: const Duration(milliseconds: 1000),
                        closedColor: const Color(0xFFE9E9E9),
                        openBuilder: (context, _) {
                          return WorkoutScreen();
                        },
                        closedBuilder: (context, VoidCallback openContainer) {
                          return GestureDetector(
                            onTap: openContainer,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                                left: 32,
                                right: 32,
                              ),
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0XFF20008B),
                                    const Color(0XFF200087)
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 16),
                                    child: Text(
                                      "YOUR NEXT WORKOUT",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 16),
                                    child: Text(
                                      "Upper Body",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              color: const Color(0xFF5B4D9D),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset(
                                              "assets/chest.png",
                                              width: 50,
                                              height: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: const Color(0xFF5B4D9D),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/back.png",
                                            width: 50,
                                            height: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: const Color(0xFF5B4D9D),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/biceps.png",
                                            width: 50,
                                            height: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {Key key,
      this.ingredient,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${leftAmount}g ",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}

// ignore: unused_element
class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({Key key, @required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => MealDetailScreen(
                      meal: meal,
                    )),
          );
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Image.asset(
                      meal.imagePath,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 0,
                        ),
                        Text(
                          meal.mealTime,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          meal.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          "${meal.kiloCaloriesBurnt} kcl",
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 15,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${meal.timeTaken} min",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 16)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
