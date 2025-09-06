import 'package:get/get.dart';
import 'domain_check_controller.dart';

class DomainCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DomainCheckController>(() => DomainCheckController());
  }
}
