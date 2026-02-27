import 'package:flutter/material.dart';
import 'package:to_do/core/theme/color.dart';
import 'package:to_do/features/tasks/widget/custom_title_form_field.dart';
import 'package:to_do/features/tasks/widget/task_add_button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final bool isClicked = false;
  
  final TextEditingController _titleController =
      TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commonBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 17,
            ),
            child: Form(
              child: Column(
                children: [
                  CustomTitleFormField(
                    controller: _titleController,
                    focusNode: _titleFocus,
                    labelText: 'Title',
                    prefixIcon: Icons.title_rounded,
                    errorText: null,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 15),
                  CustomTitleFormField(
                    labelText: 'Description',
                    controller: _descriptionController,
                    focusNode: _descFocus,
                    prefixIcon: Icons.note_add_outlined,
                    errorText: null,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 20),
                  TaskAddButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text('add task'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
