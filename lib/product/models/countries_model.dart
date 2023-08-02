import 'package:json_annotation/json_annotation.dart';

part 'countries_model.g.dart';

@JsonSerializable(createToJson: false)
class CountriesModel {
  String? name;
  String? emoji;
  String? emojiU;

  CountriesModel({this.name, this.emoji, this.emojiU});

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return _$CountriesModelFromJson(json);
  }
}
