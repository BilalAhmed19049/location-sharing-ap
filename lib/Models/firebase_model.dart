class FirebaseModel {
  late String firstname, lastname, email, password, id;

  FirebaseModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  FirebaseModel.fromMap(Map<String, dynamic> locationData) {
    firstname = locationData['firstname'];
    lastname = locationData['lastname'];
    email = locationData['email'];
    password = locationData['password'];
    id = locationData['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'id': id,
    };
  }
}
