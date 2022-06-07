import 'package:basic_flutter/mixins/constant/constant.dart';
import 'package:basic_flutter/mixins/dialog/dialog.dart';
import 'package:basic_flutter/mixins/style/color.dart';
import 'package:basic_flutter/mixins/style/text.dart';
import 'package:basic_flutter/model/character.dart';
import 'package:basic_flutter/model/res/character_res.dart';
import 'package:basic_flutter/provider/character_provider.dart';
import 'package:basic_flutter/ui/home/widget/filter_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final RxList<Character> _list=<Character>[].obs;

  final _provider=Get.find<CharacterProvider>();

  RxList get list => _list;

  final RxBool _isNoLoadMore=false.obs;

  bool get isNoLoadMore=> _isNoLoadMore.value;

  int _page=1;

  final RxBool _isLoading=true.obs;

  bool get isLoading=> _isLoading.value;

  TextEditingController? _searchEditingController;

  TextEditingController get searchEditingController => _searchEditingController!;

  TextEditingController? _speciesEditingController;

  TextEditingController get speciesEditingController => _speciesEditingController!;

  final RxString _initialValueStatus="".obs;

  String get initialValueStatus => _initialValueStatus.value;

  set initialValueStatus(String value)=>{
    _initialValueStatus.value=value
  };

  final RxString _initialValueGender="".obs;

  String get initialValueGender=>_initialValueGender.value;

  set initialValueGender(String value) =>{
    _initialValueGender.value=value
  };


  String _nameSearch="";
  String _filterStatus="";
  String _filterGender="";
  String _filterSpecies="";

  void searchByName(){
    _nameSearch=_searchEditingController!.text;
    _page=1;
    _list.clear();
    callAPI();
  }

  int getItemLength(){
    if(_isNoLoadMore.value==true){
      return _list.length;
    }
    return _list.length+1;
  }

  void submitFilter(){
    _list.clear();
    _nameSearch=_searchEditingController!.text;
    _filterSpecies=_speciesEditingController!.text;
    _filterGender=_initialValueGender.value;
    _filterStatus=_initialValueStatus.value;
    _page=1;
     callAPI();
  }


  void callAPI({bool refresh=false}){
    if(refresh==true){
      _isNoLoadMore.value=false;
      _page=1;
      _searchEditingController!.clear();
      _speciesEditingController!.clear();
      _initialValueStatus.value="";
      _initialValueGender.value="";
      _filterStatus="";
      _filterGender="";
      _nameSearch="";
      _list.clear();
    }
    _isLoading.value=true;
    _provider.getCharacter(_page,
        name: _nameSearch,
        gender: _filterGender,
        status: _filterStatus,
        species: _filterSpecies).then((CharacterRes res){
      _isLoading.value=false;
      if(res.results!.isEmpty){
        _isNoLoadMore.value=true;
      }
      if(res.results!.isNotEmpty){
        _page++;
        if(res.results!.length<5){
          _isNoLoadMore.value=true;
        }
        _list.addAll(res.results!);
      }
    }).onError((error, stackTrace){
        _isLoading.value=false;
        _isNoLoadMore.value=true;
        showSnackBar(error, onButtonClick: (){
      });
    });
  }

  void showDialog(){
    // showModalBottomSheet(
    //     isScrollControlled: true,
    //     context: Get.context!,
    //     builder: (_)=>const FilterDialog()
    // );
    Get.bottomSheet(const FilterDialog(),isScrollControlled: true);
  }


  @override
  void onInit() {
    _searchEditingController=TextEditingController();
    _speciesEditingController=TextEditingController();
    callAPI();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    _searchEditingController!.dispose();
    _speciesEditingController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}