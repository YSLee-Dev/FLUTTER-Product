abstract class ISearchKeywordManager {
  Future<void> saveKeyword({required List<String> keywords});
  Future<List<String>> nowSaveKeywordRequest();
}