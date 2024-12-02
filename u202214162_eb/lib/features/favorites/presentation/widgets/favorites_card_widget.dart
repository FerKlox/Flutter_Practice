import 'package:flutter/material.dart';
import 'package:u202214162_eb/features/favorites/data/local/nasa_dao.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';

class FavoritesCardWidget extends StatefulWidget {
  final Nasa nasa;
  final VoidCallback onFavoriteRemoved;

  const FavoritesCardWidget({Key? key, required this.nasa, required this.onFavoriteRemoved}) : super(key: key);

  @override
  State<FavoritesCardWidget> createState() => _FavoritesCardWidgetState();
}

class _FavoritesCardWidgetState extends State<FavoritesCardWidget> {
  void _removeFavorite() async {
    final dao = NasaDao();
    await dao.deleteFavorite(widget.nasa.id);
    widget.onFavoriteRemoved();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.nasa.imgSrc,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Camera: ${widget.nasa.camera?.fullName ?? 'N/A'}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Earth Date: ${widget.nasa.earthDate?.toIso8601String() ?? 'N/A'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Rover: ${widget.nasa.rover?.name ?? 'N/A'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: _removeFavorite,
            ),
          ],
        ),
      ),
    );
  }
}