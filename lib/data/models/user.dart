class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? profileImage;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'profileImage': profileImage,
    };
  }
}
