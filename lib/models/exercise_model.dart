// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExerciseModel {
  String bodyPart;
  String equipment;
  String gifUrl;
  String id;
  String name;
  String target;
  double metValue;

  ExerciseModel({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
    required this.metValue,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bodyPart': bodyPart,
      'equipment': equipment,
      'gifUrl': gifUrl,
      'id': id,
      'name': name,
      'target': target,
      'metValue': metValue,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      bodyPart: map['bodyPart'] as String,
      equipment: map['equipment'] as String,
      gifUrl: map['gifUrl'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      target: map['target'] as String,
      metValue: map['metValue'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) => ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExerciseModel(bodyPart: $bodyPart, equipment: $equipment, gifUrl: $gifUrl, id: $id, name: $name, target: $target, metValue: $metValue)';
  }

  @override
  bool operator ==(covariant ExerciseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.bodyPart == bodyPart &&
      other.equipment == equipment &&
      other.gifUrl == gifUrl &&
      other.id == id &&
      other.name == name &&
      other.target == target &&
      other.metValue == metValue;
  }

  @override
  int get hashCode {
    return bodyPart.hashCode ^
      equipment.hashCode ^
      gifUrl.hashCode ^
      id.hashCode ^
      name.hashCode ^
      target.hashCode ^
      metValue.hashCode;
  }

  ExerciseModel copyWith({
    String? bodyPart,
    String? equipment,
    String? gifUrl,
    String? id,
    String? name,
    String? target,
    double? metValue,
  }) {
    return ExerciseModel(
      bodyPart: bodyPart ?? this.bodyPart,
      equipment: equipment ?? this.equipment,
      gifUrl: gifUrl ?? this.gifUrl,
      id: id ?? this.id,
      name: name ?? this.name,
      target: target ?? this.target,
      metValue: metValue ?? this.metValue,
    );
  }
}
