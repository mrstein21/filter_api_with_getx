import 'package:basic_flutter/mixins/logging/logger.dart';
import 'package:basic_flutter/model/res/character_res.dart';
import 'package:get/get.dart';

import '../mixins/constant/constant.dart';
import '../mixins/network/error_handling.dart';

class CharacterProvider extends GetConnect{
  @override
  void onInit() {
    super.onInit();
    allowAutoSignedCert = true;
    httpClient.baseUrl = kUrlAPI;
    httpClient.timeout = const Duration(milliseconds: kConnectionTimeout);
  }


  Future<CharacterRes> getCharacter(int page,{
    String name="",
    String status="",
    String gender="",
    String species=""
  }) async {
    try{
      final response = await get(
        '/character',
        query: {
          'page':'$page',
          'name':name,
          'status':status,
          'species':species,
          'gender':gender
        },
      );
      if(response.hasError){
        return Future.error(ErrorHandling(response));
      }
      return CharacterRes.fromJson(response.body);
    } catch (e, s) {
      logger.e('getCharacter', e, s);
        return Future.error(ErrorHandling(e.toString()));
    }
  }

}