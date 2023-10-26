import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';
import 'order_tile.dart';

/// A widget that displays a list of orders.
class OrderListWidget extends StatelessWidget {
  const OrderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          return Flexible(
            child: ListView.separated(
              itemCount: state.orders.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return OrderTile(
                  order: state.orders[index],
                  index: index,
                );
              },
              separatorBuilder: (context, index) => const Divider(thickness: 2),
            ),
          );
        } else if (state is OrderLoading) {
          return  CircularProgressWidget();
        } else if (state is OrderError) {
          return Center(
            child: Text(state.error.message!),
          );
        }
        return Text(state.toString());
      },
    );
  }
}
