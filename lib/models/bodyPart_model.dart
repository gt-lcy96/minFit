// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BodyPartModel {
  String name;
  String gifUrl;
  BodyPartModel({
    required this.name,
    required this.gifUrl,
  });

  BodyPartModel copyWith({
    String? name,
    String? gifUrl,
  }) {
    return BodyPartModel(
      name: name ?? this.name,
      gifUrl: gifUrl ?? this.gifUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'gifUrl': gifUrl,
    };
  }

  factory BodyPartModel.fromMap(Map<String, dynamic> map) {
    return BodyPartModel(
      name: map['name'] as String,
      gifUrl: map['gifUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BodyPartModel.fromJson(String source) => BodyPartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BodyPartModel(name: $name, gifUrl: $gifUrl)';

  @override
  bool operator ==(covariant BodyPartModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.gifUrl == gifUrl;
  }

  @override
  int get hashCode => name.hashCode ^ gifUrl.hashCode;
}
