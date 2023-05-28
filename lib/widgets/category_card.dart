import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/online_single_player.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:trivia_expert_app/widgets/stacked_button.dart';

class CategoryCard extends StatelessWidget {
  final double height;
  final double width;

  const CategoryCard({Key? key, required this.height, required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.80),
        border: Border.all(color: Colors.orange),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StackedButtons(
                height: 0.15 * height,
                width: width,
                child: Text(
                  'GENERAL',
                  style: GoogleFonts.blackHanSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPress: () {
                  context.read<QuestionBloc>().add(CategoryEvent('General'));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnlineSinglePlayer();
                      },
                    ),
                  );
                }),
            StackedButtons(
                height: 0.15 * height,
                width: width,
                child: Text(
                  'SCIENCE',
                  style: GoogleFonts.blackHanSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPress: () {
                  context.read<QuestionBloc>().add(CategoryEvent('Science'));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnlineSinglePlayer();
                      },
                    ),
                  );
                }),
            StackedButtons(
                height: 0.15 * height,
                width: width,
                child: Text(
                  'ART',
                  style: GoogleFonts.blackHanSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPress: () {
                  context.read<QuestionBloc>().add(CategoryEvent('Art'));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnlineSinglePlayer();
                      },
                    ),
                  );
                }),
            StackedButtons(
                height: 0.15 * height,
                width: width,
                child: Text(
                  'ENTERTAINMENT',
                  style: GoogleFonts.blackHanSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPress: () {
                  context
                      .read<QuestionBloc>()
                      .add(CategoryEvent('Entertainment'));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnlineSinglePlayer();
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
