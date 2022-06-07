import 'package:basic_flutter/mixins/style/color.dart';
import 'package:basic_flutter/mixins/style/text.dart';
import 'package:basic_flutter/ui/home/controllers/home_controller.dart';
import 'package:basic_flutter/ui/home/widget/loading_section.dart';
import 'package:basic_flutter/ui/home/widget/row_character.dart';
import 'package:basic_flutter/ui/home/widget/section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller=Get.find<HomeController>();
    return SafeArea(
      child: Scaffold(
        appBar: const SectionHeader(),
        body: Obx((){
          if(_controller.isLoading && _controller.list.isEmpty) {
            return const LoadingSection();
          }else{
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollNotification){
                  if(scrollNotification.metrics.pixels==scrollNotification.metrics.maxScrollExtent){
                    if(_controller.isNoLoadMore==false){
                      if(_controller.isLoading==false){
                        _controller.callAPI();
                      }
                    }
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: ()async{
                    _controller.callAPI(refresh: true);
                  },
                  child: _controller.list.isEmpty?
                      const CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            child: Center(child: Text("No Data Available",style: kTextAveHev18,)),
                          )
                        ],
                      ):
                      ListView.builder(
                      itemCount: _controller.getItemLength(),
                      itemBuilder: (BuildContext context,int index){
                        if(index<_controller.list.length){
                          return RowCharacter(character:_controller.list[index]);
                        }else{
                          return const LoadingSection();
                        }
                      }
                  ),
                ),
              );
          }
        }),
      ),
    );
  }
}
