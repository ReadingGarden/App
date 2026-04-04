class GardenMemberEntity {
  const GardenMemberEntity({
    required this.userNo,
    required this.userNick,
    required this.userImage,
    required this.gardenLeader,
  });

  final int userNo;
  final String userNick;
  final String userImage;
  final bool gardenLeader;

  factory GardenMemberEntity.fromMap(Map<String, dynamic> map) {
    return GardenMemberEntity(
      userNo: map['user_no'] as int? ?? 0,
      userNick: map['user_nick'] as String? ?? '',
      userImage: map['user_image'] as String? ?? '',
      gardenLeader: map['garden_leader'] as bool? ?? false,
    );
  }
}
