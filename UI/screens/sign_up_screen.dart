import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled/UI/utils/app_colors.dart';
import 'package:untitled/UI/widgets/Screen_background.dart';
import 'package:untitled/UI/widgets/snack_bar_message.dart';
import 'package:untitled/data/models/network_response.dart';
import 'package:untitled/data/service/network_caller.dart';

import '../../data/utils/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailEController = TextEditingController();
  final TextEditingController _firstNameEController = TextEditingController();
  final TextEditingController _lastNameEController = TextEditingController();
  final TextEditingController _mobileEController = TextEditingController();
  final TextEditingController _passwordEController = TextEditingController();
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Join With Us',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                _buildSignUpForm(),
                const SizedBox(height: 24),
                Center(
                  child: _haveAccountSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSignUpForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailEController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Valid Email";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _firstNameEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'First Name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Valid First Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Last Name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Valid Last Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileEController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Mobile Number'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Valid Mobile Number";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: false,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter Your Password";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Visibility(
            visible: !_inProgress,
            replacement: const CircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }
  RichText _haveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have an account?",
        children: [
          TextSpan(
            text: ' Sign In',
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = () => _onTapSignIn(context),
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formkey.currentState!.validate()){
      _signUp();
    }
  }

  Future<void> _signUp() async {
      _inProgress = true;
      setState(() {

      });
      Map<String, dynamic> requestBody =
        {
          "email":_emailEController.text.trim(),
          "firstName":_firstNameEController.text.trim(),
          "lastName":_lastNameEController.text.trim(),
          "mobile":_mobileEController.text.trim(),
          "password":_passwordEController.text.trim()
        };
      NetworkResponse response = await NetworkCaller.postRequest(
          url: Urls.registration,
          body: requestBody,
      );
      _inProgress = false;
      setState(() {

      });
      if (response.isSuccess){
        _clearTextField();
        showSnackBarMessage(context, 'New User Created');

      } else {
        showSnackBarMessage(context, response.errorMessage, true);
      }
  }

  void _clearTextField() {
    _emailEController.clear();
    _firstNameEController.clear();
    _lastNameEController.clear();
    _mobileEController.clear();
    _passwordEController.clear();
  }

  void _onTapSignIn(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailEController.dispose();
    _firstNameEController.dispose();
    _lastNameEController.dispose();
    _mobileEController.dispose();
    _passwordEController.dispose();
    super.dispose();
  }
}
