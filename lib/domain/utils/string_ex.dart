extension StringEx on String {
  String truncate(int cutoff) {
    return (length <= cutoff) ? this : '${substring(0, cutoff)}...';
  }
}