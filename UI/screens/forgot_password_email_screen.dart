import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled/UI/screens/forgot_password_otp_screen.dart';
import 'package:untitled/UI/utils/app_colors.dart';
import 'package:untitled/UI/widgets/Screen_background.dart';

class forgotPasswordEmailScreen extends StatefulWidget {
  const forgotPasswordEmailScreen({super.key});

  @override
  State<forgotPasswordEmailScreen> createState() => _forgotPasswordEmailScreenState();
}

class _forgotPasswordEmailScreenState extends State<forgotPasswordEmailScreen> {
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
                  'Your Email Address',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification OTP will be send to your email address',
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
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Email'),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const forgotPasswordOTPScreen()),
    );
  }

  void _onTapSignIn(BuildContext context) {
    Navigator.pop(context);
  }
}
