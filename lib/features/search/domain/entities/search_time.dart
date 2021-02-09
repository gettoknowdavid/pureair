import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/search_time.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchTime extends Equatable {
  SearchTime({
    this.tz,
    this.stime,
    this.vtime,
  });

  final String tz;
  final String stime;
  final int vtime;

  static SearchTime fromJson(Map<String, dynamic> json) =>_$SearchTimeFromJson(json);
  Map<String, dynamic> toJson() => _$SearchTimeToJson(this);

  @override
  List<Object> get props => [tz, stime, vtime];
}

