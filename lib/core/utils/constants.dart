
// import '../../features/air_quality/data/models/favourites_model.dart';
// import '../../features/air_quality/data/models/geo_model.dart';
// import '../../features/air_quality/data/models/air_quality_model.dart';
// import '../../features/air_quality/data/models/attribution_model.dart';
// import '../../features/air_quality/data/models/city_model.dart';
// import '../../features/air_quality/data/models/daily_model.dart';
// import '../../features/air_quality/data/models/data_model.dart';
// import '../../features/air_quality/data/models/debug_model.dart';
// import '../../features/air_quality/data/models/dew_model.dart';
// import '../../features/air_quality/data/models/forecast_model.dart';
// import '../../features/air_quality/data/models/iaqi_model.dart';
// import '../../features/air_quality/data/models/o3_model.dart';
// import '../../features/air_quality/data/models/time_model.dart';

// import '../../features/air_quality/domain/entities/air_quality.dart';
// import '../../features/air_quality/domain/entities/attribution.dart';
// import '../../features/air_quality/domain/entities/city.dart';
// import '../../features/air_quality/domain/entities/daily.dart';
// import '../../features/air_quality/domain/entities/data.dart';
// import '../../features/air_quality/domain/entities/debug.dart';
// import '../../features/air_quality/domain/entities/dew.dart';
// import '../../features/air_quality/domain/entities/forecast.dart';
// import '../../features/air_quality/domain/entities/iaqi.dart';
// import '../../features/air_quality/domain/entities/o3.dart';
// import '../../features/air_quality/domain/entities/time.dart';

// final tAirQuality = AirQuality(
//   status: 'Test status',
//   data: Data(
//     aqi: 1,
//     idx: 1,
//     attributions: <Attribution>[
//       Attribution(
//         url: 'Test url',
//         name: 'Test name',
//         logo: 'Test logo',
//       ),
//     ],
//     city: City(
//       geo: [1.1, 1.1],
//       name: 'Test city name',
//       url: 'Test city url',
//     ),
//     dominentpol: 'Test dominentpol',
//     iaqi: Iaqi(
//       dew: Dew(v: 1),
//       h: Dew(v: 1),
//       p: Dew(v: 1),
//       pm25: Dew(v: 1),
//       t: Dew(v: 1),
//       w: Dew(v: 1.0),
//     ),
//     time: Time(
//       s: '2021-01-14 23:00:00',
//       tz: '+01:00',
//       v: 1610665200,
//       iso: '2021-01-14T23:00:00+01:00',
//     ),
//     forecast: Forecast(
//       daily: Daily(
//         o3: [O3(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//         pm10: [O3(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//         pm25: [O3(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//         uvi: [O3(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//       ),
//     ),
//     debug: Debug(sync: '2021-01-15T08:43:25+09:00'),
//   ),
// );

// final tAirQualityModel = AirQualityModel(
//   status: 'Test status',
//   data: DataModel(
//     aqi: 1,
//     idx: 1,
//     attributions: <AttributionModel>[
//       AttributionModel(
//         url: 'Test url',
//         name: 'Test name',
//         logo: 'Test logo',
//       ),
//     ],
//     city: CityModel(
//       geo: [1.1, 1.1],
//       name: 'Test city name',
//       url: 'Test city url',
//     ),
//     dominentpol: 'Test dominentpol',
//     iaqi: IaqiModel(
//       dew: DewModel(v: 1),
//       h: DewModel(v: 1),
//       p: DewModel(v: 1),
//       pm25: DewModel(v: 1),
//       t: DewModel(v: 1),
//       w: DewModel(v: 1.0),
//     ),
//     time: TimeModel(
//       s: '2021-01-14 23:00:00',
//       tz: '+01:00',
//       v: 1610665200,
//       iso: '2021-01-14T23:00:00+01:00',
//     ),
//     forecast: ForecastModel(
//       daily: DailyModel(
//         o3: [O3Model(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//         pm10: [O3Model(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//         pm25: [O3Model(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//         uvi: [O3Model(avg: 1, day: '2021-01-13', max: 1, min: 1)],
//       ),
//     ),
//     debug: DebugModel(sync: '2021-01-15T08:43:25+09:00'),
//   ),
// );

// final tFavouritesModel = FavouritesModel(
//   geos: <GeoModel>[GeoModel(lat: 1.1, lon: 1.1)],
//   airQualities: <AirQualityModel>[tAirQualityModel],
// );

