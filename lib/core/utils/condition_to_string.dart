String conditionToString(dynamic input) {
  String name = input.toString().split('.').last;

  if (name == 'asthma')
    return 'Asthma';
  else if (name == 'bronchitis')
    return 'Bronchitis';
  else if (name == 'emphysema')
    return 'Emphysema';
  else if (name == 'lungCancer')
    return 'Lung Cancer';
  else if (name == 'hbp')
    return 'High Blood Pressure';
  else
    return 'None';
}