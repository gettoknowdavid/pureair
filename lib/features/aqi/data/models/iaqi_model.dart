import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/iaqi.dart';
import 'dew_model.dart';

part './generated/iaqi_model.g.dart';

@JsonSerializable(explicitToJson: true)
class IaqiModel extends Iaqi {
  IaqiModel({
    @required DewModel dew,
    @required DewModel h,
    @required DewModel co,
    @required DewModel no2,
    @required DewModel o3,
    @required DewModel so2,
    @required DewModel p,
    @required DewModel pm10,
    @required DewModel pm25,
    @required DewModel t,
    @required DewModel w,
  }) : super(dew: dew, h: h, co: co, no2: no2, o3: o3, so2: so2, p: p, pm10: pm10, pm25: pm25, t: t, w: w);

  static IaqiModel fromJson(Map<String, dynamic> json) => _$IaqiModelFromJson(json);
   @override
  Map<String, dynamic> toJson() => _$IaqiModelToJson(this);
}
