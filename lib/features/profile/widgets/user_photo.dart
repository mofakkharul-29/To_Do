import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  final String? photoUrl;
  final String? userName;
  final double radius;

  const UserPhoto({
    super.key,
    this.photoUrl,
    this.userName,
    this.radius = 65,
  });

  @override
  Widget build(BuildContext context) {
    String initials = '';
    if ((userName ?? '').isNotEmpty) {
      final names = userName!.trim().split(' ');
      if (names.length == 1) {
        initials = names[0][0].toUpperCase();
      } else {
        initials =
            '${names[0][0].toUpperCase()}${names[1][0].toUpperCase()}';
      }
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black54,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: const Color.fromARGB(
              255,
              189,
              186,
              186,
            ),
            child: photoUrl != null
                ? ClipOval(
                    child: Image.network(
                      photoUrl!,
                      width: radius * 2,
                      height: radius * 2,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    initials.isNotEmpty ? initials : 'U',
                    style: TextStyle(
                      fontSize: radius * 0.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
