import 'package:flutter/material.dart';

class CentredCircularProgressIndicator extends StatelessWidget {
  const CentredCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator());
  }
}
