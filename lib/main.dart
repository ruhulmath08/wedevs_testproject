import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedevs_testproject/authentication/authentication_bloc.dart';
import 'package:wedevs_testproject/constants/enum.dart';
import 'package:wedevs_testproject/local_storage/shared_preferences/wedevs_test_project_sharePreferences.dart';
import 'package:wedevs_testproject/routing/router.dart';
import 'package:wedevs_testproject/routing/routing_constants.dart';
import 'package:wedevs_testproject/screens/home/tabs/home_tab/bloc/home_tab_bloc.dart';
import 'package:wedevs_testproject/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:wedevs_testproject/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:wedevs_testproject/screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WeDevsTestProjectSharePreferences.initializePrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), //Set the fit size from Figma Demo
      minTextAdapt: true,
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc()),
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => HomeTabBloc()),
          BlocProvider(create: (context) => AuthenticationBloc()),
        ],
        child: MaterialApp(
          title: 'weDevs Test Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: generateRoute,
          home: const SplashScreen(),
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) => previous.status != current.status,
              listener: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  _navigator!.pushReplacementNamed(homeScreenRoute);
                } else {
                  _navigator!.pushReplacementNamed(signInScreenRoute);
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
