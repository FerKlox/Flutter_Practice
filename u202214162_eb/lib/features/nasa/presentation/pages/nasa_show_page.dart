import 'package:flutter/material.dart';
import 'package:u202214162_eb/features/nasa/data/remote/nasa_service.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';
import 'package:u202214162_eb/features/nasa/presentation/widgets/nasa_card_widget.dart';
import 'package:u202214162_eb/features/favorites/data/local/nasa_dao.dart';

class NasaShowPage extends StatefulWidget {
  @override
  State<NasaShowPage> createState() => _NasaShowPageState();
}

class _NasaShowPageState extends State<NasaShowPage> {
  late Future<List<Nasa>> _futureNasaPhotos;
  late Future<List<int>> _favoriteIds;

  @override
  void initState() {
    super.initState();
    _futureNasaPhotos = NasaService().fetchNasaPhotos().then((resource) => resource.data ?? []);
    _favoriteIds = _fetchFavoriteIds();
  }

  Future<List<int>> _fetchFavoriteIds() async {
    final dao = NasaDao();
    final favorites = await dao.getFavorites();
    return favorites.map((e) => e.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nasa Photos'),
      ),
      body: FutureBuilder<List<Nasa>>(
        future: _futureNasaPhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return FutureBuilder<List<int>>(
              future: _favoriteIds,
              builder: (context, favoriteSnapshot) {
                if (favoriteSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (favoriteSnapshot.hasError) {
                  return Center(child: Text('Error: ${favoriteSnapshot.error}'));
                } else {
                  final favoriteIds = favoriteSnapshot.data ?? [];
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final nasa = snapshot.data![index];
                      final isFavorite = favoriteIds.contains(nasa.id);
                      return NasaCardWidget(nasa: nasa, isFavorite: isFavorite);
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}