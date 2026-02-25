import 'package:flutter/material.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';

class GetLogInOptions extends StatelessWidget {
  final AuthNotifier authNotifier;
  const GetLogInOptions({
    super.key,
    required this.authNotifier,
  });

  @override
  Widget build(BuildContext context) {
    // final asyncAuthState = ref.watch(
    //   asyncAuthNotifierProvider,
    // );
    // final authNotifier = ref.read(
    //   asyncAuthNotifierProvider.notifier,
    // );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getOptions('assets/images/google.png', () {
          authNotifier.loginWithGoogle();
        }),
        getOptions('assets/images/facebook.png', () {}),
        getOptions('assets/images/phone.png', () {}),
      ],
    );
  }

  Widget getOptions(
    String image,
    void Function()? onPressed,
  ) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent,
        elevation: 0.0,
        shape: CircleBorder(side: BorderSide.none),
        fixedSize: Size(100, 100),
      ),
      child: Image.asset(image),
    );
  }
}
