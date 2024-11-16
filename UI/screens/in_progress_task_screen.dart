import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class InProgressTaskScreen extends StatelessWidget {
  const InProgressTaskScreen({super.key});

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
