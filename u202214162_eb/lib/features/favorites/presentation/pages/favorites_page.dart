import 'package:flutter/material.dart';
import 'package:u202214162_eb/features/favorites/data/local/nasa_dao.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';
import 'package:u202214162_eb/features/favorites/presentation/widgets/favorites_card_widget.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}
  

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Nasa>> _futureFavorites;

  @override
  void initState() {
    super.initState();
    _futureFavorites = _fetchFavorites();
  }

  Future<List<Nasa>> _fetchFavorites() async {
    final dao = NasaDao();
    final entities = await dao.getFavorites();
    return entities.map((entity) => Nasa(
      id: entity.id,
      sol: entity.sol,
      camera: NasaCamera(
        id: 0,
        name: '',
        roverId: 0,
        fullName: entity.camera,
      ),
      imgSrc: entity.imgSrc,
      earthDate: DateTime.tryParse(entity.earthDate ?? ''),
      rover: Rover(
        id: 0,
        name: entity.rover,
        landingDate: null,
        launchDate: null,
        status: '',
        maxSol: 0,
        maxDate: null,
        totalPhotos: 0,
        cameras: [],
      ),
    )).toList();
  }

  void _refreshFavorites() {
    setState(() {
      _futureFavorites = _fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<Nasa>>(
        future: _futureFavorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return FavoritesCardWidget(
                  nasa: snapshot.data![index],
                  onFavoriteRemoved: _refreshFavorites,
                );
              },
            );
          }
        },
      ),
    );
  }
}