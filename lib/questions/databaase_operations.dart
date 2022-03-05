// import 'dart:convert';
//
// import 'package:sqflite/sqflite.dart';
// import 'package:http/http.dart' as http;
// import 'package:trivia_expert_app/main_models/questions.dart';
// import 'models/question.dart';
//
// class DatabaseOperations {
//
// Future<void> insertQuestions(Questions questions, Database database) async {
//   final db = database;
//   await db.insert(
//     'trivia_questions',
//     questions.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }
//
// Future<void> fetchQuestionsAndInsertToDatabase(
//     Database database, int primaryKey) async {
//   Codec<String, String> stringToBase64 = utf8.fuse(base64);
//   Question question;
//   List<Result> results;
//   var url = Uri.parse('https://opentdb.com/api.php?amount=50&encode=base64');
//   for (int i = 0; i < 60; i++) {
//     final response = await http.get(
//       url,
//     );
//     if (response.statusCode == 200) {
//       final body = json.decode(response.body);
//
//       question = Question.fromJson(body);
//       results = question.results!;
//
//       for (int i = 0; i < results.length; i++) {
//         Questions questions = Questions(
//           category: stringToBase64.decode(results[i].category!),
//           type: stringToBase64.decode(results[i].type!),
//           difficulty: stringToBase64.decode(results[i].difficulty!),
//           question: stringToBase64.decode(results[i].question!),
//           correctAnswer: stringToBase64.decode(results[i].correctAnswer!),
//           incorrectOne: stringToBase64.decode(results[i].incorrectAnswers![0]),
//           incorrectTwo: results[i].incorrectAnswers!.length > 1
//               ? stringToBase64.decode(results[i].incorrectAnswers![1])
//               : '',
//           incorrectThree: results[i].incorrectAnswers!.length > 2
//               ? stringToBase64.decode(results[i].incorrectAnswers![2])
//               : '',
//         );
//         try {
//           insertQuestions(questions, database);
//         } catch(e) {
//           print('could not insert into database $e');
//         }
//         primaryKey++;
//       }
//     }
//   }
// }
//