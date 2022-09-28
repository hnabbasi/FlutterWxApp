enum Severity {
  severe,
  moderate,
  unknown;

  int get toInt {
    switch(this){
      case Severity.severe:
        return 0;
      case Severity.moderate:
        return 1;
      default:
        return 99;
    }
  }

  static Severity fromString(String severity) {
    switch(severity.toLowerCase()){
      case "severe":
        return Severity.severe;
      case "moderate":
        return Severity.moderate;
      default:
        return Severity.unknown;
    }
  }

  static Severity fromInt(int integer) {
    switch(integer){
      case 0:
        return Severity.severe;
      case 1:
        return Severity.moderate;
      default:
        return Severity.unknown;
    }
  }
}