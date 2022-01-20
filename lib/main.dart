import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedevs_testproject/routing/router.dart';
import 'package:wedevs_testproject/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:wedevs_testproject/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:wedevs_testproject/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), //Set the fit size from Figma Demo
      minTextAdapt: true,
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc()),
          BlocProvider(create: (context) => SignUpBloc()),
        ],
        child: MaterialApp(
          title: 'weDevs Test Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: generateRoute,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
