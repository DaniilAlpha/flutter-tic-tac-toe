import "package:flutter/foundation.dart";
import "package:tic_tac_toe/game/domain/entities/ai.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";

final class PickBestUsecase {
  PickBestUsecase(Ai ai) : _ai = ai;

  final Ai _ai;

  Future<FieldPos> call(CellValue cellValue) =>
      compute(_ai.pickBestPosFor, cellValue);
}
