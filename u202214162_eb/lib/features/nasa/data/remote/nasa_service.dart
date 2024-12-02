import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:u202214162_eb/core/app_constants.dart';
import 'package:u202214162_eb/core/resource.dart';
import 'package:u202214162_eb/features/nasa/data/remote/nasa_dto.dart';
import 'package:u202214162_eb/features/nasa/domain/nasa.dart';


class NasaService {
  Future<Resource<List<Nasa>>> fetchNasaPhotos() async {
    String url = '${AppConstants.baseUrl}${AppConstants.apiKeyQuery}';

    try {
      print('Fetching photos from: $url'); 
      http.Response response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}'); 
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> json = jsonDecode(response.body)['photos'];
        print('Response JSON: $json'); 
        if (json.isNotEmpty) {
          List<Nasa> photos = json.map((e) => NasaDto.fromJson(e).toNasa()).toList();
          return Success(photos);
        } else {
          return Error('No photos found');
        }
      }
      return Error('Error: ${response.statusCode}');
    } catch (error) {
      print('Exception: $error'); 
      return Error(error.toString());
    }
  }
}