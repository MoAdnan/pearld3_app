

class ApiConstantsT {
  ApiConstantsT();
  static const base_url = 'https://indeesapp.azurewebsites.net/api/pearl';
 static const languageBaseUrl = "https://indeesapp.azurewebsites.net/api/language";
  static const base_test_url = 'http://192.168.0.100:8000/api';
  static const testHeader = {'Authorization': 'application/json'};

  Map<String, dynamic> credential(
      {required username,
      required password,
      required String? deviceID,
      required String? deviceModel,
     required double lat,required double long}) {
    return {
      "username": username,
      "password": password,
      "dateOfJoining": "2021-04-11T02:59:12.548Z",
      "uuid": deviceID,
      "modelNumber": deviceModel,
      "activationKey": "string",
      "lng": lat,
      "lat": long
    };
  }


  Map<String, dynamic> cedentalWithUserNamePassord(String username,String password){
    return{
      "username": username,
      "password": password,
      "dateOfJoining": "2021-04-11T02:59:12.548Z",
      "uuid": "986df7cfc4c5bafe",
      "modelNumber": "galaxy",
      "activationKey": "string",
      "lng": 0,
      "lat": 0
    };
  }

  static const Map<String, dynamic> testCredental = {
    "username": "admin",
    "password": "1234",
    "dateOfJoining": "2021-04-11T02:59:12.548Z",
    "uuid": "51a01f4fe1c4a1b7",
    "modelNumber": "galaxy",
    "activationKey": "string",
    "lng": 0,
    "lat": 0
  };
}
