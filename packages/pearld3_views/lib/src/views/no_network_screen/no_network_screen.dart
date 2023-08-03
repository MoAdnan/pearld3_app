import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
              size: 60,  color: context.errorColor,

              ),
              kHeight24,
              Text(
                'No Network Connection',
                style: context.bodyLarge!.copyWith(color: context.errorColor,fontSize: 17),
              ),
              kHeight12,
              Text(
                'Please connect to the internet to access this feature.',
                style: context.bodySmall!.copyWith(fontSize: 14),
              ),
              kHeight24,
              ButtonWidget(
                height: 50,
                width: 220,
                buttonText: 'Retry',
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
