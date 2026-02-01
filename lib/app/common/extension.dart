extension DurationExtension on int{
  Duration get ms => Duration(milliseconds: this);
  Duration get micro => Duration(microseconds: this);
  Duration get sec => Duration(seconds: this);
  Duration get day => Duration(days: this);
  Duration get hour => Duration(hours: this);
  Duration get minute => Duration(minutes: this);
}