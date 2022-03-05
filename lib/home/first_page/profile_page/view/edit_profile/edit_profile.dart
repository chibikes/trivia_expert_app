import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/dimen.dart';
import 'package:trivia_expert_app/form_validate.dart';
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';

class EditProfile extends StatefulWidget {
  final User? user; //TODO: remove this. redundant

  EditProfile(this.user);
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {
  int? imgNo = 17;
  late ImagePicker _picker;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? pswrd;
  User user = User.empty;

  final userCred = UserCredentials();
  String xx = '';
  late double textFieldWidth = 0.80 * Dimen.screenWidth(context);
  late double textFieldHeight = 0.10 * MediaQuery
      .of(context)
      .size
      .height;

  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    context
        .read<MainBloc>()
        .stream;
    context
        .read<MainBloc>()
        .state;
    context
        .watch<MainBloc>()
        .state;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double textFieldWidth = 0.80 * MediaQuery
        .of(context)
        .size
        .width;
    double textFieldHeight = 0.10 * MediaQuery
        .of(context)
        .size
        .height;
    getUrl();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: BlocBuilder<MainBloc,
            MainState>( //TODO: replace mainpagebloc with this one's own bloc ?
          // bloc: MainBloc(MainState(user: context.read<AuthenticationBloc>().state.user)),
          // buildWhen: (state, states) {return true;},
          builder: (context, state) {
            // switch(state.homeStatus) {
            //   case HomeStatus.idle:
            //     scrollView();
            //     break;
            //   case HomeStatus.update:
            //     scrollView();
            //     break;
            //   case HomeStatus.start_game:
            //     // TODO: Handle this case.
            //     break;
            //   case HomeStatus.failure_update:
            //     // TODO: Handle this case.
            //     break;
            // }
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      imgNo = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              children: List.generate(20, (index) {
                                if (index == 0)
                                  return GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                      Navigator.pop(context, index);
                                    },
                                    child: Icon(Icons.camera_alt),
                                  );
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context,
                                        index); //TODO: imgNo is reduntant! remove!
                                  },
                                  child: Image.network(xx),
                                );
                              }),
                            );
                          });

                      context.read<MainBloc>().add(
                        UpdateChanges(
                          User(photo: await getUrl()),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30.0,
                      //TODO: after picking image send the image to cloud storage. then retrieve it in backgroundImage.
                      backgroundImage: NetworkImage(xx),
                    ),
                  ),
                  Text(
                    'Change photo',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 0.05 * MediaQuery
                        .of(context)
                        .size
                        .height,
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      onSaved: (value) {if(value != '') {userCred.name = value;}},
                      initialValue: state.user!.name ?? '',
                      decoration: InputDecoration(
                          fillColor: Colors.blue, hintText: 'User Name'),
                    ),
                  ),
                  // Divider(thickness: 1.3,color: Colors.black,),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      onSaved: (value) {if(value != '') {userCred.firstName = value;}},
                      initialValue: state.user!.firstName ?? '',
                      decoration: InputDecoration(hintText: 'First Name'),
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      onSaved: (value) {if(value != '') {userCred.lastName = value;}},
                      initialValue: state.user!.lastName,
                      decoration: InputDecoration(
                          hintText: state.user!.lastName ?? 'Last Name'),
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      onSaved: (value) {if(value != '') {userCred.age = value;}},
                      initialValue: state.user!.age ?? '',
                      decoration: InputDecoration(hintText: 'Age'),
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      onSaved: (value) {if(value != '') {userCred.country = value;}},
                      initialValue: state.user!.country ?? '',
                      decoration: InputDecoration(hintText: 'Country'),
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      onSaved: (value) {if(value != '') {userCred.email = value;}},
                      initialValue: state.user!.email ?? '',
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        return FormValidate.emailRegex.hasMatch(value!) &&
                            value
                                .toString()
                                .isNotEmpty
                            ? null
                            : 'please enter a valid email';
                      },
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        pswrd = value;
                        return FormValidate.passwordRegExp.hasMatch(value!) &&
                            value
                                .toString()
                                .isNotEmpty
                            ? null
                            : "Password must be a minimum of 6 characters, \n"
                            " one upper case letter and one lower case letter";
                      },
                    ),
                  ),
                  SizedBox(
                    height: textFieldHeight,
                    width: textFieldWidth,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                      validator: (value) {
                        return value == pswrd && value
                            .toString()
                            .isNotEmpty
                            ? null
                            : "passwords do not match";
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        context.read<MainBloc>().add(
                          // GetUserData(),
                          UpdateChanges(
                            User(
                              id: widget.user!.id,
                              name: userCred.name ?? state.user!.name,
                              firstName: userCred.firstName ?? state.user!.firstName,
                              lastName: userCred.lastName ?? state.user!.lastName,
                              age: userCred.age ?? state.user!.age,
                              country: userCred.country ?? state.user!.country,
                              email: userCred.email ?? state.user!.email,
                              photo: xx,
                              achievements: widget.user!.achievements,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    sendImageToCloud(image!.path);
  }

  _imgFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    sendImageToCloud(image!.path);
  }

  void sendImageToCloud(String filePath) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('users/${widget.user!.id}.png')
          .putFile(file);
    } catch (e) {
      print('Storage Error::::::: $e');
      // TODO: do alternative work
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> getUrl() async {
    setState(() async {
      xx = await FirebaseStorage.instance
      // .ref('users/${widget.user.id}.png')
          .ref('users/avatar$imgNo.png')
          .getDownloadURL();
    });
    return xx;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
     // context.read<MainBloc>().getData();
  }
}
class UserCredentials  {
  String? name;
  String? firstName;
  String? lastName;
  String? age;
  String? country;
  String? email;
  String? pswrd;

  UserCredentials({this.name, this.firstName, this.lastName, this.age,
      this.country, this.email, this.pswrd});


}
