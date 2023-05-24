import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/form_validate.dart';
import 'package:trivia_expert_app/get_image.dart';
import '../../../../../user_bloc/cubit/user_bloc.dart';
import '../../../../../widgets/stacked_button.dart';

class EditProfile extends StatefulWidget {
  EditProfile({this.autoFocusName = false});
  final bool autoFocusName;
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {
  final imgSelector = ImageSelector();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userCred = UserCredentials();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double textFieldWidth = 0.80 * MediaQuery.of(context).size.width;
    double textFieldHeight = 0.10 * MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 0.20 * MediaQuery.of(context).size.width,
            ),
            Text('Settings'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.homeStatus == HomeStatus.updated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Profile updated successfully'),
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state.homeStatus == HomeStatus.failure_update) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Profile update fail'),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state.homeStatus == HomeStatus.failure_update) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('failed to update')));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(state.user!.photoUrl!),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Text(
                          'Change photo',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 0.05 * MediaQuery.of(context).size.height,
                      ),
                      SizedBox(
                        height: textFieldHeight,
                        width: textFieldWidth,
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != '') {
                              userCred.name = value;
                            }
                          },
                          autofocus: widget.autoFocusName,
                          initialValue: state.user!.name ?? '',
                          decoration: InputDecoration(
                              fillColor: Colors.blue, hintText: 'User Name'),
                          validator: (value) {
                            return value.toString().isNotEmpty
                                ? null
                                : 'please enter a valid user name';
                          },
                        ),
                      ),
                      // Divider(thickness: 1.3,color: Colors.black,),
                      SizedBox(
                        height: textFieldHeight,
                        width: textFieldWidth,
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != '') {
                              userCred.firstName = value;
                            }
                          },
                          initialValue: state.user!.firstName ?? '',
                          decoration: InputDecoration(hintText: 'First Name'),
                        ),
                      ),
                      SizedBox(
                        height: textFieldHeight,
                        width: textFieldWidth,
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != '') {
                              userCred.lastName = value;
                            }
                          },
                          initialValue: state.user!.lastName,
                          decoration: InputDecoration(
                              hintText: state.user!.lastName ?? 'Last Name'),
                        ),
                      ),
                      SizedBox(
                        height: textFieldHeight,
                        width: textFieldWidth,
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != '') {
                              userCred.country = value;
                            }
                          },
                          initialValue: state.user!.country ?? '',
                          decoration: InputDecoration(hintText: 'Country'),
                        ),
                      ),
                      SizedBox(
                        height: textFieldHeight,
                        width: textFieldWidth,
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != '') {
                              userCred.email = value;
                            }
                          },
                          initialValue: state.user!.email ?? '',
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            return FormValidate.emailRegex.hasMatch(value!) &&
                                    value.toString().isNotEmpty
                                ? null
                                : 'please enter a valid email';
                          },
                        ),
                      ),
                      state.homeStatus != HomeStatus.waiting
                          ? StackedButtons(
                              height: 40,
                              width: 0.30 * MediaQuery.of(context).size.width,
                              topColor: Colors.blue.shade600,
                              bottomColor: Colors.blue.shade800,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  context.read<UserBloc>().add(
                                        UpdateUser(
                                          state.user!.copyWith(
                                            name: userCred.name,
                                            firstName: userCred.firstName,
                                            lastName: userCred.lastName,
                                            email: userCred.email,
                                            country: userCred.country,
                                          ),
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                'Update Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                    height: 0.10 *
                                        MediaQuery.of(context).size.width,
                                    width: 0.10 *
                                        MediaQuery.of(context).size.width,
                                    child: CircularProgressIndicator())
                              ],
                            ),
                      SizedBox(height: 16.0),
                      StackedButtons(
                        height: 40,
                        width: 0.30 * MediaQuery.of(context).size.width,
                        topColor: Colors.blue.shade600,
                        bottomColor: Colors.blue.shade800,
                        onPress: () async {
                          showDeleteAccountDialog(context);
                        },
                        child: Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        try {
                          context.read<UserBloc>().add(UpdateUserImage(
                              await imgSelector.getImageFromGallery()));
                        } on ImageTooLargeException catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.message)));
                        }
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      try {
                        context.read<UserBloc>().add(UpdateUserImage(
                            await imgSelector.getImageFromCamera()));
                      } on ImageTooLargeException catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.message)));
                      }
                      Navigator.of(context).pop();
                    },
                  ),
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

class UserCredentials {
  String? name;
  String? firstName;
  String? lastName;
  String? age;
  String? country;
  String? email;
  String? pswrd;

  UserCredentials(
      {this.name,
      this.firstName,
      this.lastName,
      this.age,
      this.country,
      this.email,
      this.pswrd});
}

showDeleteAccountDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Are You Sure you want to delete your account?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(''),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  context.read<UserBloc>().add(DeleteUser());
                  // context.read<AuthenticationBloc>().add(DeleteAccount());
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
