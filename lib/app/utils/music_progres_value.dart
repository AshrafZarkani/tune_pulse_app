mixin HelperMusicProgressValue {
  double getDurationAsDouble(int? durationValue) {
    if (durationValue != null) {
      double durationAsDouble = durationValue / 1000;
      return durationAsDouble;
    }
    return 0.0;
  }
}
