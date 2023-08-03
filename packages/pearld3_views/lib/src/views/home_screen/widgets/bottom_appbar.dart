import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20,
      shape: const CircularNotchedRectangle(),
      height: 60,
      notchMargin: 5,
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'net'.tr(),
                          style: context.titleSmall,
                          children: [
                        TextSpan(
                          //todo
                            text: " :  ${state.netWeight.toStringAsFixed(3)}  ${"kg".tr()}",
                            style: context.titleSmallRed)
                      ])),
                  Text("${state.pickedOrdersCount} ${"total_order".tr()}")
                ],
              ),
            );

          return Container();
        },
      ),
    );
  }
}
