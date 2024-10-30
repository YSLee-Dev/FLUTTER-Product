abstract class ISearchKeywordManager {
  void saveKeyword({required String keyword}) ;
  List<String> nowSaveKeyword();
  void keywordRemove({required String keyword});
}