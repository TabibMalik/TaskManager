import 'package:flutter/material.dart';
import 'package:untitled/UI/widgets/centred_circular_progress_indicator.dart';
import 'package:untitled/UI/widgets/snack_bar_message.dart';
import 'package:untitled/data/models/network_response.dart';
import 'package:untitled/data/models/task_list_model.dart';
import 'package:untitled/data/service/network_caller.dart';
import '../../data/models/task_model.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_card.dart';
import '../widgets/task_summary_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListInProgress = false;
  List<TaskModel> _newTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: Visibility(
                visible: !_getNewTaskListInProgress,
                replacement: const CentredCircularProgressIndicator(),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(taskModel: _newTaskList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTapAddFAB(context);
        },
        child: const Icon(Icons.add_box),
      ),
    );
  }

  Widget _buildSummarySection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              title: 'New',
              count: 9,
            ),
            TaskSummaryCard(
              title: 'Completed',
              count: 9,
            ),
            TaskSummaryCard(
              title: 'Cancelled',
              count: 9,
            ),
            TaskSummaryCard(
              title: 'In Progress',
              count: 9,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapAddFAB(BuildContext context) async{
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if(shouldRefresh == true ){
        _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskListInProgress = true;
    setState(() {

    });
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess)
    {
      final TaskListModel tasklistModel = TaskListModel.fromJson(response.responseData);
      _newTaskList = tasklistModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskListInProgress = false;
    setState(() {

    });

  }
}


