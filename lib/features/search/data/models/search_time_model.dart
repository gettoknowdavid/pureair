import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/search_time.dart';

part 'generated/search_time_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchTimeModel extends SearchTime {
  SearchTimeModel({
    String tz,
    String stime,
    int vtime,
  }) : super(tz: tz, stime: stime, vtime: vtime);

  static SearchTimeModel fromJson(Map<String, dynamic> json) =>
      _$SearchTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchTimeModelToJson(this);
}
