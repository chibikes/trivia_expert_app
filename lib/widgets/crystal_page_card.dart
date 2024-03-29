import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/home/shop_page.dart';
import 'package:trivia_expert_app/main_models/purchase_product.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/widgets/stacked_button.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

enum ItemType { redCrystal, blueCrystal, rightAnswer }

//TODO: able to return a widget based on itemType
/// productId is only required for crystals
class PayInfoWidget extends StatelessWidget {
  final String productId;
  final RotationStack rotationStack;
  final Widget? currencyIcon;
  final Widget? widgetItem;
  final int amount;
  final int noOfItems;
  final String itemType;
  final positions;
  final rotations;
  final ItemType itemTypes;
  const PayInfoWidget(
      {Key? key,
      this.rotationStack = const RotationStack(),
      this.noOfItems = 0,
      this.positions,
      this.rotations,
      this.itemType = '',
      this.currencyIcon,
      this.widgetItem,
      required this.itemTypes,
      this.productId = '',
      this.amount = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product = context.read<ShopCubit>().state.products[productId];
    var price = 0;
    // amount !=0 ? amount : double.tryParse(product!.price)!;
    var currency = product != null ? product.productDetails.currencySymbol : '';
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
            //TODO: handle case for redcrystal and rightanswers
            currencyIcon ?? Text(''),
            Text(product == null ? '$amount' : '$currency$price'),
          ],
        ),
        StackedButtons(
          height: 30,
          width: 0.15 * MediaQuery.of(context).size.width,
          topColor: Colors.cyan.shade500,
          bottomColor: Colors.cyan.shade600,
          onPress: () {
            context
                .read<ShopCubit>()
                .buyItem(noOfItems, itemTypes, product, amount);
          },
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

  /// [positions] is a list of positions for each widget
  final List<Position> positions;
  final Widget? child;

  const RotationStack(
      {Key? key,
      this.rotations = const [],
      this.positions = const [],
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
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
