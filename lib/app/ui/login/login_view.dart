import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../theme/assets.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.loginBg, fit: BoxFit.cover),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [


                    const SizedBox(height: 66),

                    Text('登陆账号',
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),

                    const SizedBox(height: 40),


                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller.emailController,
                      builder: (_, value, __) {
                        return Obx(() => TextFormField(
                          controller: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          enableInteractiveSelection: true,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(controller.passwordFocusNode);
                          },
                          style: controller.authFailed.value
                              ? const TextStyle(color: Colors.pink)
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: controller.authFailed.value
                                ? Colors.pink.shade50
                                : Colors.white,
                            hintText: '请输入账号',
                            hintStyle: controller.authFailed.value
                                ? const TextStyle(color: Colors.pink)
                                : null,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              child: Image.asset(
                                'assets/images/account_icon.png',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: value.text.isNotEmpty
                                ? IconButton(
                              icon: Image.asset(AppAssets.iconClear, width: 20, height: 20),
                              onPressed: () {
                                controller.emailController.clear();
                                controller.authFailed.value = false;
                              },
                            )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          ),
                          onChanged: (_) => controller.authFailed.value = false,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return '请输入账号';
                            return null;
                          },
                        ));
                      },
                    ),

                    const SizedBox(height: 16),


                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller.passwordController,
                      builder: (_, value, __) {
                        return Obx(() => TextFormField(
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocusNode,
                          obscureText: controller.obscurePassword.value,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          enableInteractiveSelection: true,
                          onFieldSubmitted: (_) {
                            controller.submit();
                          },
                          style: controller.authFailed.value
                              ? const TextStyle(color: Colors.pink)
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: controller.authFailed.value
                                ? Colors.pink.shade50
                                : Colors.white,
                            hintText: '请输入密码',
                            hintStyle: controller.authFailed.value
                                ? const TextStyle(color: Colors.pink)
                                : null,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              child: Image.asset(
                                'assets/images/password_icon.png',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (value.text.isNotEmpty)
                                  IconButton(
                                    icon: Image.asset(AppAssets.iconClear, width: 20, height: 20),
                                    onPressed: () {
                                      controller.passwordController.clear();
                                      controller.authFailed.value = false;
                                    },
                                  ),
                                IconButton(
                                  icon: Image.asset(
                                    controller.obscurePassword.value
                                        ? AppAssets.iconEyeOff
                                        : AppAssets.iconEye,
                                    width: 20,
                                    height: 20,
                                  ),
                                  onPressed: () => controller.obscurePassword.toggle(),
                                ),
                              ],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            errorStyle: const TextStyle(color: Colors.redAccent),
                          ),
                          onChanged: (_) => controller.authFailed.value = false,
                          validator: (v) {
                            if (v == null || v.isEmpty) return '请输入密码';
                            if (v.length < 4) return '密码长度至少为 4 位';
                            return null;
                          },
                        ));
                      },
                    ),

                    const SizedBox(height: 8),


                    Obx(() => controller.authFailed.value
                        ? const Text(
                      '账号或密码错误',
                      style: TextStyle(color: Colors.pink),
                    )
                        : const SizedBox.shrink()),

                    const SizedBox(height: 24),


                    SizedBox(
                      height: 48,
                      child: Obx(() => FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: controller.isSubmitting.value
                            ? null
                            : controller.submit,
                        child: controller.isSubmitting.value
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : const Text('确定'),
                      )),
                    ),
                  ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

