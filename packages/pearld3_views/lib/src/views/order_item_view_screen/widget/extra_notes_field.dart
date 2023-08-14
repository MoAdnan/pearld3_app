// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:pearld3_util/pearld3_util.dart';
// import 'package:pearld3_views/pearld3_views.dart';
// import 'package:pearld3_views/src/views/order_item_view_screen/widget/count_button.dart';
//
// class ItemCounter extends StatelessWidget {
//   num maxCount;
//   Function(num)? onChange;
//
//   ItemCounter({super.key, required this.maxCount, this.onChange});
//   ValueNotifier<num> count = ValueNotifier(0);
//   @override
//   Widget build(BuildContext context) {
//     count.value = maxCount;
//     return Expanded(
//       child: Align(
//         alignment: context.locale.languageCode == 'en'
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         child: SizedBox(
//           height: 37,
//           width: 240,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CountButton(
//                 icon: Icons.remove,
//                   onTap: () {
//                 if (count.value > 0) {
//                   count.value--;
//                 }
//               }),
//               ValueListenableBuilder(
//                 valueListenable: count,
//                 builder: (context, value, child) {
//                   onChange!(value);
//                   return Text(
//                     value.toString(),
//                     style: context.titleLarge!.copyWith(fontSize: 25,color: context.colorRed),
//                   );
//                 },
//               ),
//               CountButton(onTap: () {
//                 if (count.value < maxCount) {
//                   count.value++;
//                 }
//               }, icon: Icons.add)
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
