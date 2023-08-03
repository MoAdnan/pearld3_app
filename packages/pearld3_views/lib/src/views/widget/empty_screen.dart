import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/widget/text_context_widget.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key,
      this.height = 400,
      this.width = double.infinity,
      required this.headingText,
      required this.subHeadingText});
  final double height;
  final double width;
  final String headingText;
  final String subHeadingText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off,
            size: 50,
          ),
          kHeight12,
          TextContextWidget(
            headingText: headingText,
            styleFromContext: context.bodyExtraSmall!.copyWith(
                color: context.colorBlack,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          kHeight4,
          TextContextWidget(
            headingText: subHeadingText,
            textAlign: TextAlign.center,
            styleFromContext: context.bodyExtraSmall!.copyWith(
              color: context.colorGrey,
              fontSize: 15,
            ),
          ),
          kHeight32,
          // ButtonWidget(
          //     height: 40, width: 200, buttonText: 'Retry', onTap: () {})
        ],
      ),
    );
  }
}
