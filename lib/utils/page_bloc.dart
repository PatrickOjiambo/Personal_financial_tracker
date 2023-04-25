import 'dart:async';

class PageBloc {
  final _pageTitleController = StreamController<String>();

  Stream<String> get pageTitleStream => _pageTitleController.stream;

  void setPageTitle(String title) {
    _pageTitleController.add(title);
  }

  void dispose() {
    _pageTitleController.close();
  }
}
