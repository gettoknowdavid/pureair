import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/themes.dart';

part 'pure_air_theme.g.dart';

@JsonSerializable(explicitToJson: true)
class PureAirTheme extends Equatable{
  final ThemeEnum theme;

  PureAirTheme(this.theme);
    @override
  List<Object> get props => [theme];

  static PureAirTheme fromJson(Map<String, dynamic> json) => _$PureAirThemeFromJson(json);
  Map<String, dynamic> toJson() => _$PureAirThemeToJson(this);

}