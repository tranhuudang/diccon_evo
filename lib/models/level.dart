enum Level{
  beginner,
  elementary,
  intermediate,
  advanced
}
extension LevelExtension on Level{
  String toLevelNameString(){
    switch (this) {
      case Level.beginner:
        return "beginner";
      case Level.elementary:
        return "elementary";
      case Level.intermediate:
        return "intermediate";
      case Level.advanced:
        return "advanced";
    }
  }
}