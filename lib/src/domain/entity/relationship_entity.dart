
import 'package:gia_pha_so/src/domain/enum/entity_enum.dart';

class Relationship {
  final String id;
  final String person1Id;
  final String person2Id;
  final EnumRelationship enumRelationship;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? notes;
  final DateTime createdAt;

  Relationship({
    required this.id,
    required this.person1Id,
    required this.person2Id,
    required this.enumRelationship,
    this.startDate,
    this.endDate,
    this.notes,
    required this.createdAt,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
    id: json['id'],
    person1Id: json['person1Id'],
    person2Id: json['person2Id'],
    enumRelationship: EnumRelationship.values.firstWhere(
      (e) => e.toString().split('.').last == json['enumRelationship'],
      orElse: () => EnumRelationship.other,
    ),
    startDate: json['startDate'] != null
        ? DateTime.parse(json['startDate'])
        : null,
    endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    notes: json['notes'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'person1Id': person1Id,
    'person2Id': person2Id,
    'enumRelationship': enumRelationship.toString().split('.').last,
    'startDate': startDate?.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'notes': notes,
    'createdAt': createdAt.toIso8601String(),
  };
}
