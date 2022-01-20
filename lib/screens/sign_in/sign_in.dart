import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedevs_testproject/common_widgets/show_scaffold_message.dart';
import 'package:wedevs_testproject/constants/colores.dart';
import 'package:wedevs_testproject/constants/strings.dart';
import 'package:wedevs_testproject/constants/style.dart';
import 'package:wedevs_testproject/routing/routing_constants.dart';
import 'package:wedevs_testproject/screens/sign_in/bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  final String title;

  const SignInScreen({Key? key, required this.title}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final formStatus = state.status;
          if (formStatus == FormzStatus.submissionFailure) {
            showScaffoldMessage(context: context, message: 'Login failed!', color: Colors.red);
          } else if (formStatus == FormzStatus.submissionSuccess) {
            Navigator.of(context).pushReplacementNamed(homeScreenRoute);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: signInScreenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 83.h),
                  _DokanLogo(),
                  SizedBox(height: 83.h),
                  SignInText(),
                  SizedBox(height: 41.h),
                  _Email(),
                  SizedBox(height: 20.h),
                  _Password(),
                  SizedBox(height: 18.h),
                  _ForgetPassword(),
                  SizedBox(height: 60.h),
                  _LoginButton(),
                  SizedBox(height: 40.h),
                  _FacebookAndGoogleLogo(),
                  SizedBox(height: 53.h),
                  _CreateNewAccount(),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DokanLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logos/dokan_logo.png',
      width: 165.67.w,
      height: 50.8.h,
    );
  }
}

class SignInText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      signInText,
      style: GoogleFonts.roboto(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

class _Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.email_outlined, size: 20.r),
            contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            hintText: emailText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) => state.password.invalid ? 'Invalid email' : null,
          onChanged: (value) => context.read<SignInBloc>().add(SignInEmailChanged(email: value)),
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.lock_outlined, size: 20.r),
            suffixIcon: Icon(Icons.visibility_off, size: 20.r),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            hintText: passwordText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) => state.password.invalid ? 'Invalid password' : null,
          onChanged: (value) => context.read<SignInBloc>().add(SignInPasswordChanged(password: value)),
        );
      },
    );
  }
}

class _ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: '''Clicked on Forget Password''');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            forgotPasswordText,
            style: GoogleFonts.roboto(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: forgotPasswordColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: loginBtnColor,
                  minimumSize: Size(308.w, 61.h),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (state.status.isValidated) {
                    context.read<SignInBloc>().add(const SignInSubmitted());
                  } else {
                    showScaffoldMessage(context: context, message: 'Username or password is invalid', color: Colors.red);
                  }
                },
                child: Text(
                  loginText,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              );
      },
    );
  }
}

class _FacebookAndGoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          width: 56.w,
          height: 56.h,
          child: Center(
            child: Image.asset(
              'assets/logos/facebook_logo.png',
              width: 12.w,
              height: 22.h,
              color: facebookLogoColor,
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          width: 56.w,
          height: 56.h,
          child: Center(
            child: Image.asset(
              'assets/logos/google_logo.png',
              width: 22.w,
              height: 22.h,
            ),
          ),
        ),
      ],
    );
  }
}

class _CreateNewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, signUpScreenRoute),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            createNewAccountText,
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.w300,
              color: forgotPasswordColor,
            ),
          ),
        ],
      ),
    );
  }
}
