import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/theme/color.dart';
import 'package:to_do/features/tasks/provider/task_action_provider.dart';
import 'package:to_do/features/tasks/provider/task_field_notifier.dart';
import 'package:to_do/features/tasks/widget/custom_title_form_field.dart';
import 'package:to_do/features/tasks/widget/task_add_button.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() =>
      _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  bool hasClicked = false;

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
    final titleError = ref.watch(titleErrorProvider);
    final taskAction = ref.watch(taskActionProvider);
    final taskActionNotifier = ref.read(
      taskActionProvider.notifier,
    );

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
                    maxLines: 1,
                    errorText: titleError,
                    onChanged: (value) {
                      if (hasClicked) {
                        ref
                            .read(
                              titleErrorProvider.notifier,
                            )
                            .validateTitle(value);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTitleFormField(
                    labelText: 'Description',
                    controller: _descriptionController,
                    focusNode: _descFocus,
                    prefixIcon: Icons.note_add_outlined,
                    maxLines: 2,
                    errorText: null,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 20),
                  TaskAddButton(
                    color: Colors.blue,
                    onPressed: taskAction.isLoading
                        ? null
                        : () {
                            setState(() {
                              hasClicked = true;
                            });
                            ref
                                .read(
                                  titleErrorProvider
                                      .notifier,
                                )
                                .validateTitle(
                                  _titleController.text,
                                );
                            if (titleError == null) {
                              taskActionNotifier.addTask(
                                _titleController.text,
                                _descriptionController.text,
                              );
                            }
                            context.go('/tasks');
                          },
                    child: taskAction.isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                          )
                        : Text('add task'),
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
