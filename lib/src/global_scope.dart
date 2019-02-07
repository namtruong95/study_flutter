class GlobalScope {
  static final GlobalScope _globalScope = new GlobalScope._internal();
  factory GlobalScope() => _globalScope;
  GlobalScope._internal();

  String token = '';

  void clear() {
    this.token = '';
  }
}
