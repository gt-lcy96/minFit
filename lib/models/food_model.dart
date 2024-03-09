// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FoodModel {
  String name;
  String serving_size;
  double calories;
  int? number_of_serving;
  FoodModel({
    required this.name,
    required this.serving_size,
    required this.calories,
    this.number_of_serving = 1,
  });

  FoodModel copyWith({
    String? name,
    String? serving_size,
    double? calories,
    int? number_of_serving,
  }) {
    return FoodModel(
      name: name ?? this.name,
      serving_size: serving_size ?? this.serving_size,
      calories: calories ?? this.calories,
      number_of_serving: number_of_serving ?? this.number_of_serving,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'serving_size': serving_size,
      'calories': calories,
      'number_of_serving': number_of_serving,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: (map['name'] ?? "") as String,
      serving_size: (map['serving size'] ?? "") as String,
      calories: (map['average calories'] ?? 0).toDouble(),
      number_of_serving: (map['number_of_serving'] ?? 1) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FoodModel(name: $name, serving_size: $serving_size, calories: $calories, number_of_serving: $number_of_serving)';
  }

  @override
  bool operator ==(covariant FoodModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.serving_size == serving_size &&
        other.calories == calories &&
        other.number_of_serving == number_of_serving;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        serving_size.hashCode ^
        calories.hashCode ^
        number_of_serving.hashCode;
  }
}
