import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/tasks/provider/task_stream_provider.dart';
import 'package:to_do/history/widgets/custom_card.dart';
import 'package:to_do/shared/error_page.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTask = ref.watch(taskStreamNotifierProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        175,
        173,
        173,
      ),
      body: asyncTask.when(
        data: (tasks) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Center(
              child: Column(
                children: [
                  CustomCard(tasks: tasks),
                  // completion chart
                  //weekly trending chart
                  //recent completed chart
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) =>
            ErrorPage(error: error, stackTrace: stackTrace),
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}
