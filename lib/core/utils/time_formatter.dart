class TimeFormatter {
  static String formatTime(int timeMs) {
    if (timeMs <= 0 || timeMs >= 99999999) return "--:--.--";

    final h = timeMs ~/ 3600000;
    final m = (timeMs ~/ 60000) % 60;
    final s = (timeMs ~/ 1000) % 60;
    final ms = (timeMs % 1000) ~/ 10;

    if (h > 0) {
      return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}";
    } else {
      return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}";
    }
  }
}

class CategoryFormatter {
  static String formatDivision(String code) {
    final cleanCode = code.toUpperCase().trim();
    if (cleanCode == "RA1") return "Ragazzi 1°";
    if (cleanCode == "RAG") return "Ragazzi";
    if (cleanCode == "JUN") return "Junior";
    if (cleanCode == "U23") return "Under 23";
    if (cleanCode == "SEN") return "Senior";
    if (cleanCode.startsWith("MA") && cleanCode.length == 3) {
      return "Master ${cleanCode.substring(2)}";
    }
    if (cleanCode.startsWith("MAX")) {
      return "Master ${cleanCode.substring(3)}";
    }
    return code;
  }

  static String formatCategory(String code) {
    final cleanCode = code.toUpperCase().trim();
    if (cleanCode == "M") return "Maschile";
    if (cleanCode == "F") return "Femminile";
    if (cleanCode == "X") return "Misto";
    return code;
  }

  static String formatTimeProgressionKey(String key) {
    final parts = key.split('_');
    if (parts.length >= 3) {
      String boat = "";
      String distance = "";
      String category = "";

      for (var part in parts) {
        if (RegExp(r'^[0-9]+$').hasMatch(part)) {
          distance = part;
        } else if (part.length == 1 && (part == "M" || part == "F" || part == "X")) {
          category = formatCategory(part);
        } else {
          boat = part;
        }
      }
      return "$boat ${distance}m $category".trim();
    }
    return key.replaceAll('_', ' ');
  }
}
