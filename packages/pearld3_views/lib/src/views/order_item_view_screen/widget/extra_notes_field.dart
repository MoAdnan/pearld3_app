import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';

class ExtraNotesField extends StatelessWidget {
  TextEditingController controller ;
   ExtraNotesField({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: context.locale.languageCode=='en'? Alignment.centerRight : Alignment.centerLeft,
        child: SizedBox(
          height: 37,
          width: 250,
          child: TextField(
            maxLength: 25,
            controller: controller,
            // autofocus: true,
            decoration: InputDecoration(

              prefixIcon:Icon(Icons.report,color: context.colorGrey,),
              contentPadding: const EdgeInsets.only(top: 1,bottom: 1),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: context.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: context.primaryColor)),
              hintText: 'type_message'.tr(),
              counterText: "",
            ),
          ),
        ),
      ),
    );
  }
}
