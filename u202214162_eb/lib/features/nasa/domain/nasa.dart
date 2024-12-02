class Nasa {
    Nasa({
        required this.id,
        required this.sol,
        required this.camera,
        required this.imgSrc,
        required this.earthDate,
        required this.rover,
    });

    final int id;
    final int sol;
    final NasaCamera? camera;
    final String imgSrc; 
    final DateTime? earthDate;
    final Rover? rover;

    factory Nasa.fromJson(Map<String, dynamic> json) { 
        return Nasa(
            id: json["id"] ?? 0,
            sol: json["sol"] ?? 0,
            camera: json["camera"] == null ? null : NasaCamera.fromJson(json["camera"]),
            imgSrc: json["img_src"] ?? "",
            earthDate: DateTime.tryParse(json["earth_date"] ?? ""),
            rover: json["rover"] == null ? null : Rover.fromJson(json["rover"]),
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "id": id,
            "sol": sol,
            "camera": camera?.toJson(),
            "img_src": imgSrc,
            "earth_date": earthDate?.toIso8601String(),
            "rover": rover?.toJson(),
        };
    }
}

class NasaCamera {
    NasaCamera({
        required this.id,
        required this.name,
        required this.roverId,
        required this.fullName,
    });

    final int id;
    final String name;
    final int roverId;
    final String fullName;

    factory NasaCamera.fromJson(Map<String, dynamic> json) { 
        return NasaCamera(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            roverId: json["rover_id"] ?? 0,
            fullName: json["full_name"] ?? "",
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "id": id,
            "name": name,
            "rover_id": roverId,
            "full_name": fullName,
        };
    }
}

class Rover {
    Rover({
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

    final int id;
    final String name;
    final DateTime? landingDate;
    final DateTime? launchDate;
    final String status;
    final int maxSol;
    final DateTime? maxDate;
    final int totalPhotos;
    final List<CameraElement> cameras;

    factory Rover.fromJson(Map<String, dynamic> json) { 
        return Rover(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            landingDate: DateTime.tryParse(json["landing_date"] ?? ""),
            launchDate: DateTime.tryParse(json["launch_date"] ?? ""),
            status: json["status"] ?? "",
            maxSol: json["max_sol"] ?? 0,
            maxDate: DateTime.tryParse(json["max_date"] ?? ""),
            totalPhotos: json["total_photos"] ?? 0,
            cameras: json["cameras"] == null ? [] : List<CameraElement>.from(json["cameras"]!.map((x) => CameraElement.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "id": id,
            "name": name,
            "landing_date": landingDate?.toIso8601String(),
            "launch_date": launchDate?.toIso8601String(),
            "status": status,
            "max_sol": maxSol,
            "max_date": maxDate?.toIso8601String(),
            "total_photos": totalPhotos,
            "cameras": cameras.map((x) => x.toJson()).toList(),
        };
    }
}

class CameraElement {
    CameraElement({
        required this.name,
        required this.fullName,
    });

    final String name;
    final String fullName;

    factory CameraElement.fromJson(Map<String, dynamic> json) { 
        return CameraElement(
            name: json["name"] ?? "",
            fullName: json["full_name"] ?? "",
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "name": name,
            "full_name": fullName,
        };
    }
}