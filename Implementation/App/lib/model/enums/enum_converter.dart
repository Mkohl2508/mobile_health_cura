import 'package:cura/model/enums/edge_enum.dart';
import 'package:cura/model/enums/exudate_enum.dart';
import 'package:cura/model/enums/form_enum.dart';
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

  static String phaseEnumToString(PhaseEnum phaseEnum) {
    switch (phaseEnum) {
      case PhaseEnum.hemostasis:
        return "Hemostasis";
      case PhaseEnum.inflammatory:
        return "Inflammation";
      case PhaseEnum.proliferative:
        return "Proliferation";
      case PhaseEnum.maturation:
        return "Maturation";

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

  static String edgeEnumToString(EdgeEnum edgeEnum) {
    switch (edgeEnum) {
      case EdgeEnum.diffuse:
        return "diffuse";
      case EdgeEnum.defined:
        return "defined";
      case EdgeEnum.rolled:
        return "rolled";
      case EdgeEnum.undefined:
        return "undefined";

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

  static String exudateEnumToString(ExudateEnum exudateEnum) {
    switch (exudateEnum) {
      case ExudateEnum.serous:
        return "serous";
      case ExudateEnum.sanguineous:
        return "sanguineous";
      case ExudateEnum.serosanguinous:
        return "serosanguinous";
      case ExudateEnum.purulent:
        return "purulent";
      case ExudateEnum.undefined:
        return "undefined";
      default:
        throw Exception("Invalid ExudateEnum");
    }
  }

  static FormEnum stringToFormEnum(String str) {
    switch (str) {
      case "Ellipse":
        return FormEnum.ellipse;
      case "Rectangle":
        return FormEnum.rectangle;
      case "Undefined":
        return FormEnum.undefined;
      default:
        throw Exception("Invalid FormEnum");
    }
  }

  static String formEnumToString(FormEnum formEnum) {
    switch (formEnum) {
      case FormEnum.ellipse:
        return "Ellipse";
      case FormEnum.rectangle:
        return "Rectangle";
      case FormEnum.undefined:
        return "Undefined";
      default:
        throw Exception("Invalid FormEnum");
    }
  }
}
