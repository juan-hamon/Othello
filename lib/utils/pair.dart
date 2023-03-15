class Pair<T, Q> {
  final T row;
  final Q column;
  Pair(this.row, this.column);

  @override
  bool operator ==(Object other) {
    return other is Pair && row == other.row && column == other.column;
  }

  @override
  int get hashCode => this.row.hashCode + this.column.hashCode;
}
