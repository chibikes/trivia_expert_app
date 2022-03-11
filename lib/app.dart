import 'package:in_app_repo/in_app_repository.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/splash/view/splash_page.dart';
import 'package:trivia_expert_app/theme.dart';
import 'authentication/authentication.dart';
import 'package:trivia_expert_app/home/tabbed_pages/tabbed_pages.dart';
import 'login/view/login_page.dart';
import 'main_bloc/cubit/main_page_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(create: (_) => MainBloc(UserRepository(),authRepository: authenticationRepository)..add(FetchUserData())),
          BlocProvider(create: (_)=> QuestionBloc(questionRepository: DatabaseQuestionsRepository())..add(RetrieveOffset()), lazy: false,),
          BlocProvider(create: (_)=> ShopCubit(inAppRepo: InAppRepo()),),
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
