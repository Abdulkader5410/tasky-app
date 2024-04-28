class UserModel {
  // final FullName fullName;
  final String email;
  final String password;
  final String username;
  final Address address;

  UserModel(
      {
        // required this.fullName,
      required this.email,
      required this.password,
      required this.username,
      required this.address});

  factory UserModel.fromjson(Map<String, dynamic> jsonUser) {
    return UserModel(
        // fullName: jsonUser['name'],
        email: jsonUser['email'],
        password: jsonUser['password'],
        username: jsonUser['username'],
        address: Address.fromjson(jsonUser['address']) );
  }
}

class Address {
  Geo geo;
  String city;

  Address({required this.geo, required this.city});

  factory Address.fromjson(Map<String, dynamic> jsonAddress) {
    return Address(geo: Geo.fromjson(jsonAddress['geolocation']), city: jsonAddress['city']);
  }
}

class Geo {
  String lat;
  String long;

  Geo({required this.lat, required this.long});
  factory Geo.fromjson(Map<String, dynamic> jsonGeo) {
    return Geo(lat: jsonGeo['lat'], long: jsonGeo['long']);
  }
}

// class FullName {
//   String firstName;
//   String lastName;

//   FullName({required this.firstName, required this.lastName});
//   factory FullName.fromjson(Map<String, dynamic> jsonFullName) {
//     return FullName(
//         firstName: jsonFullName['fitsrname'],
//         lastName: jsonFullName['lastname']);
//   }
// }

// {
//   "address": {
//     "geolocation": {
//       "lat": "40.3467",
//       "long": "-30.1310"
//     },
//     "city": "Cullman",
//     "street": "Frances Ct",
//     "number": 86,
//     "zipcode": "29567-1452"
//   },
//   "id": 3,
//   "email": "kevin@gmail.com",
//   "username": "kevinryan",
//   "password": "kev02937@",
//   "name": {
//     "firstname": "kevin",
//     "lastname": "ryan"
//   },
//   "phone": "1-567-094-1345",
//   "__v": 0
// }