class WeeklyTrendResult {
  final int currentWeekCount;
  final int lastWeekCount;

  WeeklyTrendResult({
    required this.currentWeekCount,
    required this.lastWeekCount,
  });

  int get difference => currentWeekCount - lastWeekCount;
  bool get isImproved => difference > 0;
}
