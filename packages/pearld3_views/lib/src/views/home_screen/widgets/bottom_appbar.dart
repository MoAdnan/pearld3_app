import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

/// A custom BottomAppBar widget that displays information about orders and weight.
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20,
      shape: const CircularNotchedRectangle(),
      height: 80,
      notchMargin: 5,
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'net'.translate()} :",

                      style: context.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                        "${state.netWeight.toStringAsFixed(context.read<LoginBloc>().state.credential!.userCredential!.companySetting!.quantityRounding!)} ${"kg".translate()}",
                        style: context.titleSmallRed)
                  ],
                )
                // RichText(
                //     text: TextSpan(
                //
                //         text: 'net'.translate(),
                //         style: context.titleSmall,
                //         children: [
                //           TextSpan(
                //
                //               text:
                //               " : ${state.netWeight.toStringAsFixed(3)} ${"kg"
                //                   .translate()}",
                //               style: context.titleSmallRed)
                //         ])),
                ,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if(state is LoggedIn){
                          return Text(
                            "${state.credential!.userCredential!.employeeName}",
                            style: context.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          );
                        }
                        else
                          {
                            return Text(
                              "",
                              style: context.titleMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            );
                          }
                      },
                    ),
                    Text(
                        "${state.pickedOrdersCount} ${"total_order".translate()}"),
                  ],
                )
              ],
            ),
          );

          return Container();
        },
      ),
    );
  }
}
