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
import 'package:trivia_expert_app/home/first_page/view/home_page.dart';
import 'package:trivia_expert_app/home/tabbed_pages/tabbed_pages.dart';
import 'package:trivia_expert_app/login/login.dart';

import 'package:trivia_expert_app/main.dart';
import 'package:trivia_expert_app/main_models/user_game_details.dart';

import 'mock_repositories/authentication/auth.dart';
import 'mock_repositories/game/game_repo.dart';
import 'mock_repositories/mockfirebaserepo.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<AuthenticationState>(AuthenticationState.unknown());
    registerFallbackValue<AuthenticationEvent>(AuthenticationUserChanged(User()));
  });
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late GameRepository gameRepository;
    late FirebaseUserRepository firebaseUserRepository;
    User user = User(id: 'test', name: 'tester', email: 'tester@gmail.com');
    UserGameDetails gameDetails = UserGameDetails(userId: '');
    setUp(() {
      gameRepository = MockGameRepository();
      authenticationRepository = MockAuthenticationRepository();
      firebaseUserRepository = MockFirebaseUserRepo();

      when(() => authenticationRepository.user).thenAnswer(
        (_) => Stream.value(user),
      );
      when(() =>
          firebaseUserRepository.getUserData(user)).thenAnswer((_) => Future.value(user));
      when(() => gameRepository.getUserGameDetails('test')).thenAnswer((_) => Stream.value(gameDetails));

    });
    /// use mockfirebaseuserrepo otherwise test fails because it will look up the widget tree for
    /// the actual firebaserepo and fail since firebase.app isn't initialized
    /// use only repositories required to display tested widgets to make testing faster

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(App(
        gameRepository: gameRepository,
        authenticationRepository: authenticationRepository,
        firebaseUserRepository: firebaseUserRepository,
      )
          //
          );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationBloc authBloc;
    late AuthenticationRepository authRepository;
    late FirebaseUserRepository firebaseUserRepository;
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    setUp(() {
      authBloc = MockAuthenticationBloc();
      authRepository = MockAuthenticationRepository();
    });


    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => authBloc.state).thenReturn(const AuthenticationState.unauthenticated());
      await tester.pumpWidget(
        RepositoryProvider.value(value: authRepository, child: MaterialApp(
          navigatorKey: navigatorKey,
          home: BlocProvider.value(value: authBloc, child: AppView(),),
        ),)
      );
      await tester.pump();
      expect(find.byType(LoginPage), findsNothing);
    });

    testWidgets('navigates to HomePage when authenticate', (tester) async{
      when(() => authBloc.state).thenReturn(const AuthenticationState.authenticated(User()));
      await tester.pumpWidget(
          RepositoryProvider.value(value: authRepository, child: MaterialApp(
            home: BlocProvider.value(value: authBloc, child: AppView(),),
          ),)
      );
      await tester.pumpAndSettle(Duration(minutes: 10,));
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
