import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskFieldNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void clear() {
    state = null;
  }

  void validateTitle(String title) {
    if (title.isEmpty) {
      state = 'title is required';
      return;
    }
    if (title.length < 6) {
      state = 'title must be at least 6 charachters';
    }
    state = null;
  }
}

final titleErrorProvider =
    NotifierProvider<TaskFieldNotifier, String?>(
      TaskFieldNotifier.new,
    );
