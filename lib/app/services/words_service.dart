import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import '../../system/helpers/log_cat.dart';
import '../models/word.dart';

class WordsService extends GetxService {
  var words = <Word>[].obs;
  var word = Rxn<Word>();
  var isLoading = true.obs;
  var categorie = 'tabwa'.obs;
  var searchedWord = ''.obs;
  var isSearching = false.obs;
  var filteredWords = <Word>[].obs;
  var searchEditingController = TextEditingController().obs;

  @override
  void onInit() {
    GetStorage().writeIfNull('categorie', categorie.value);
    categorie.value = GetStorage().read('categorie');
    loop(getAll, duration: const Duration(seconds: 3));
    super.onInit();
    GetStorage().listenKey('categorie', (value) {
      logcat("categorie: $value");
      if (value != null) categorie.value = value;
    });
  }

  @override
  void onReady() {
    super.onReady();
    debounce(
      searchedWord,
      (v) {
        if (words.value != null) {
          if (searchedWord.value.length > 0) {
            filteredWords.value = words.value
                .where(
                  (element) =>
                      element.word.toLowerCase().contains(
                            searchedWord.value.toLowerCase(),
                          ) &&
                      element.categorie.toLowerCase() ==
                          categorie.value.toLowerCase(),
                )
                .toList();
          } else {
            filteredWords.clear();
          }
        }
      },
      time: const Duration(milliseconds: 500),
    );

    debounce(
      categorie,
      (v) {
        if (words.value != null) {
          if (searchedWord.value.length > 0) {
            filteredWords.value = words.value
                .where(
                  (element) =>
                      element.word.toLowerCase().contains(
                            searchedWord.value.toLowerCase(),
                          ) &&
                      element.categorie.toLowerCase() ==
                          categorie.value.toLowerCase(),
                )
                .toList();
          } else {
            filteredWords.clear();
          }
        }
      },
      time: const Duration(milliseconds: 500),
    );
  }

  void setCategorie(String categorie) {
    GetStorage().write('categorie', categorie);
  }

  void getAll() async {
    // logcat("You are in WordsService");
    List<Word> ll = await Word.getAll();
    if (ll.isNotEmpty) words.value = ll;
    words.value
        .sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
    if (word.value != null) updateActiveWord();
    /*   if (words.value != null) {
      if (searchedWord.value.length > 0) {
        filteredWords.value = words.value
            .where(
              (element) =>
                  element.word.toLowerCase().contains(
                        searchedWord.value.toLowerCase(),
                      ) &&
                  element.categorie.toLowerCase() ==
                      categorie.value.toLowerCase(),
            )
            .toList();
      } else {
        filteredWords.clear();
      }
    }*/
    isLoading.value = false;
  }

  void get(int index) async {
    word.value = words.elementAt(index);
  }

  setActiveWord(Word activeWord) {
    word.value = activeWord;
  }

  updateActiveWord() {
    word.value = words.value.firstWhere((wrd) => wrd.id == word.value!.id);
  }

  void addWord(Map<String, dynamic> word) async {
    isLoading.value = true;
    await Word.add(word);
    getAll();
    Get.back();
  }

  void editWord(Map<String, dynamic> word) async {
    isLoading.value = true;
    await Word.edit(word, this.word.value!.id);
    getAll();
    Get.back();
  }
}
