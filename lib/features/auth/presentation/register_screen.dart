import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/utils/custom_button.dart';
import 'package:to_do/core/utils/custom_divider.dart';
import 'package:to_do/core/utils/custom_text.dart';
import 'package:to_do/core/utils/custom_text_form_field.dart';
import 'package:to_do/core/utils/get_log_in_options.dart';
import 'package:to_do/core/utils/log_reg_button.dart';
import 'package:to_do/features/auth/provider/auth_notifier.dart';
import 'package:to_do/features/auth/provider/text_field_notifier.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  bool hasSubmited = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailError = ref.watch(emailErrorProvider);
    final emailNotifier = ref.read(
      emailErrorProvider.notifier,
    );

    final nameError = ref.watch(nameErrorProvider);
    final nameNotifier = ref.read(
      nameErrorProvider.notifier,
    );

    final passwordError = ref.watch(passwordErrorProvider);
    final passwordNotifier = ref.read(
      passwordErrorProvider.notifier,
    );

    final asyncAuthState = ref.watch(
      asyncAuthNotifierProvider,
    );
    final authNotifier = ref.read(
      asyncAuthNotifierProvider.notifier,
    );

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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      errorText: emailError,
                      onChanged: (value) {
                        if (hasSubmited) {
                          emailNotifier.validateEmail(
                            value,
                          );
                        }
                      },
                      keyboardType:
                          TextInputType.emailAddress,
                      obscureText: false,
                      labelText: 'Email',
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      errorText: nameError,
                      onChanged: (value) {
                        if (hasSubmited) {
                          nameNotifier.validateName(value);
                        }
                      },
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      labelText: 'Name',
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      errorText: passwordError,
                      onChanged: (value) {
                        if (hasSubmited) {
                          passwordNotifier.validatePassword(
                            value,
                          );
                        }
                      },
                      obscureText: true,
                      labelText: 'Password',
                      prefixIcon: Icons.lock_outline,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        children: [
                          const Text(
                            'have an account?',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          CustomButton(
                            onTap: () {
                              context.go('/login');
                            },
                            text: 'login',
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    LogRegButton(
                      onPressed: asyncAuthState.isLoading
                          ? null
                          : () {
                              setState(
                                () => hasSubmited = true,
                              );
                              emailNotifier.validateEmail(
                                _emailController.text,
                              );
                              passwordNotifier
                                  .validatePassword(
                                    _passwordController
                                        .text,
                                  );
                              nameNotifier.validateName(
                                _nameController.text,
                              );
                              if (emailError == null &&
                                  passwordError == null &&
                                  nameError == null) {
                                authNotifier
                                    .registerWithEmailPassword(
                                      _emailController.text,
                                      _nameController.text,
                                      _passwordController
                                          .text,
                                    );
                              }
                            },
                      color: Colors.blue,
                      child: asyncAuthState.isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child:
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                            )
                          : Text('Sign up'),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDivider(
                            indent: 5.0,
                            endIndent: 5.0,
                            color: Colors.black87,
                          ),
                        ),
                        CustomText(
                          text: 'OR',
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                        Expanded(
                          child: CustomDivider(
                            indent: 5.0,
                            endIndent: 5.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const GetLogInOptions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
