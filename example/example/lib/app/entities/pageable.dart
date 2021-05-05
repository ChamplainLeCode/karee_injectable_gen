class Pageable {
  final int pageSize;
  final int currentPage;

  Pageable.fromSize(this.pageSize) : currentPage = 1;

  Pageable(this.pageSize, this.currentPage);
}

class Page<T> {
  Page.empty();
}
