import 'package:cura/model/enums/edge_enum.dart';
import 'package:cura/model/enums/exudate_enum.dart';
import 'package:cura/model/enums/phase_enum.dart';

class EnumConverter {
  static PhaseEnum stringToPhaseEnum(String str) {
    switch (str) {
      case "Hemostasis":
        return PhaseEnum.hemostasis;
      case "Inflammation":
        return PhaseEnum.inflammatory;
      case "Proliferation":
        return PhaseEnum.proliferative;
      case "Maturation":
        return PhaseEnum.maturation;

      default:
        throw Exception("Invalid PhaseEnum");
    }
  }

  static EdgeEnum stringToEdgeEnum(String str) {
    switch (str) {
      case "diffuse":
        return EdgeEnum.diffuse;
      case "defined":
        return EdgeEnum.defined;
      case "rolled":
        return EdgeEnum.rolled;
      case "undefined":
        return EdgeEnum.undefined;

      default:
        throw Exception("Invalid EdgeEnum");
    }
  }

  static ExudateEnum stringToExudateEnum(String str) {
    switch (str) {
      case "serous":
        return ExudateEnum.serous;
      case "sanguineous":
        return ExudateEnum.sanguineous;
      case "serosanguinous":
        return ExudateEnum.serosanguinous;
      case "purulent":
        return ExudateEnum.purulent;
      case "undefined":
        return ExudateEnum.undefined;
      default:
        throw Exception("Invalid ExudateEnum");
    }
  }
}
