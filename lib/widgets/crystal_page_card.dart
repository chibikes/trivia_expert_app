import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

class PaYInfoWidget extends StatelessWidget {
  final RotationStack rotationStack;
  final Widget? currencyIcon;
  final Widget? widgetItem;
  final int noOfItems;
  final double amount;
  final String itemType;
  final String currency;
  final void Function() onTap;
  final positions;
  final rotations;
  const PaYInfoWidget({Key? key, this.rotationStack = const RotationStack(), this.noOfItems = 0, this.amount = 0, required this.onTap, this.positions, this.rotations, this.itemType = '', this.currency = '', this.currencyIcon, this.widgetItem,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotationStack(
          rotations: rotations,
          positions: positions,
          child: widgetItem,
        ),
        Text('$noOfItems $itemType'),
        Row(
          children: [
            currencyIcon ?? Text(''),
            Text('$currency$amount'),
          ],
        ),
        ElevatedButton(
          onPressed: onTap,
          child: Text('Buy'),
        )
      ],
    );
  }
}

class RotationStack extends StatelessWidget {
  /// [rotations] is a list of rotations in radians for each widget
  /// e.g [math.pi/2, math.pi,] will create two widgets with rotations math.pi/2 and math.pi
  final List<double> rotations;
  /// [positions] is a list of positions for each crystal
  final List<Position> positions;
  final Widget? child;

  const RotationStack({Key? key, this.rotations = const [], this.positions = const[], this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
      List.generate(
        rotations.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                top: positions[index].top,
                left: positions[index].left,
              ),
          child: Transform.rotate(
            angle: rotations[index],
            child: child,
          ),
        ),
      ),
    );
  }

}

class Position {
  final double left;
  final double top;

  Position({this.top = 0, this.left = 0});
}
