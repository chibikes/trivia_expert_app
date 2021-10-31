import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repo_packages/src/models/scores.dart';
import 'power_ups.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}

class User extends Equatable {
  /// {@macro user}
  const User({
    // required this.email,
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.age,
    this.country,
    this.email,
    this.photo,
    this.achievements,
    this.gameIds = const ['', '', '', '', '',],
    this.lastOnlineInteraction,
    this.maxGamesReached,
  });

  // final String email;
  final String? id;
  final String? name, firstName, lastName;
  final String? age;
  final String? country;
  final String? photo;
  final String? email;
  final List<String>? achievements;
  final List<String>? gameIds;
  final String? lastOnlineInteraction;
  final bool? maxGamesReached;

  static const empty =
      User(id: '', name: null, photo: ''); // photo should be null

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'country': country,
      'photo': photo,
      'email': email,
      'achievements': achievements,
      'gameIds': gameIds,
      'lastOnlineInteraction' : lastOnlineInteraction,
      'maxGamesReached' : maxGamesReached,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? firstName,
    String? lastName,
    String? age,
    String? country,
    String? photo,
    String? email,
    List<String>? achievements,
    List<String>? gameIds,}
  ) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      country: country ?? this.country,
      photo: photo ?? this.photo,
      email: email ?? this.email,
      achievements: returnGameIds(this.achievements, achievements),
      gameIds: returnGameIds(this.gameIds, gameIds),
    );
  }

  static User fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      age: data['age'],
      country: data['country'],
      photo: data['photo'],
      achievements: data['achievements'],
      gameIds: data['gameIds'],
    );
  }

  @override
  List<Object?> get props => [name, photo, gameIds, achievements, country, age];

  List<String> returnGameIds(List<String>? arr1, List<String>? arr2) {
    if(arr2 != null) arr1!.addAll(arr2);
    return arr1!;
  }
}



