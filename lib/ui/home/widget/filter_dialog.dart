import 'package:basic_flutter/mixins/constant/constant.dart';
import 'package:basic_flutter/mixins/style/color.dart';
import 'package:basic_flutter/mixins/style/text.dart';
import 'package:basic_flutter/ui/home/controllers/home_controller.dart';
import 'package:basic_flutter/ui/widget/rounded_drop_down.dart';
import 'package:basic_flutter/ui/widget/rounded_textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller=Get.find<HomeController>();
    return Container(
      color: kColorWhite,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding),
      child:Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text("Filter Character",style: kTextAveHev16,),
                    InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: const Icon(Icons.close,color: kColorGreen,)
                    )
                  ],
                ),
                const SizedBox(height: kDefaultPadding/2,),
                const Divider(),
                const SizedBox(height: kDefaultPadding,),
                const Text("Species",style: kTextAveHev14,),
                const SizedBox(height: kDefaultPadding/5,),
                RoundedTextForm(textEditingController:  _controller.speciesEditingController, hint: "Species"),
                const SizedBox(height: kDefaultPadding/2,),
                const Text("Name",style: kTextAveHev14,),
                const SizedBox(height: kDefaultPadding/5,),
                RoundedTextForm(textEditingController:  _controller.searchEditingController, hint: "Character Name"),
                const SizedBox(height: kDefaultPadding/2,),
                const Text("Status",style: kTextAveHev14,),
                const SizedBox(height: kDefaultPadding/5,),
                Obx(
                  ()=> RoundedDropdown(
                      initialValue: _controller.initialValueStatus,
                      option: const ["alive","dead","unknown"],
                      label: "Select Status",
                      onSelected: (String? val){
                        _controller.initialValueStatus=val!;
                      },
                  ),
                ),
                const SizedBox(height: kDefaultPadding/2,),
                const Text("Gender",style: kTextAveHev14,),
                const SizedBox(height: kDefaultPadding/5,),
                Obx(
                    ()=> RoundedDropdown(
                      onSelected: (String? val){
                        _controller.initialValueGender=val!;
                      },
                      initialValue: _controller.initialValueGender, option:
                      const ["male","female","genderless","unknown"],
                      label: "Select Gender"
                  ),
                ),
                const SizedBox(height: kDefaultPadding/2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            )),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(kColorBlack)
                        ),
                        onPressed: (){
                          Get.back();
                          _controller.callAPI(refresh: true);
                        },
                        child: Text("Reset",style: kTextAveHev14.copyWith(
                            color: kColorWhite
                        ),)
                    ),
                    const SizedBox(width: kDefaultPadding,),
                    ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            )),
                            backgroundColor: MaterialStateProperty.all(kColorGreen)
                        ),
                        onPressed: (){
                          _controller.submitFilter();
                          Get.back();
                        },
                        child: Text("Filter",style: kTextAveHev14.copyWith(
                            color: kColorWhite
                        ),)
                    )
                  ],
                ),
                const SizedBox(height: kDefaultPadding,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
