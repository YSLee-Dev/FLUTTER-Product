import 'package:shared_preferences/shared_preferences.dart';

import 'ISearchKeywordManager.dart';

class SearchKeywordManager implements ISearchKeywordManager {
  static  SearchKeywordManager? _searchKeywordManager;
  static late SharedPreferences _prefs;
  final _prefsKey = "prefsKey";

  SearchKeywordManager._internal();

  static Future<SearchKeywordManager> getInstance() async {
    if (_searchKeywordManager == null) {
      _searchKeywordManager = SearchKeywordManager._internal();
      await _initPrefs();
      return _searchKeywordManager!;
    } else {
      return _searchKeywordManager!;
    }
  }

  static Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<String>> _readSaveKeyword() async {
    return await _prefs.getStringList(_prefsKey) ?? [];
  }

  Future<void> _prefsKeySave({required List<String> keywords}) async {
    await _prefs.setStringList(_prefsKey, keywords);
  }

  @override
  Future<void> saveKeyword({required List<String> keywords})async {
      await _prefsKeySave(keywords: keywords);
  }

  @override
  Future<List<String>> nowSaveKeywordRequest() async {
    return await _readSaveKeyword();
  }
}
