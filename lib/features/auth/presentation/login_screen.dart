import 'package:flutter/material.dart';
import 'package:to_do/core/utils/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        98,
        96,
        107,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 5,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType:
                        TextInputType.emailAddress,
                    obscureText: false,
                    labelText: 'Email',
                    prefixIcon: Icons.email_outlined,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
