import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabwa_french/app/controllers/words_controller.dart';
import 'package:tabwa_french/app/views/home/components/main_menu.dart';

import '../../models/translation.dart';
import '../../models/word.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  final WordsController _wordsController = Get.find<WordsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get.dialog(const MainMenu(),
                transitionCurve: Curves.linearToEaseOut);
          },
        ),
        title: Text("tabwa french dictionnary".tr),
        actions: [
          CircleAvatar(
            child: Obx(() {
              return Text(_wordsController.words.length.toString());
            }),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemBuilder: (context, index) {
            Word word = _wordsController.words[index];
            List<Translation> _translations = word.translations;
            String _traa = "";
            if (_translations.isNotEmpty) {
              _traa = _translations.first.translation;
            }
            return Card(
              child: ListTile(
                title: Text(word.word),
                subtitle: Text(_traa),
                trailing: IconButton(
                  icon: const Icon(Icons.bookmark_add),
                  onPressed: () {},
                ),
                onTap: () {},
              ),
            );
          },
          itemCount: _wordsController.words.length,
        );
      }),
    );
  }
}
