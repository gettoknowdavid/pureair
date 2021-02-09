
import '../../features/aqi/domain/entities/aqi.dart';

String getHealthRiskMessage(Aqi aqi) {
  var domPol = aqi.data.dominentpol;

  if (domPol == 'co') {
    return 'CO can cause headache, dizziness, vomiting, and nausea. Long term exposure could lead to death.';
  } else if (domPol == 'no2') {
    return 'Long term exposure to NO\u2082 may decrease your lung function and increase risk of respiratory symptoms.';
  } else if (domPol == 'o3') {
    return 'If you\'re asthmatic, O\u2083 is dangerous for you. It is also linked to abnormal lung development in children.';
  } else if (domPol == 'pm10') {
    return 'Coughing, asthma attacks, bronchitis, high blood pressure, premature death are a few risks of PM10.';
  } else if (domPol == 'pm25') {
    return 'PM2.5 may cause asthma, respiratory inflammation, deteriorated lung functions and even cancer.';
  } else {
    return 'SO\u2082 can cause accumulation of fluid in the lungs, coughing, asthma, difficult breathing, etc.';
  }
}
