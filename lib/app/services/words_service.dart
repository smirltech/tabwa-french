import 'dart:developer';

import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tabwa_french/system/helpers/helpers.dart';
import '../../system/helpers/log_cat.dart';
import '../models/buggy.dart';
import '../models/word.dart';
import '../routes/routes.dart';
import '../views/contributions/contributions_screen.dart';
import 'dart:math' as math;

class WordsService extends GetxService {
  var words = <Word>[].obs;
  var key_words = <String>[].obs;
  var word = Rxn<Word>();
  var isLoading = true.obs;
  var categorie = 'tabwa'.obs;
  var searchedWord = ''.obs;
  var isSearching = false.obs;
  var filteredWords = <Word>[].obs;
  var filteredProverbs = <Word>[].obs;
  var searchEditingController = TextEditingController().obs;

  var contributions = <Buggy>[].obs;

  updateContributionList() async {
    /* contributions.value = [
      Buggy(name: 'Landon', wa: 19, wm: 12, ta: 4, tm: 56),
      Buggy(name: 'Sari', wa: 22),
      Buggy(name: 'Julian', wa: 37),
      Buggy(name: 'Carey', wa: 39),
      Buggy(name: 'Cadu', wa: 43),
      Buggy(name: 'Delmar', wa: 72)
    ];
*/
    debounce(words, (v) {
      Map<String, Buggy> map = {};

      words.value.forEach((word) {
        if (map.containsKey(word.user)) {
          map[word.user]!.wa += 1;
        } else {
          map[word.user] = Buggy(name: word.user, wa: 1);
        }
        if (map.containsKey(word.updater)) {
          map[word.updater]!.wm += 1;
        } else {
          map[word.updater] = Buggy(name: word.updater, wm: 1);
        }

        word.translations.forEach((translation) {
          if (map.containsKey(translation.user)) {
            map[translation.user]!.ta += 1;
          } else {
            map[translation.user] = Buggy(name: translation.user, ta: 1);
          }
          if (map.containsKey(translation.updater)) {
            map[translation.updater]!.tm += 1;
          } else {
            map[translation.updater] = Buggy(name: translation.updater, tm: 1);
          }
        });
      });

      contributions.value = map.values.toList();
      contributions.value.sort((a, b) {
        var x = math.max(a.wa, math.max(a.wm, math.max(a.ta, a.tm)));
        var y = math.max(b.wa, math.max(b.wm, math.max(b.ta, b.tm)));
        // var x = a.wa + a.wm + a.ta + a.tm;
        //  var y = b.wa + b.wm + b.ta + b.tm;
        return y - x;
      });
    });
  }

  @override
  void onInit() {
    GetStorage().writeIfNull('categorie', categorie.value);
    categorie.value = GetStorage().read('categorie');
    //loop(getAll, duration: const Duration(seconds: 3));
    super.onInit();
    GetStorage().listenKey('categorie', (value) {
      logcat("categorie: $value");
      if (value != null) categorie.value = value;
    });
    getAllLocal();
    updateContributionList();
  }

  @override
  void onReady() {
    super.onReady();
   /* debounce(
      searchedWord,
      (v) {
        if (words.value != null) {
          if (searchedWord.value.length > 0) {
            filteredWords.value = words.value
                .where(
                  (element) => searchCriteria(element),
                )
                .toList();
            filteredProverbs.value = filteredWords.value
                .where(
                  (word) => word.translations.any(
                      (trans) => trans.type.toLowerCase().contains("prov")),
                )
                .toList();
          } else {
            filteredWords.value =
                words.value.where((word) => wordOfCategory(word)).toList();
            filteredProverbs.value = filteredWords.value
                .where(
                  (word) => word.translations.any(
                      (trans) => trans.type.toLowerCase().contains("prov")),
                )
                .toList();
          }
        }
      },
      time: const Duration(milliseconds: 500),
    );*/

   /* debounce(
      categorie,
      (v) {
        if (words.value != null) {
          if (searchedWord.value.length > 0) {
            filteredWords.value = words.value
                .where(
                  (element) => searchCriteria(element),
                )
                .toList();
            filteredProverbs.value = filteredWords.value
                .where(
                  (word) => word.translations.any(
                      (trans) => trans.type.toLowerCase().contains("prov")),
                )
                .toList();
          } else {
            filteredWords.value =
                words.value.where((word) => wordOfCategory(word)).toList();
            filteredProverbs.value = filteredWords.value
                .where(
                  (word) => word.translations.any(
                      (trans) => trans.type.toLowerCase().contains("prov")),
                )
                .toList();
          }
        }
      },
      time: const Duration(milliseconds: 500),
    );*/
  }

  void suggestAddingWord() async {
    Get.toNamed(Routes.addWord);
  }

  void loadProverbsScreen() async {
    Get.toNamed(Routes.proverb);
  }

  void setCategorie(String categorie) {
    GetStorage().write('categorie', categorie);
    word.value = null;
  }

  Future<void> getAll() async {
    // logcat("You are in WordsService");
    /*List<Word> ll =*/ await Word.getAll();
   /* if (ll != null) {
      key_words.clear();
      ll.forEach((element) {
        key_words.add(element.word.toLowerCase());
      });
      // logcat(key_words.toString());
    }
    if (ll.isNotEmpty) words.value = ll;
    words.value
        .sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
    if (searchedWord.value.length == 0) {
      filteredWords.value =
          words.value.where((word) => wordOfCategory(word)).toList();
      filteredProverbs.value = filteredWords.value
          .where(
            (word) => word.translations
                .any((trans) => trans.type.toLowerCase().contains("prov")),
          )
          .toList();
    }
    // if (ll.isNotEmpty) {_updateContributionList();}
    if (word.value != null) updateActiveWord();
*/
    isLoading.value = false;
  }

  updateFilters(){
    if (searchedWord.value.length == 0) {
      filteredWords.value =
          words.value.where((word) => wordOfCategory(word)).toList();
      filteredProverbs.value = filteredWords.value
          .where(
            (word) => word.translations
            .any((trans) => trans.type.toLowerCase().contains("prov")),
      )
          .toList();
    }
    if (word.value != null) updateActiveWord();
  }

  getAllLocalInit() {

      List<Word> vv = Word.listFromMap(GetStorage().read('words'));
      if (vv.isNotEmpty) {
        key_words.clear();
        vv.forEach((element) {
          key_words.add(element.word.toLowerCase());
        });
        // logcat(key_words.toString());
      }
      //log(vv.toString());
      vv.sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
      words.value = vv;
     updateFilters();

      isLoading.value = false;
  }
    getAllLocal() {
    getAllLocalInit();
    GetStorage().listenKey('words', (value) {
      List<Word> vv = Word.listFromMap(value);
      if (vv.isNotEmpty) {
        key_words.clear();
        vv.forEach((element) {
          key_words.add(element.word.toLowerCase());
        });
        // logcat(key_words.toString());
      }
      log("aa");
      vv.sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
      words.value = vv;
     updateFilters();
      isLoading.value = false;
    });
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

  bool searchCriteria(Word word) {
    if (searchedWord.value.length > 0) {
      return word.word.toLowerCase().contains(
                searchedWord.value.toLowerCase(),
              ) &&
          word.categorie.toLowerCase() == categorie.value.toLowerCase();
    } else {
      return false;
    }
  }

  bool wordOfCategory(Word word) {
    return word.categorie.toLowerCase() == categorie.value.toLowerCase();
  }
}
