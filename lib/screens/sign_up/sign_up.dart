import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedevs_testproject/common_widgets/show_scaffold_message.dart';
import 'package:wedevs_testproject/constants/colores.dart';
import 'package:wedevs_testproject/constants/strings.dart';
import 'package:wedevs_testproject/constants/style.dart';
import 'package:wedevs_testproject/routing/routing_constants.dart';
import 'package:wedevs_testproject/screens/sign_up/bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  final String title;

  const SignUpScreen({Key? key, required this.title}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SignUpBloc>().emit(const SignUpState());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            final formStatus = state.status;
            if (formStatus == FormzStatus.submissionFailure) {
              showScaffoldMessage(context: context, message: state.submissionStatusMessage, color: Colors.red);
            } else if (formStatus == FormzStatus.submissionSuccess) {
              Navigator.of(context).pushReplacementNamed(signInScreenRoute);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              padding: signUpScreenPadding,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 53.h),
                  _ProfileImage(),
                  SizedBox(height: 53.h),
                  _Name(),
                  SizedBox(height: 20.h),
                  _Email(),
                  SizedBox(height: 20.h),
                  _Password(),
                  SizedBox(height: 20.h),
                  _ConfirmPassword(),
                  SizedBox(height: 78.h),
                  _SignUpButton(),
                  SizedBox(height: 40.h),
                  _FacebookAndGoogleLogo(),
                  SizedBox(height: 52.h),
                  _CreateNewAccount(),
                  SizedBox(height: 55.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: Colors.white,
          ),
          width: 121.w,
          height: 121.h,
          child: Center(
            child: Icon(
              Icons.person_outline,
              color: personIconColor,
              size: 25.r,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              gradient: LinearGradient(
                colors: [
                  signUpCameraBackgroundStartColor,
                  signUpCameraBackgroundEndColor,
                ],
              ),
            ),
            width: 34.w,
            height: 34.h,
            child: Center(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 13.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.person_outline, size: 20.r),
            contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            hintText: nameText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            errorText: state.email.invalid ? 'Invalid username' : null,
          ),
          onChanged: (value) => context.read<SignUpBloc>().add(SignUpNameChanged(name: value)),
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
            errorText: state.email.invalid ? 'Invalid username' : null,
          ),
          onChanged: (value) => context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.lock_outlined, size: 20.r),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            hintText: passwordText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) => context.read<SignUpBloc>().add(SignUpPasswordChanged(password: value)),
        );
      },
    );
  }
}

class _ConfirmPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.lock_outlined, size: 20.r),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        hintText: confirmPassword,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                    context.read<SignUpBloc>().add(const SignUpSubmitted());
                  } else {
                    showScaffoldMessage(context: context, message: 'Name, email or password is invalid', color: Colors.red);
                  }
                },
                child: Text(
                  signUpText,
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
      //onTap: () => Navigator.pushNamed(context, signUpScreenRoute),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            alreadyHaveAnAccountText,
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.w300,
              color: forgotPasswordColor,
            ),
          ),
          SizedBox(width: 9.w),
          Text(
            loginText,
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: loginTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
