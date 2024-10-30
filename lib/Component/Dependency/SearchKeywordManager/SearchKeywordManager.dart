import 'package:shared_preferences/shared_preferences.dart';

import 'ISearchKeywordManager.dart';

class SearchKeywordManager implements ISearchKeywordManager {
  static final searchKeywordManager = SearchKeywordManager._internal();
  late SharedPreferences _prefs;
  final _prefsKey = "prefsKey";
  List<String> _nowSearchKeyword = [];

  SearchKeywordManager._internal() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _nowSearchKeyword = await _readSaveKeyword();
  }

  Future<List<String>> _readSaveKeyword() async {
    return await _prefs.getStringList(_prefsKey) ?? [];
  }

  Future<void> _prefsKeySave() async {
    await _prefs.setStringList(_prefsKey, _nowSearchKeyword);
  }

  @override
  void saveKeyword({required String keyword}) async {
    _nowSearchKeyword.add(keyword);
      await _prefsKeySave();
  }

  @override
  List<String> nowSaveKeyword() {
    return _nowSearchKeyword;
  }

  @override
  void keywordRemove({required String keyword}) async {
    _nowSearchKeyword.remove(keyword);
    await _prefsKeySave();
  }
}
