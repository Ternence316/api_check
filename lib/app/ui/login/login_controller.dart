import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final isSubmitting = false.obs;
  final authFailed = false.obs;
  final obscurePassword = true.obs;

  static const demoEmail = '123456';
  static const demoPassword = '123456';

  Future<void> submit() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    isSubmitting.value = true;
    authFailed.value = false;
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final ok = emailController.text.trim() == demoEmail &&
        passwordController.text == demoPassword;

    if (ok) {
      Get.offAllNamed(Routes.domainCheck);
    } else {
      authFailed.value = true;
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}

