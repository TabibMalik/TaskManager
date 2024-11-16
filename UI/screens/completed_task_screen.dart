import 'package:flutter/material.dart';
import 'package:untitled/UI/widgets/centred_circular_progress_indicator.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _completedTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskListInProgress,
      replacement: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
          child: const CentredCircularProgressIndicator()),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _completedTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(taskModel: _completedTaskList[index]
          );
        },
      ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskListInProgress = true;
    setState(() {

    });
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess)
    {
      final TaskListModel tasklistModel = TaskListModel.fromJson(response.responseData);
      _completedTaskList = tasklistModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskListInProgress = false;
    setState(() {

    });

  }
}
