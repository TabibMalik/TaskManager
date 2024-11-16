import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 10,
      itemBuilder: (context, index) {

      },
    );
  }
}
