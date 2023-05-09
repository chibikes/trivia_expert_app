import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:repo_packages/repo_packakges.dart' as repo;
import 'models/gamestate.dart';
import 'models/models.dart';

abstract class UserRepository{
  void getUserData(repo.User authenticatedUser);
  void updateUser(repo.User user);
  void saveUserImage(String imgPath, String userId);
}

class FirebaseUserRepository extends UserRepository {
  final users = FirebaseFirestore.instance.collection('users');
  final highScores = FirebaseFirestore.instance.collection('highScores');

  Future<repo.User> getUserData(repo.User authUser,) async {
    try {
      var user = await users
          .doc(authUser.id)
          .get();
      return User.fromMap(user.data()!);
          // .snapshots()
          // .map((event) => User.fromMap(event.data()!));
    } catch (e) {
      print('Error : $e');
      return authUser;
    }
  }

  Future<void> updateUser(repo.User user) {
    highScores.doc(user.id).update({
      'avatarUrl' : user.photoUrl,
      'userName' : user.name,
    }).catchError((error) {});
    
    return users
        .doc(user.id)
        .update(user.toMap())
        .catchError((error) => users.doc(user.id).set(user.toMap()))
        .onError((error, stackTrace) => print('error occured'));
  }

  Future<void> deleteUser(repo.User user) async {
    try {
      await highScores.doc(user.id).delete();
      await users.doc(user.id).delete();
    } catch(e) {
    }

  }

  Future<String> saveUserImage(String imgPath, String userId) async {
    File file = File(imgPath);
    String storageRef = 'users/$userId/$userId.png';
    var firebaseStorageRef = FirebaseStorage.instance.ref(storageRef);

      await firebaseStorageRef.putFile(file);
      return firebaseStorageRef.getDownloadURL();
  }

  Future<void> deleteUserImage(String userId) {
    String storageRef = 'users/$userId/$userId.png';
    return FirebaseStorage.instance.ref(storageRef).delete();
  }

  FirebaseUserRepository();
}

class MockUserRepository extends UserRepository {
  @override
  User getUserData(User authenticatedUser) {
    return User(name: 'Naomi Osaka', );
  }

  @override
  void saveUserImage(String imgPath, String userId) {
    // TODO: implement saveImage
  }

  @override
  void updateUser(repo.User user) {
    // TODO: implement updateUser
  }

}

