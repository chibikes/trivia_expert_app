import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/cyrstal.dart';
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
          color: Colors.white,
          child: Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Crystal(
                        width: 80,
                        height: 100,
                      ),
                      Transform.rotate(
                        angle: math.pi / 8,
                        child: Crystal(
                          width: 80,
                          height: 100,
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
              Column(
                children: [
                  Crystal(
                    width: 80,
                    height: 100,
                  )
                ],
              )
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
  @override
  Widget build(BuildContext context) {
    return Text('Implement Tomorrow');
  }
}
