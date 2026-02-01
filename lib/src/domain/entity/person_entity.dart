import 'package:gia_pha_so/src/domain/enum/entity_enum.dart';

class PersonEntity {
  final String id;
  final String fullName;
  final String? displayName;
  final bool isAlive;
  final EnumGender gender;

  /// Danh sách con
  final List<PersonEntity> children;

  /// Danh sách vợ/chồng
  final List<PersonEntity> spouses;

  /// Cha
  final List<PersonEntity>? fathers;

  /// Mẹ
  final List<PersonEntity>? mothers;

  /// Anh, chị, em
  final List<PersonEntity> siblings;
  final DateTime? dateOfBirth;
  final DateTime? dateOfDeath;
  final String? birthPlace;
  final String? deathPlace;
  final String? biography;
  final String? avatarUrl;
  final String? notes;
  final String? familyId;
  final int? generationNumber;
  final int? birthOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> spouseIds; // IDs của các vợ/chồng
  final String? fatherId; // ID của cha
  final String? motherId; // ID của mẹ
  final List<String> siblingIds; // IDs của anh chị em

  PersonEntity({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.isAlive,
    this.displayName,
    this.dateOfBirth,
    this.dateOfDeath,
    this.birthPlace,
    this.deathPlace,
    this.biography,
    this.avatarUrl,
    this.notes,
    this.familyId,
    this.generationNumber,
    this.birthOrder,
    this.createdAt,
    this.updatedAt,
    this.children = const [], // Khởi tạo mặc định
    this.spouses = const [],
    this.fathers,
    this.mothers,
    this.siblings = const [],
    this.spouseIds = const [],
    this.fatherId,
    this.motherId,
    this.siblingIds = const [],
  });

