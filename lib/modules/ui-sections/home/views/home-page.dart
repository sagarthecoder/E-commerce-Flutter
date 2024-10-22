import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/custom-tab-bar/custom-tab-widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabbedWidget(),
    );
  }
}
