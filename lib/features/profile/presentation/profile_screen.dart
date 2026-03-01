import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/utils/custom_elevated_button.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';
import 'package:to_do/features/profile/widgets/activities.dart';
import 'package:to_do/features/profile/widgets/hero_section.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';
import 'package:to_do/features/tasks/provider/task_stream_provider.dart';
import 'package:to_do/history/widgets/custom_devider.dart';
import 'package:to_do/shared/error_page.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(asyncAuthNotifierProvider);
    final asyncTasks = ref.watch(
      taskStreamNotifierProvider,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        175,
        173,
        173,
      ),
      body: asyncUser.when(
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text(
                'No user found. Please log in',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          List<TaskModel> tasks = [];
          if (asyncTasks is AsyncData<List<TaskModel>>) {
            tasks = asyncTasks.value;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                HeroSection(user: user, tasks: tasks),
                const SizedBox(height: 10),
                CustomDevider(text: 'Activity Cluster'),
                Activities(tasks: tasks),
                const SizedBox(height: 10),
                CustomDevider(text: 'Preferences'),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  onPressed: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Logout"),
                        content: const Text(
                          "Are you sure you want to logout?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              false,
                            ),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              true,
                            ),
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ref
                          .read(
                            asyncAuthNotifierProvider
                                .notifier,
                          )
                          .logOut();
                    }
                  },
                  text: 'log out',
                  color: Colors.blue,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) =>
            ErrorPage(error: error, stackTrace: stackTrace),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
