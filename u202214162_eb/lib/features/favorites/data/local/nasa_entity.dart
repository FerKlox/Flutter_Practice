class NasaEntity {
  final int id;
  final int sol;
  final String camera;
  final String imgSrc;
  final String? earthDate;
  final String rover;

  NasaEntity({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
    required this.rover,
  });

  factory NasaEntity.fromJson(Map<String, dynamic> json) {
    return NasaEntity(
      id: json['id'] ?? 0,
      sol: json['sol'] ?? 0,
      camera: json['camera'] ?? '',
      imgSrc: json['img_src'] ?? '',
      earthDate: json['earth_date'],
      rover: json['rover'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sol': sol,
      'camera': camera,
      'img_src': imgSrc,
      'earth_date': earthDate,
      'rover': rover,
    };
  }
}