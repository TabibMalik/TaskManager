import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled/UI/controllers/auth.dart';
import 'package:untitled/UI/screens/forgot_password_email_screen.dart';
import 'package:untitled/UI/screens/main_bottom_nav_bar_screen.dart';
import 'package:untitled/UI/screens/sign_up_screen.dart';
import 'package:untitled/UI/utils/app_colors.dart';
import 'package:untitled/UI/widgets/Screen_background.dart';
import 'package:untitled/UI/widgets/centred_circular_progress_indicator.dart';
import 'package:untitled/UI/widgets/snack_bar_message.dart';
import 'package:untitled/data/models/network_response.dart';
import 'package:untitled/data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEController = TextEditingController();
  final TextEditingController _passwordEController = TextEditingController();
  bool _inProgerss = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

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
                const SizedBox(height: 82,),
                Text(
                  'Get Started With',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                _buildSignInForm(),
                const SizedBox(height: 24,),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPassword,
                        child: const Text('Forgot Password', style: TextStyle(color: Colors.grey)),
                      ),
                      _buildSignUpSection(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 24,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordEController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return 'Enter a valid password';
              }
              if (value!.length <= 6){
                return 'Enter a password more than 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Visibility(
            visible: !_inProgerss,
            replacement: const CentredCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  RichText _buildSignUpSection(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Don't have an account?",
        children: [
          TextSpan(
            text: ' Sign Up',
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: _tapGestureRecognizer..onTap = () => _onTapSignUp(context),
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if(!_formKey.currentState!.validate()){
      return;
    }
    _signIn();
  }
  Future<void> _signIn() async {
      setState(() {
      });

      Map<String, dynamic> requestBody = {
          "email":_emailEController.text.trim(),
          "password": _passwordEController.text.trim(),
        };
      final NetworkResponse response =
        await NetworkCaller.postRequest(
            url: Urls.login,
            body: requestBody,
        );
      _inProgerss = false;
      setState(() {
      });
      if (response.isSuccess){
        await AuthController.saveAccessToken(response.responseData['token']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const mainBottomNavBarScreen()),
              (_) => false,
        );
      } else {
        showSnackBarMessage(context, response.errorMessage, true);
      }
  }

  void _onTapForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const forgotPasswordEmailScreen()),
    );
  }

  void _onTapSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}
