import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/aqi.dart';

part 'health_situation.g.dart';

@JsonSerializable(explicitToJson: true)
class HealthSituation extends Equatable {
  HealthSituation({
    this.situation,
    this.model,
    this.message,
    this.pollutants,
  });

  final SituationEnum situation;
  final Aqi model;
  final String message;
  final List<Map<String, String>> pollutants;

  @override
  List<Object> get props => [situation, model, message, pollutants];

  static HealthSituation fromJson(Map<String, dynamic> json) =>
      _$HealthSituationFromJson(json);
  Map<String, dynamic> toJson() => _$HealthSituationToJson(this);
}

enum SituationEnum { none, asthma, bronchitis, lungCancer, emphysema, hbp }
