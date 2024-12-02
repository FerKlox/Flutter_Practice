import 'package:flutter/material.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';

class NasaDetailPage extends StatefulWidget {
  final Nasa nasa;

  const NasaDetailPage({Key? key, required this.nasa}) : super(key: key);

  @override
  State<NasaDetailPage> createState() => _NasaDetailPageState();
}

class _NasaDetailPageState extends State<NasaDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nasa Photo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(widget.nasa.imgSrc),
            ),
            SizedBox(height: 20),
            Text(
              'Camera: ${widget.nasa.camera?.fullName ?? 'N/A'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Earth Date: ${widget.nasa.earthDate?.toIso8601String() ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Rover: ${widget.nasa.rover?.name ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Rover Status: ${widget.nasa.rover?.status ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Total Photos Taken: ${widget.nasa.rover?.totalPhotos ?? 0}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}