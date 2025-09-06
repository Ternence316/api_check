import 'package:get/get.dart';

import '../ui/login/login_binding.dart';
import '../ui/login/login_view.dart';
import '../ui/home/home_view.dart';
import '../ui/domain_check/domain_check_binding.dart';
import '../ui/domain_check/domain_check_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = <GetPage<dynamic>>[
    // Map root path '/' to login so opening '#/' loads login page on web
    GetPage(
      name: '/',
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: Routes.domainCheck,
      page: () => const DomainCheckView(),
      binding: DomainCheckBinding(),
    ),
  ];
}

