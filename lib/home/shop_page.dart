import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';
import 'dart:math' as math;

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopPageState();
  }
}

class ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [Text('POWERUPS'), Text('CRYSTALS')],
          ),
        ),
        body: TabBarView(
          children: [
            PowerUpPage(),
            CrystalsPage(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CrystalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CrystalPageState();
  }
}

class CrystalPageState extends State<CrystalsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black38)),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Crystal(
                        width: 50,
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 3.0),
                        child: Transform.rotate(
                          angle: math.pi / 8,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 50),
                        child: Shine(
                          height: 20,
                          width: 20,
                          shineExtra: true,
                        ),
                      ),
                    ],
                  ),
                  Text('5 Crystals'),
                  Text('\$0.99'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Buy'),
                  ),
                ],
              ),
              SizedBox(
                width: 0.10 * MediaQuery.of(context).size.width,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Crystal(
                        width: 50,
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 3.0),
                        child: Transform.rotate(
                          angle: math.pi / 8,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 50),
                        child: Shine(
                          height: 20,
                          width: 20,
                          shineExtra: true,
                        ),
                      ),
                    ],
                  ),
                  Text('10 Crystals'),
                  Text('\$1.99'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Buy'),
                  ),
                ],
              ),
              SizedBox(
                width: 0.10 * MediaQuery.of(context).size.width,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Transform.rotate(
                        angle: -math.pi / 8,
                        child: Crystal(
                          width: 50,
                          height: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 3.0),
                        child: Transform.rotate(
                          angle: math.pi / 8,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 3.0),
                        child: Transform.rotate(
                          angle: -math.pi / 15,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 3.0),
                        child: Transform.rotate(
                          angle: math.pi / 15,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('15 Crystals'),
                  Text('\$2.99'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Buy'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Crystal(
                        width: 50,
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 3.0),
                        child: Transform.rotate(
                          angle: math.pi / 8,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 50),
                        child: Shine(
                          height: 20,
                          width: 20,
                          shineExtra: true,
                        ),
                      ),
                    ],
                  ),
                  Text('20 Crystals'),
                  Text('\$0.99'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Buy'),
                  ),
                ],
              ),
              SizedBox(
                width: 0.10 * MediaQuery.of(context).size.width,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Crystal(
                        width: 50,
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 3.0),
                        child: Transform.rotate(
                          angle: math.pi / 8,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Crystal(
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 50),
                        child: Shine(
                          height: 20,
                          width: 20,
                          shineExtra: true,
                        ),
                      ),
                    ],
                  ),
                  Text('25 Crystals'),
                  Text('\$1.99'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Buy'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PowerUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PowerUpPageState();
  }
}

class PowerUpPageState extends State<PowerUpPage> {
  double widthCheckMark = 50;
  double heightCheckMark = 50;
  double widthCrystal = 10;
  double heightCrystal = 10;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CheckMark(
                          width: widthCheckMark,
                          height: heightCheckMark,
                          smallSize: false,
                        ),
                      ],
                    ),
                    Text('1-right answer'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      CheckMark(
                        width: widthCheckMark,
                        height: heightCheckMark,
                        smallSize: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Transform.rotate(
                          angle: math.pi / 8,
                          child: CheckMark(
                            width: widthCheckMark,
                            height: heightCheckMark,
                            smallSize: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('2-right answers'),
                  Row(
                    children: [
                      Crystal(
                        width: widthCrystal,
                        height: heightCrystal,
                      ),
                      Text('5'),
                    ],
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('BUY'))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CheckMark(
                          width: widthCheckMark,
                          height: heightCheckMark,
                          smallSize: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Transform.rotate(
                            angle: math.pi / 8,
                            child: CheckMark(
                              width: widthCheckMark,
                              height: heightCheckMark,
                              smallSize: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Transform.rotate(
                            angle: -math.pi / 8,
                            child: CheckMark(
                              width: widthCheckMark,
                              height: heightCheckMark,
                              smallSize: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text('4-right answers'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.05 * MediaQuery.of(context).size.height,
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    FirstAidBox(
                      width: widthCheckMark,
                      height: heightCheckMark,
                      color: Color(0xfff5f5f5),
                    ),
                    Text('1-white card'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    FirstAidBox(
                      width: widthCheckMark,
                      height: heightCheckMark,
                      color: Colors.green,
                    ),
                    Text('1-green card'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    RedLifeCrystal(
                      width: 70,
                      height: 70,
                    ),
                    Text('1-orange card'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.05 * MediaQuery.of(context).size.height,
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    FirstAidBox(
                      width: widthCheckMark,
                      height: heightCheckMark,
                      color: Color(0xfff5f5f5),
                    ),
                    Text('1-white card'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    FirstAidBox(
                      width: widthCheckMark,
                      height: heightCheckMark,
                      color: Colors.green,
                    ),
                    Text('1-green card'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    FirstAidBox(
                      width: widthCheckMark,
                      height: heightCheckMark,
                      color: Colors.orange,
                    ),
                    Text('1-orange card'),
                    Row(
                      children: [
                        Crystal(
                          width: widthCrystal,
                          height: heightCrystal,
                        ),
                        Text('5'),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('BUY'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
