import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(
      text: "Home",
      icon: Icon(Icons.home),
    ),
    Tab(
      text: "Search",
      icon: Icon(Icons.search_outlined),
    ),
    Tab(
      text: "Cart",
      icon: Icon(Icons.add_shopping_cart_outlined),
    ),
    Tab(
      text: "History",
      icon: Icon(Icons.history),
    ),
    Tab(
      text: "Settings",
      icon: Icon(Icons.settings),
    )
  ];
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
