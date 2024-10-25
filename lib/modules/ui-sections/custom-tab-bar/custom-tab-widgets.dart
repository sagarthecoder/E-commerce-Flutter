import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/custom-tab-bar/custom-tab-controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../dashboard/home/views/dashboard-screen.dart';

class CustomTabbedWidget extends StatelessWidget {
  const CustomTabbedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final CustomTabController tabController = Get.put(CustomTabController());
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: TabBar(
        tabs: tabController.tabs,
        controller: tabController.controller,
      ),
      body: TabBarView(
        controller: tabController.controller,
        children: [
          DashboardScreen(),
          Text("Search"),
          Text("Cart"),
          Text("Setting"),
        ],
      ),
    );
  }
}
