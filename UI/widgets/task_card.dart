import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';

// Uncomment or add this line if AppColors is defined in your project
// import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel,
  });
  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
                widget.taskModel.description ?? ''
            ),
            Text(
                'Date: ${widget.taskModel.createdDate ?? ''}',
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () => _onTapEditButton(context),
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: _onTapDeleteButton,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTapEditButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['New', 'Completed', 'Cancelled', 'In Progress']
                  .map((e) => ListTile(onTap:(){
              },
              title: Text(e)))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onTapDeleteButton() {
    // Your delete logic here
  }

  Widget buildTaskStatusChip() {
    return Chip(
      label: const Text(
        'New',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: const BorderSide(color: Colors.blue), // Replace with AppColors.themeColor if available
    );
  }
}
