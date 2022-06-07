import 'package:basic_flutter/provider/character_provider.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CharacterProvider());
    // TODO: implement dependencies
  }

}