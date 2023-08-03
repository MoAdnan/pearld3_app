import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/app_bar.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/bottom_appbar.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/order_tile.dart';
import '../widget/circular_progress.dart';
import '../widget/logout_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());
  FocusNode focusNode = FocusNode();

  Future<bool> onPop(BuildContext context) async {
    context.showAlert(
      cancelText: 'no'.tr(),
      confirmText: 'yes'.tr(),
      title: 'logout_warning'.tr(),
      onCancel: () => context.pop(),
      onConfirm: () {
        context.read<LoginBloc>().add(LogOut(context));
      },

        buttonTextStyle: context.buttonTextStyle.copyWith(color: context.primaryColor ),
    titleStyle:    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),);
    return false;
  }

  void _selectOrder(BuildContext context, OrderModel? order) {
    context
        .read<OrderViewBloc>()
        .add(SelectOrderAndLoadItemsEvent(order: order!));
    FocusScope.of(context).requestFocus(FocusNode());

    context.push(Routes.ORDERVIEW);
  }

  void _getNewOrder(BuildContext context) {
    var orderStream;
    context.read<OrderBloc>().add(LoadNewOrderEvent());

    orderStream = context.read<OrderBloc>().stream.listen((state) {


      if (state is OrderLoaded ) {

        _selectOrder(context, state.orders.first);
        orderStream.cancel();
      }
      else if(state is OrderError){
        context.showErrorSnackBar(state.error.message!);
        orderStream.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 5)).then((value) => context.read<OrderBloc>().add(LoadingTestEvent()));
    return WillPopScope(
      onWillPop: () => onPop(context),
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: CustomAppBar(
            searchBar: CustomSearchBar(
              onClear: () {
                context.pop();
                context
                    .read<OrderBloc>()
                    .add(LoadOrderEvent(dateTime: _selectedDate.value));
              },
              height: 40,
              onSearch: (value) {
                context.read<OrderBloc>().add(SearchOrderEvent(keyword: value));
              },
            ),
            leading: const SettingsButton(),
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButtonWidget(
                  icon: Icons.qr_code,
                  size: 30,
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CalenderButton(
                  onDateChanged: (selectedDate) {
                    _selectedDate.value = selectedDate;
                    context
                        .read<OrderBloc>()
                        .add(LoadOrderEvent(dateTime: selectedDate));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: const LogoutButton(),
              ),
              kWidth8
            ]),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {

      return AbsorbPointer(

        absorbing: state is OrderLoading,
        child: ListView.builder(
          itemCount: state.searchResult.length,
          itemBuilder: (context, index) {
            return OrderTile(
              index: index,
              order: state.searchResult[index],
              onTap:  () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                _selectOrder(context, state.searchResult[index]);
              },
            );
          },
        ),
      );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomAppBar(),
        floatingActionButton: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            log(state.toString());
            if (state is OrderLoading) {
              return FloatingActionButton(
                backgroundColor: context.colorWhite,
                onPressed: null,
                child: const CircularProgressWidget(),
              );
            } else {
              return FloatingActionButton(
                backgroundColor: context.primaryColor,
                onPressed: () => _getNewOrder(context),
                child: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
