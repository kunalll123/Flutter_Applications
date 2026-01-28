import 'dart:developer';
import 'package:flutter/material.dart';
import '../views/desktop_details_view.dart';
import '../views/mobile_details_view.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log("Constraints : $constraints");
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (constraints.maxWidth > 500)
                  ? const DesktopDetailsView()
                  : const MobileDetailsView(),
            ],
          ),
        );
      },
    );
  }
}
