class AppConstants {
  static const String API_KEY = 'bVeGRmj9NT3ytr320DhKS4FI1QR2sWIB2JbMylFW';

  static const String baseUrl = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/';
  static const String apiKeyQuery = 'photos/?sol=1000&api_key=$API_KEY';

  static const String STUDENT_NAME = 'Christian Matos';
  static const String STUDENT_CODE = 'u202214162';
  static const String STUDENT_PHOTO_URL = 'https://intranet.upc.edu.pe/programas/Imagen/Fotos/Upc/0540202214162.jpg';

  static String getApiName(String studentCode) {
    int lastDigit = int.parse(studentCode[studentCode.length - 1]);
    return lastDigit % 2 == 0 ? 'Mars Rover Photos' : 'APOD';
  }
}