import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_time.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchTime extends Equatable {
  SearchTime({
    this.tz,
    this.stime,
    this.vtime,
  });

  final String tz;
  final DateTime stime;
  final int vtime;

  @override
  List<Object> get props => [tz, stime, vtime];

  static SearchTime fromJson(Map<String, dynamic> json) =>
      _$SearchTimeFromJson(json);
  Map<String, dynamic> toJson() => _$SearchTimeToJson(this);
}

