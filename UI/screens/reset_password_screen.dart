import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:untitled/UI/screens/sign_in_screen.dart';
import 'package:untitled/UI/utils/app_colors.dart';
import 'package:untitled/UI/widgets/Screen_background.dart';

class resetPasswordScreen extends StatefulWidget {
  const resetPasswordScreen({super.key});

  @override
  State<resetPasswordScreen> createState() => _resetPasswordScreenState();
}

class _resetPasswordScreenState extends State<resetPasswordScreen> {
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
                  'Set Password',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum number of password should be 8 characters long',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
                const SizedBox(height: 48),
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


  Widget _buildVerifyEmailForm() {
    return Column(
      children: [
        const SizedBox(height: 24),
        TextFormField(
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(hintText: 'Confirm Password'),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (_) => false,
    );
  }

  void _onTapSignIn(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (_) => false,
    );
  }
}
