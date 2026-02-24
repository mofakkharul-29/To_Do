import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(
      asyncAuthNotifierProvider.notifier,
    );

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            notifier.logOut();
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
