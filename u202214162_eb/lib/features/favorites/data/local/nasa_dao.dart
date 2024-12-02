import 'package:sqflite/sqflite.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';
import 'package:u202214162_eb/shared/data/app_database.dart';
import 'nasa_entity.dart';


class NasaDao {
  final String tableName = 'favorites';

  Future<Database> get _db async => await AppDatabase().openDb();

  Future<void> addFavorite(Nasa nasa) async {
    final nasaEntity = NasaEntity(
      id: nasa.id,
      sol: nasa.sol,
      camera: nasa.camera?.fullName ?? '',
      imgSrc: nasa.imgSrc,
      earthDate: nasa.earthDate?.toIso8601String() ?? '',
      rover: nasa.rover?.name ?? '',
    );

    final db = await _db;
    await db.insert(
      tableName,
      nasaEntity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NasaEntity>> getFavorites() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return NasaEntity.fromJson(maps[i]);
    });
  }

  Future<int> deleteFavorite(int id) async {
    final db = await _db;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}