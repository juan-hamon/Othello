class Pair<T, Q> {
  final T first;
  final Q second;
  Pair(this.first, this.second);

  @override
  bool operator ==(Object other) {
    return other is Pair && first == other.first && second == other.second;
  }

  @override
  int get hashCode => this.first.hashCode + this.second.hashCode;
}
