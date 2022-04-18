import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/crystal_page_card.dart';
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
    return BlocBuilder<ShopCubit, ShopState>(builder: (context, state) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            toolbarHeight: 0.0,
            bottom: TabBar(
              tabs: [Text('POWERUPS'), Text('BLUE CRYSTALS')],
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
    });
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
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        switch(state.shopStatus) {
          // case ShopStatus.unavailable: return Scaffold(backgroundColor: Colors.white, body: Center(child: Text('Shop is Unavailable'),),);
          case ShopStatus.available:
            return ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black38)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RedLifeCrystal(
                      height: 30,
                      width: 30,
                    ),
                    BlueCrystal(
                      width: 30,
                      height: 30,
                    ),
                    RightAnswer(
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black38)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        PaYInfoWidget(
                          productId: blueCrystalConsumableFive,
                          widgetItem: BlueCrystal(
                            width: 50,
                            height: 70,
                          ),
                          rotations: [0.0, math.pi / 8],
                          positions: [Position(), Position(top: 3.0, left: 18.0)],
                          noOfItems: 5,
                          itemType: 'crystals', itemTypes: ItemType.blueCrystal,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        PaYInfoWidget(
                          productId: blueCrystalConsumableTen,
                          rotations: [0.0, math.pi / 8, math.pi / 4],
                          positions: [
                            Position(),
                            Position(top: 3.0, left: 18.0),
                            Position(top: 10.0, left: 30.0)
                          ],
                          noOfItems: 10,
                          widgetItem: BlueCrystal(
                            width: 50,
                            height: 70,
                          ),
                          itemType: 'crystals', itemTypes: ItemType.blueCrystal,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        PaYInfoWidget(
                          productId: blueCrystalConsumableFifteen,
                          rotations: [
                            -math.pi / 8,
                            math.pi / 8,
                            -math.pi / 15,
                            math.pi / 15
                          ],
                          positions: [
                            Position(),
                            Position(top: 3.0, left: 25.0),
                            Position(top: 3.0, left: 0.0),
                            Position(top: 3, left: 18)
                          ],
                          noOfItems: 15,


                          widgetItem: BlueCrystal(
                            width: 50,
                            height: 70,
                          ),
                          itemType: 'crystals', itemTypes: ItemType.blueCrystal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        PaYInfoWidget(
                          productId: blueCrystalConsumableTwenty,
                          rotations: [0.0, math.pi / 8],
                          positions: [Position(), Position(top: 3.0, left: 18.0)],
                          noOfItems: 20,
                          widgetItem: BlueCrystal(
                            width: 50,
                            height: 70,
                          ),
                          itemType: 'crystals', itemTypes: ItemType.blueCrystal,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        PaYInfoWidget(
                          productId: blueCrystalConsumableTwentyFive,
                          rotations: [
                            -math.pi / 15,
                            -math.pi / 8,
                            0.0,
                            math.pi / 8,
                            math.pi / 15
                          ],
                          positions: [
                            Position(),
                            Position(top: 3.0, left: 18.0),
                            Position(top: 3.0, left: 30.0),
                            Position(top: 3.0, left: 35.0),
                            Position(top: 3.0, left: 35.0),
                          ],
                          noOfItems: 25,
                          widgetItem: BlueCrystal(
                            width: 50,
                            height: 70,
                          ),
                          itemType: 'crystals', itemTypes: ItemType.blueCrystal,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        PaYInfoWidget(
                          productId: blueCrystalConsumableThirty,
                          rotations: [0.0, math.pi / 8],
                          positions: [
                            Position(top: 0.0, left: 3.0),
                            Position(top: 0.0, left: 18.0)
                          ],
                          noOfItems: 30,
                          widgetItem: BlueCrystal(
                            width: 50,
                            height: 70,
                          ),
                          itemType: 'crystals', itemTypes: ItemType.blueCrystal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
          default: return Scaffold(backgroundColor: Colors.white, body: Center(child: Text('Shop is Unavailable'),),);
        }
      }
    );
  }
}

class PowerUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PowerUpPageState();
  }
}

