import 'package:u202214162_eb/features/nasa/domain/nasa.dart';

class NasaDto {
  final int id;
  final int sol;
  final String imgSrc;
  final DateTime? earthDate;
  final NasaCameraDto? camera;
  final RoverDto? rover;

  NasaDto({
    required this.id,
    required this.sol,
    required this.imgSrc,
    required this.earthDate,
    required this.camera,
    required this.rover,
  });

  factory NasaDto.fromJson(Map<String, dynamic> json) {
    return NasaDto(
      id: json['id'] ?? 0,
      sol: json['sol'] ?? 0,
      imgSrc: json['img_src'] ?? '',
      earthDate: DateTime.tryParse(json['earth_date'] ?? ''),
      camera: json['camera'] == null ? null : NasaCameraDto.fromJson(json['camera']),
      rover: json['rover'] == null ? null : RoverDto.fromJson(json['rover']),
    );
  }

  Nasa toNasa() {
    return Nasa(
      id: id,
      sol: sol,
      imgSrc: imgSrc,
      earthDate: earthDate,
      camera: camera?.toNasaCamera(),
      rover: rover?.toRover(),
    );
  }
}

class NasaCameraDto {
  final int id;
  final String name;
  final int roverId;
  final String fullName;

  NasaCameraDto({
    required this.id,
    required this.name,
    required this.roverId,
    required this.fullName,
  });

  factory NasaCameraDto.fromJson(Map<String, dynamic> json) {
    return NasaCameraDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      roverId: json['rover_id'] ?? 0,
      fullName: json['full_name'] ?? '',
    );
  }

  NasaCamera toNasaCamera() {
    return NasaCamera(
      id: id,
      name: name,
      roverId: roverId,
      fullName: fullName,
    );
  }
}

class RoverDto {
  final int id;
  final String name;
  final DateTime? landingDate;
  final DateTime? launchDate;
  final String status;
  final int maxSol;
  final DateTime? maxDate;
  final int totalPhotos;
  final List<CameraElementDto> cameras;

  RoverDto({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.cameras,
  });

  factory RoverDto.fromJson(Map<String, dynamic> json) {
    return RoverDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      landingDate: DateTime.tryParse(json['landing_date'] ?? ''),
      launchDate: DateTime.tryParse(json['launch_date'] ?? ''),
      status: json['status'] ?? '',
      maxSol: json['max_sol'] ?? 0,
      maxDate: DateTime.tryParse(json['max_date'] ?? ''),
      totalPhotos: json['total_photos'] ?? 0,
      cameras: json['cameras'] == null ? [] : List<CameraElementDto>.from(json['cameras']!.map((x) => CameraElementDto.fromJson(x))),
    );
  }

  Rover toRover() {
    return Rover(
      id: id,
      name: name,
      landingDate: landingDate,
      launchDate: launchDate,
      status: status,
      maxSol: maxSol,
      maxDate: maxDate,
      totalPhotos: totalPhotos,
      cameras: cameras.map((x) => x.toCameraElement()).toList(),
    );
  }
}

class CameraElementDto {
  final String name;
  final String fullName;

  CameraElementDto({
    required this.name,
    required this.fullName,
  });

  factory CameraElementDto.fromJson(Map<String, dynamic> json) {
    return CameraElementDto(
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
    );
  }

  CameraElement toCameraElement() {
    return CameraElement(
      name: name,
      fullName: fullName,
    );
  }
}