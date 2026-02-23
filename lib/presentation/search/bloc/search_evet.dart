abstract class SearchEvent {}

class SearchRequest extends SearchEvent {
  final String query;
  final String filter;

  SearchRequest(this.query, this.filter);
}
