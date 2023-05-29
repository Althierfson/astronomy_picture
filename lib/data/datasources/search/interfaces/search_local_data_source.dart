abstract class SearchLocalDataSource {
  /// Return a list [String] case is a success, otherwise
  /// throw a [Failure]
  Future<List<String>> getSearchHistory();

  /// Return a list [String] case is a success, otherwise
  /// throw a [Failure]
  Future<List<String>> updateSearchHistory(List<String> history);
}