  factory PersonEntity.fromJson(Map<String, dynamic> json) => PersonEntity(
    id: json['id'],
    fullName: json['fullName'],
    displayName: json['displayName'],
    gender: EnumGender.values.firstWhere(
      (e) => e.toString().split('.').last == json['gender'],
      orElse: () => EnumGender.male,
    ),
    dateOfBirth: json['dateOfBirth'] != null
        ? DateTime.parse(json['dateOfBirth'])
        : null,
    dateOfDeath: json['dateOfDeath'] != null
        ? DateTime.parse(json['dateOfDeath'])
        : null,
    birthPlace: json['birthPlace'],
    deathPlace: json['deathPlace'],
    biography: json['biography'],
    avatarUrl: json['avatarUrl'],
    isAlive: json['isAlive'] ?? true,
    notes: json['notes'],
    familyId: json['familyId'],
    generationNumber: json['generationNumber'],
    birthOrder: json['birthOrder'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    spouseIds: List<String>.from(json['spouseIds'] ?? []),
    fatherId: json['fatherId'],
    motherId: json['motherId'],
    siblingIds: List<String>.from(json['siblingIds'] ?? []),
    // Note: children, spouses, father, mother, siblings
    // sẽ được populate sau từ các IDs
    children: [],
    spouses: [],
    fathers: [],
    mothers: [],
    siblings: [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'displayName': displayName,
    'gender': gender.toString().split('.').last,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'dateOfDeath': dateOfDeath?.toIso8601String(),
    'birthPlace': birthPlace,
    'deathPlace': deathPlace,
    'biography': biography,
    'avatarUrl': avatarUrl,
    'isAlive': isAlive,
    'notes': notes,
    'familyId': familyId,
    'generationNumber': generationNumber,
    'birthOrder': birthOrder,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'spouseIds': spouseIds,
    'fatherId': fatherId,
    'motherId': motherId,
    'siblingIds': siblingIds,
    // Không lưu trực tiếp các đối tượng con, chỉ lưu IDs
  };

  PersonEntity copyWith({
    String? id,
    String? fullName,
    String? displayName,
    EnumGender? gender,
    List<PersonEntity>? children,
    List<PersonEntity>? spouses,
    List<PersonEntity>? fathers,
    List<PersonEntity>? mothers,
    List<PersonEntity>? siblings,
    DateTime? dateOfBirth,
    DateTime? dateOfDeath,
    String? birthPlace,
    String? deathPlace,
    String? biography,
    String? avatarUrl,
    bool? isAlive,
    String? notes,
    String? familyId,
    int? generationNumber,
    int? birthOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? spouseIds,
    String? fatherId,
    String? motherId,
    List<String>? siblingIds,
  }) {
    return PersonEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      children: children ?? this.children,
      spouses: spouses ?? this.spouses,
      fathers: fathers ?? this.fathers,
      mothers: mothers ?? this.mothers,
      siblings: siblings ?? this.siblings,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfDeath: dateOfDeath ?? this.dateOfDeath,
      birthPlace: birthPlace ?? this.birthPlace,
      deathPlace: deathPlace ?? this.deathPlace,
      biography: biography ?? this.biography,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isAlive: isAlive ?? this.isAlive,
      notes: notes ?? this.notes,
      familyId: familyId ?? this.familyId,
      generationNumber: generationNumber ?? this.generationNumber,
      birthOrder: birthOrder ?? this.birthOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      spouseIds: spouseIds ?? this.spouseIds,
      fatherId: fatherId ?? this.fatherId,
      motherId: motherId ?? this.motherId,
      siblingIds: siblingIds ?? this.siblingIds,
    );
  }

  // Phương thức tiện ích
  int? get age {
    if (!isAlive && dateOfDeath != null && dateOfBirth != null) {
      return dateOfDeath!.difference(dateOfBirth!).inDays ~/ 365;
    }
    if (dateOfBirth != null) {
      return DateTime.now().difference(dateOfBirth!).inDays ~/ 365;
    }
    return null;
  }

  // Kiểm tra xem có vợ/chồng không
  bool get hasSpouse => spouses.isNotEmpty || spouseIds.isNotEmpty;

  // Lấy danh sách tất cả vợ/chồng (hiện tại và quá khứ)
  List<PersonEntity> getAllSpouses() => spouses;

  // Lấy vợ/chồng chính (ví dụ: vợ/chồng hiện tại nếu còn sống)
  PersonEntity? getPrimarySpouse() {
    if (spouses.isEmpty) return null;

    // Ưu tiên vợ/chồng còn sống
    final livingSpouses = spouses.where((s) => s.isAlive).toList();
    if (livingSpouses.isNotEmpty) return livingSpouses.first;

    return spouses.first;
  }

  // Thêm vợ/chồng
  PersonEntity addSpouse(PersonEntity spouse) {
    return copyWith(
      spouses: [...spouses, spouse],
      spouseIds: [...spouseIds, spouse.id],
    );
  }

  // Thêm con
  PersonEntity addChild(PersonEntity child) {
    return copyWith(children: [...children, child]);
  }

  // Xác định vai trò trong gia đình
  String get familyRole {
    if (fathers != null && mothers != null) {
      return 'Con';
    } else if (children.isNotEmpty) {
      return gender == EnumGender.male ? 'Cha' : 'Mẹ';
    } else if (hasSpouse) {
      return gender == EnumGender.male ? 'Chồng' : 'Vợ';
    }
    return 'Thành viên';
  }

  // Lấy thông tin gia đình ngắn gọn
  String get familyInfo {
    final info = StringBuffer();
    info.write(fullName);

    if (age != null) {
      info.write(' ($age tuổi)');
    }

    if (hasSpouse) {
      final spouseNames = spouses.map((s) => s.fullName).join(', ');
      info.write(
        ' - ${gender == EnumGender.male ? 'Chồng của' : 'Vợ của'} $spouseNames',
      );
    }

    if (children.isNotEmpty) {
      info.write(' - Có ${children.length} con');
    }

    return info.toString();
  }

  // Phương thức để populate các quan hệ từ IDs
  PersonEntity populateRelationships({
    required Map<String, PersonEntity> personMap,
  }) {
    return copyWith(
      spouses: spouseIds
          .where((id) => personMap.containsKey(id))
          .map((id) => personMap[id]!)
          .toList(),
      fathers: personMap.values
          .where((person) => person.fatherId == id)
          .toList(),
      mothers: personMap.values
          .where((person) => person.motherId == id)
          .toList(),
      siblings: siblingIds
          .where((id) => personMap.containsKey(id))
          .map((id) => personMap[id]!)
          .toList(),
      children: personMap.values
          .where((person) => person.fatherId == id || person.motherId == id)
          .toList(),
    );
  }
}
