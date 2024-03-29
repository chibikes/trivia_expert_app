import 'package:in_app_repo/in_app_repository.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'package:trivia_expert_app/learderboard_bloc/bloc/leaderboard_bloc.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/splash/view/splash_page.dart';
import 'package:trivia_expert_app/theme.dart';
import 'package:trivia_expert_app/user_bloc/cubit/user_bloc.dart';
import 'authentication/authentication.dart';
import 'package:trivia_expert_app/home/tabbed_pages/tabbed_pages.dart';
import 'login/view/login_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.gameRepository,
    required this.firebaseUserRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final GameRepository gameRepository;
  final FirebaseUserRepository firebaseUserRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => authenticationRepository),
        RepositoryProvider(create: (_) => firebaseUserRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
              create: (_) => UserBloc(firebaseUserRepository,
                  authRepository: authenticationRepository,
                  gameRepository: gameRepository)
                ..add(FetchUserData())
                ..add(GetTimeSinceLastUpdate())),
          BlocProvider(
            create: (_) => QuestionBloc(questionRepository: OnlineRepository())
              ..add(FetchQuestions()),
            lazy: false,
          ),
          BlocProvider(
            create: (_) =>
                ShopCubit(inAppRepo: InAppRepo())..getPowerUpsFromStorage(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => LeaderBoardBloc(
              gameRepository: gameRepository,
            ),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
