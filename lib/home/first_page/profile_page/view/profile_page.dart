import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/home/first_page/profile_page/view/edit_profile/edit_profile.dart';
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';
import 'package:trivia_expert_app/widgets/decorated_avatar.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final BuildContext? context;

  const ProfilePage({Key? key, this.context}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 0.25 * MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange],
              ),
            ),
            child: GestureDetector(
              /// remove this atrocity later!
              onTap: () {

              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 0.11 * MediaQuery.of(context).size.width,
                            backgroundImage: AssetImage('assets/avatars/avatar18.png'),
                            child: DecoratedAvatar(
                              height: 0.24 * MediaQuery.of(context).size.height,
                              width: 0.24 * MediaQuery.of(context).size.width,
                            ),
                          ),

                          Text(
                            widget.context!
                                .read<MainBloc>()
                                .state
                                .user!
                                .name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditProfile(
                                        widget.context!.read<MainBloc>().state.user);
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white,),
                                Text(
                                  ' Edit Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.help_outline, color: Colors.white,),
                              Text(
                                ' Help',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
