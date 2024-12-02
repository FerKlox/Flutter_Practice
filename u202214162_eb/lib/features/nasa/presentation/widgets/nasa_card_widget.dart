import 'package:flutter/material.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';
import 'package:u202214162_eb/features/nasa/presentation/pages/nasa_detail_page.dart';
import 'package:u202214162_eb/features/favorites/data/local/nasa_dao.dart';

class NasaCardWidget extends StatefulWidget {
  final Nasa nasa;
  final bool isFavorite;

  const NasaCardWidget({Key? key, required this.nasa, this.isFavorite = false}) : super(key: key);

  @override
  State<NasaCardWidget> createState() => _NasaCardWidgetState();
}

class _NasaCardWidgetState extends State<NasaCardWidget> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() async {
    final dao = NasaDao();
    if (_isFavorite) {
      await dao.deleteFavorite(widget.nasa.id);
    } else {
      await dao.addFavorite(widget.nasa);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NasaDetailPage(nasa: widget.nasa),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.nasa.imgSrc),
              SizedBox(height: 10),
              Text(
                'Camera: ${widget.nasa.camera?.fullName ?? 'N/A'}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'Earth Date: ${widget.nasa.earthDate?.toIso8601String() ?? 'N/A'}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                'Rover: ${widget.nasa.rover?.name ?? 'N/A'}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : null,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}