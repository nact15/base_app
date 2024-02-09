part of 'dto.dart';

@freezed
class WeatherDto with _$WeatherDto {
  const factory WeatherDto({
    required WeatherLocationDto location,
    required WeatherCurrentDto current,
  }) = _WeatherDto;

  factory WeatherDto.fromJson(Map<String, dynamic> json) => _$WeatherDtoFromJson(json);
}

@freezed
class WeatherLocationDto with _$WeatherLocationDto {
  const factory WeatherLocationDto({
    required String name,
    required String region,
    required String country,
    required double lat,
    required double lon,
  }) = _WeatherLocationDto;

  factory WeatherLocationDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherLocationDtoFromJson(json);
}

@freezed
class WeatherCurrentDto with _$WeatherCurrentDto {
  const factory WeatherCurrentDto({
    @JsonKey(name: 'last_updated')
    required String lastUpdated,
    @JsonKey(name: 'temp_c')
    required double tempC,
    @JsonKey(name: 'is_day')
    required int isDay,
    @JsonKey(name: 'wind_kph')
    required double windKph,
    @JsonKey(name: 'wind_degree')
    required double windDegree,
    @JsonKey(name: 'wind_dir')
    required String windDir,
    @JsonKey(name: 'feelslike_c')
    required double feelslikeC,
    @JsonKey(name: 'precip_mm')
    required double precipMm,
    @JsonKey(name: 'gust_kph')
    required double gustKph,
    @JsonKey(name: 'vis_km')
    required double visKm,
    required double uv,
    required double cloud,
    required int humidity,
    required WeatherConditionDto condition,
  }) = _WeatherCurrentDto;

  factory WeatherCurrentDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherCurrentDtoFromJson(json);
}

@freezed
class WeatherConditionDto with _$WeatherConditionDto {
  const factory WeatherConditionDto({
    required String text,
    required String icon,
    required int code,
  }) = _WeatherConditionDto;

  factory WeatherConditionDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionDtoFromJson(json);
}

