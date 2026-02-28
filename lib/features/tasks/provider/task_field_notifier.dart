import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskFieldNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void clear() {
    state = null;
  }

  bool validateTitle(String title) {
    if (title.isEmpty) {
      state = 'title is required';
      return false;
    }
    if (title.length < 6) {
      state = 'title must be at least 6 charachters';
      return false;
    }
    state = null;
    return true;
  }
}

final titleErrorProvider =
    NotifierProvider<TaskFieldNotifier, String?>(
      TaskFieldNotifier.new,
    );
