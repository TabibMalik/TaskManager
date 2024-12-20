import 'package:flutter/material.dart';
import 'package:untitled/UI/widgets/centred_circular_progress_indicator.dart';
import 'package:untitled/UI/widgets/snack_bar_message.dart';
import 'package:untitled/UI/widgets/tm_app_bar.dart';

import '../../data/models/network_response.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleEController = TextEditingController();
  final TextEditingController _descriptionEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;
  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, _shouldRefreshPreviousPage);
        }
      },
      child: Scaffold(
        appBar: const TMAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 26),
                  TextFormField(
                    controller: _titleEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_addNewTaskInProgress,
                    replacement: const CentredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: const Icon(Icons.arrow_circle_right),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearTextField() {
    _titleEController.clear();
    _descriptionEController.clear();
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    setState(() {
      _addNewTaskInProgress = true;
    });

    Map<String, dynamic> requestBody = {
      "title": _titleEController.text.trim(),
      "description": _descriptionEController.text.trim(),
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addNewTask,
      body: requestBody,
    );

    setState(() {
      _addNewTaskInProgress = false;
    });

    if (response.isSuccess) {
      _shouldRefreshPreviousPage = true;
      _clearTextField();
      showSnackBarMessage(context, 'New Task Added');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}