class PowerUpPageState extends State<PowerUpPage> with TickerProviderStateMixin{
  double widthCheckMark = 50;
  double heightCheckMark = 50;
  double widthCrystal = 10;
  double heightCrystal = 10;
  late AnimationController _redCrystalAnimController, _blueCrystalAnimController, _rightAnswerAnimCont;
  @override
  void initState() {
    _redCrystalAnimController = AnimationController(vsync: this, duration: Duration(milliseconds: 300), lowerBound: 0.6, upperBound: 1.0);
    _blueCrystalAnimController = AnimationController(vsync: this, duration: Duration(milliseconds: 300), lowerBound: 0.6, upperBound: 1.0);
    _rightAnswerAnimCont = AnimationController(vsync: this, duration: Duration(milliseconds: 300), lowerBound: 0.6, upperBound: 1.0);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _redCrystalAnimController.dispose();
    _blueCrystalAnimController.dispose();
    _rightAnswerAnimCont.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if(state.buyStatus == BuyStatus.redCrystalBought) {
          _redCrystalAnimController.forward().then((value)  {
          _redCrystalAnimController.reverse(); context.read<ShopCubit>().emit(state.copyWith(buyStatus: BuyStatus.noItemBought));
        });
        }  else if(state.buyStatus == BuyStatus.rightAnswerBought) {
          _rightAnswerAnimCont.forward().then((value)
          {_rightAnswerAnimCont.reverse(); context.read<ShopCubit>().emit(state.copyWith(buyStatus: BuyStatus.noItemBought));});
        }
        return ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.black38)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _redCrystalAnimController,
                        curve: Curves.bounceInOut,
                      ),
                      child: Row(
                        children: [
                          Badge(
                            position: BadgePosition.bottomEnd(end: -15),
                            badgeContent: Text(state.redCrystals.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),),
                            child: RedLifeCrystal(
                              height: 30,
                              width: 30,
                            ),
                            badgeColor: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _blueCrystalAnimController,
                        curve: Curves.bounceInOut
                      ),
                      child: Row(
                        children: [
                          Badge(
                            position: BadgePosition.bottomEnd(end: -20),
                            badgeContent: Text(state.blueCrystals.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),),
                            child: BlueCrystal(
                              width: 30,
                              height: 30,
                            ),
                            badgeColor: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _rightAnswerAnimCont,
                        curve: Curves.bounceInOut
                      ),
                      child: Row(
                        children: [
                          Badge(
                            position: BadgePosition.bottomEnd(),
                            badgeContent: Text(state.rightAnswers.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),),
                            child: RightAnswer(
                              width: 30,
                              height: 30,
                            ),
                            badgeColor: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.05 * MediaQuery.of(context).size.height,),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PaYInfoWidget(

                      widgetItem: RightAnswer(
                        width: widthCheckMark,
                        height: heightCheckMark,
                        smallSize: false,
                      ),
                      rotations: [
                        0.0
                      ],
                      positions: [
                        Position(),
                      ],
                      noOfItems: 1,
                      itemType: 'right answer',

                      currencyIcon: BlueCrystal(
                        height: 10,
                        width: 10,
                      ), itemTypes: ItemType.rightAnswer,
                      amount: 5,
                    ),
                    PaYInfoWidget(
                      widgetItem: RightAnswer(
                        width: widthCheckMark,
                        height: heightCheckMark,
                        smallSize: false,
                      ),
                      rotations: [
                        0.0,
                        math.pi/8
                      ],
                      positions: [
                        Position(),
                        Position(left: 16.0)
                      ],
                      noOfItems: 5,
                      itemType: 'right answers',
                      amount: 25,

                      currencyIcon: BlueCrystal(
                        height: 10,
                        width: 10,
                      ), itemTypes: ItemType.rightAnswer,
                    ),
                    PaYInfoWidget(
                      widgetItem: RightAnswer(
                        width: widthCheckMark,
                        height: heightCheckMark,
                        smallSize: false,
                      ),
                      rotations: [
                        0.0,
                        math.pi/8,
                        -math.pi/8
                      ],
                      positions: [
                        Position(),
                        Position(left: 10),
                        Position(),
                      ],
                      noOfItems: 10,
                      amount: 50,
                      itemType: 'right answers',

                      currencyIcon: BlueCrystal(
                        height: 10,
                        width: 10,
                      ), itemTypes: ItemType.rightAnswer,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.05 * MediaQuery.of(context).size.height,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PaYInfoWidget(

                      widgetItem: RedLifeCrystal(
                        height: 70,
                        width: 50,
                      ),
                      rotations: [0.0],
                      positions: [Position()],
                      noOfItems: 1,
                      itemType: 'red crystal',
                      currencyIcon: BlueCrystal(
                        height: 10,
                        width: 10,
                      ), itemTypes: ItemType.redCrystal,
                      amount: 10,
                    ),
                    PaYInfoWidget(
                      widgetItem: RedLifeCrystal(
                        height: 70,
                        width: 50,
                      ),
                      rotations: [
                        -math.pi / 8,
                        math.pi / 8,
                        -math.pi / 15,
                        math.pi / 15
                      ],
                      positions: [
                        Position(),
                        Position(top: 3.0, left: 25.0),
                        Position(top: 3.0, left: 0.0),
                        Position(top: 3, left: 18)
                      ],
                      noOfItems: 5,
                      itemType: 'red crystals',
                      amount: 50,

                      currencyIcon: BlueCrystal(
                        height: 10,
                        width: 10,
                      ), itemTypes: ItemType.redCrystal,
                    ),
                    PaYInfoWidget(
                      widgetItem: RedLifeCrystal(
                        height: 70,
                        width: 50,
                      ),
                      rotations: [
                        -math.pi / 8,
                        math.pi / 8,
                        -math.pi / 15,
                        math.pi / 15
                      ],
                      positions: [
                        Position(),
                        Position(top: 3.0, left: 25.0),
                        Position(top: 3.0, left: 0.0),
                        Position(top: 3, left: 18)
                      ],
                      noOfItems: 12,
                      itemType: 'red crystals',
                      amount: 120,

                      currencyIcon: BlueCrystal(
                        height: 10,
                        width: 10,
                      ), itemTypes: ItemType.redCrystal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
