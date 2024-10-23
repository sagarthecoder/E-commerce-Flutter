import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Controller/LanguageController.dart';
import '../Model/LanguageEnum.dart';

class LanguageView extends StatelessWidget {
  final controller = Get.find<LanguageController>();
  LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final list = LanguageEnum.values;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.language ?? "Language",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: list.length,
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            final item = list[index];

            return GestureDetector(
              onTap: () {
                controller.setNewLanguage(item.getLocale());
              },
              child: Obx(() {
                final isSelected =
                    (item.getLocale() == controller.currentLocale.value);
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isSelected
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          item.getTitle(),
                          style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.onSurface,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      _setSelectedIconIfNeeded(isSelected),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  Widget _setSelectedIconIfNeeded(bool isSelected) {
    if (isSelected) {
      return const Positioned(
        top: 16,
        right: 16,
        child: Icon(
          Icons.check_circle,
          color: Colors.lightGreenAccent,
          size: 40,
        ),
      );
    } else {
      return Container();
    }
  }
}
