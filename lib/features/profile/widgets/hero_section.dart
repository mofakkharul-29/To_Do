import 'package:flutter/material.dart';
import 'package:to_do/features/auth/domain/app_user.dart';
import 'package:to_do/features/profile/widgets/user_photo.dart';
import 'package:to_do/features/tasks/domain/task_model.dart';

class HeroSection extends StatelessWidget {
  final AppUser? user;
  final List<TaskModel> tasks;
  const HeroSection({
    super.key,
    required this.user,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const SizedBox();
    }

    return Card(
      color: Colors.transparent,
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 180,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(110),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            const BoxShadow(
              color: Color.fromARGB(255, 90, 89, 89),
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(2.5, 0.0),
            ),
            const BoxShadow(
              color: Color.fromARGB(255, 90, 89, 89),
              blurRadius: 2.5,
              spreadRadius: 1.0,
              offset: Offset(-2.5, 2.5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getText(
                    'Username : ${user?.name?.isNotEmpty == true ? user!.name : 'your name'}',
                  ),
                  const SizedBox(height: 8),
                  getText('Email : ${user?.email ?? ''}'),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            UserPhoto(
              photoUrl: user?.photoUrl,
              userName: user?.name,
            ),
          ],
        ),
      ),
    );
  }

  Widget getText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
    );
  }
}
