import 'package:flutter/material.dart';
import 'package:untitled/UI/controllers/auth.dart';
import 'package:untitled/UI/screens/profile_screen.dart';

import '../screens/sign_in_screen.dart';
import '../utils/app_colors.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.isProfileScreenOpen) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 16,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rabbil Hasan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'test@test.com',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await AuthController.clearUserData();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (predicate) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
