import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/domain/app_user.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';
import 'package:to_do/features/profile/widgets/hero_section.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/features/tasks/provider/task_stream_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(asyncAuthNotifierProvider);

    AppUser? user;
    if (asyncUser is AsyncData<AppUser?>) {
      user = asyncUser.value;
    }

    final asyncTasks = ref.watch(
      taskStreamNotifierProvider,
    );

    List<TaskModel> tasks = [];
    if (asyncTasks is AsyncData<List<TaskModel>>) {
      tasks = asyncTasks.value;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        175,
        173,
        173,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [HeroSection(user: user, tasks: tasks)],
        ),
      ),
    );
  }
}
