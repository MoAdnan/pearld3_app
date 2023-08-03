import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/constants/app_spaces.dart';
import 'icon_widget.dart';

class SelectPrinter extends StatefulWidget {
  const SelectPrinter({Key? key}) : super(key: key);

  @override
  State<SelectPrinter> createState() => _SelectPrinterState();
}

class _SelectPrinterState extends State<SelectPrinter> {
  late String printerName;
  late String printerCode;
  @override
  void initState() {
    printerName = 'not_selected'.tr();
    printerCode = '00';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              printerName,
              style:  TextStyle(
                color: context.colorBlack,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: .1,
              ),
            ),
            Text(
              printerCode,
              style:  TextStyle(
                color: context.colorGrey,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpacing: .1,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconWidget(
              icon: Icons.close,
              onTap: () {},
            ),
            kWidth16,
            IconWidget(
              icon: Icons.print,
              onTap: () {},
            ),
            kWidth16,
            IconWidget(
              icon: Icons.list,
              onTap: () {
                List<Item> items = [
                  Item('Printer1', '1111'),
                  Item('Printer2', '2222'),
                  Item('Printer3', '3333'),
                ];
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Printer'),
                      content: Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            Item item = items[index];
                            return ListTile(
                              title: Text(item.heading),
                              subtitle: Text(item.subheading),
                              onTap: () {
                                setState(() {
                                  printerName = item.heading;
                                  printerCode = item.subheading;
                                });
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            );
                          },
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                    ;
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class Item {
  String heading;
  String subheading;

  Item(this.heading, this.subheading);
}
