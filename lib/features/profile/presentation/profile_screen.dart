import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';
import 'package:to_do/features/profile/widgets/activities.dart';
import 'package:to_do/features/profile/widgets/get_button_with_text.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroSection(user: user, tasks: tasks),
                const SizedBox(height: 10),
                CustomDevider(text: 'Activity Cluster'),
                Activities(tasks: tasks),
                const SizedBox(height: 10),
                CustomDevider(text: 'Preferences'),
                // if not use this then delete with file
                // PreferencesSection(),
                // const SizedBox(height: 10),
                GetButtonWithText(
                  onTap: () {},
                  text: 'Settings',
                ),
                const SizedBox(height: 10),
                GetButtonWithText(
                  onTap: () {},
                  text: 'Edit Profile',
                ),
                const SizedBox(height: 10),
                GetButtonWithText(
                  onTap: () {},
                  text: 'Theme',
                ),
                const SizedBox(height: 10),
                GetButtonWithText(
                  onTap: () async {
                    final passwordController =
                        TextEditingController();
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text(
                                "Delete Account",
                              ),
                              content: Column(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Enter your password to confirm:",
                                  ),
                                  TextField(
                                    controller:
                                        passwordController,
                                    obscureText: true,
                                    decoration:
                                        const InputDecoration(
                                          labelText:
                                              'Password',
                                          hintText:
                                              'Required',
                                          errorText: null,
                                        ),
                                    onChanged: (_) =>
                                        setState(() {}),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(
                                        context,
                                        false,
                                      ),
                                  child: const Text(
                                    "Cancel",
                                  ),
                                ),
                                TextButton(
                                  onPressed:
                                      passwordController
                                              .text
                                              .trim()
                                              .length <
                                          6
                                      ? null
                                      : () => Navigator.pop(
                                          context,
                                          true,
                                        ),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color:
                                          passwordController
                                                  .text
                                                  .trim()
                                                  .length <
                                              6
                                          ? Colors.grey
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );

                    if (confirm == true) {
                      final password =
                          passwordController.text;
                      await ref
                          .read(
                            asyncAuthNotifierProvider
                                .notifier,
                          )
                          .deleteAccount(
                            password: password,
                          );
                    }
                  },
                  text: 'Delete Account',
                ),
                const SizedBox(height: 10),
                GetButtonWithText(
                  onTap: () async {
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
