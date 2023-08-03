import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_views/pearld3_views.dart';

class CalenderButton extends StatelessWidget {
   Function(DateTime selectedDate)? onDateChanged;

  CalenderButton({Key? key, this.onDateChanged}) : super(key: key);

  ValueNotifier<DateTime> selectedDateTime = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: IconButtonWidget(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDateTime.value,
            firstDate: DateTime.now().copyWith(year: DateTime.now().year-1),
            lastDate: DateTime.now(),
            builder: (BuildContext context, Widget? child) {
              return ValueListenableBuilder(valueListenable: selectedDateTime, builder: (context, value, child2) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.white, // Customize the header color
                    hintColor: Colors.black, // Customize the selection color
                    colorScheme: const ColorScheme.light(primary: Colors.black),
                    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },);
            },
          );

          if (picked != null && picked != selectedDateTime) {

            selectedDateTime.value = picked;

            if (onDateChanged != null) {
              onDateChanged!(selectedDateTime.value);
            }
          }
        },

         icon: CupertinoIcons.calendar_today ,
          color: Colors.black,
          size: 26,
        ),

    );
  }
}
