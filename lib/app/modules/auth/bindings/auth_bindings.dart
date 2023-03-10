
import 'package:get/get.dart';
import 'package:newsapp/app/modules/auth/controllers/auth_controller.dart';

class AuthBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }

}