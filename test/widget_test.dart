// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/app.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'package:trivia_expert_app/home/tabbed_pages/tabbed_pages.dart';
import 'package:trivia_expert_app/login/login.dart';

import 'package:trivia_expert_app/main.dart';

import 'mock_repositories/authentication/auth.dart';
import 'mock_repositories/game/game_repo.dart';

class MockAuthenticationBloc extends MockBloc<AuthenticationEvent, AuthenticationState> implements AuthenticationBloc {

}
void main() {
    group('App', () {
      late AuthenticationRepository authenticationRepository;
      late GameRepository gameRepository;
      setUp(() {
        gameRepository = MockGameRepository();
        authenticationRepository = MockAuthenticationRepository();

        when(() => authenticationRepository.user).thenAnswer(
              (_) => Stream.value(User(id: 'test', name: 'tester', email: 'tester@gmail.com')),
        );

      });
      testWidgets('redners AppView', (tester) async {
        await tester.pumpWidget(
            App(gameRepository: gameRepository, authenticationRepository: authenticationRepository,)
        );
        await tester.pump();
        expect(find.byType(AppView), findsOneWidget);
      });
    });

  group('AppView', () {
    late AuthenticationBloc authBloc;
    late AuthenticationRepository authRepository;

    setUp(() {
      authBloc = MockAuthenticationBloc();
      authRepository = MockAuthenticationRepository();

    });
    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => authBloc.state).thenReturn(const AuthenticationState.unauthenticated());

      await tester.pumpWidget(
        RepositoryProvider.value(value: authRepository, child: MaterialApp(
          home: BlocProvider.value(value: authBloc, child: AppView(),),
        ),)
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
    
    testWidgets('navigates to HomePage when authenticate', (tester) async{
      when(() => authBloc.state).thenReturn(const AuthenticationState.authenticated(User(id: 'test', name: 'tester', email: 'tester@gmail.com')));
      await tester.pumpWidget(
          RepositoryProvider.value(value: authRepository, child: MaterialApp(
            home: BlocProvider.value(value: authBloc, child: AppView(),),
          ),)
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
