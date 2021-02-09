import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../entities/condition_enum.dart';


class ConditionParams extends Equatable {
  ConditionParams({@required this.condition});

  final ConditionEnum condition;

  @override
  List<Object> get props => [condition];
}
