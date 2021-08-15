class User {
  late String userId;
  late String identifier;
  late String identifierType;
  late String verificationToken;

  User(
      {required this.userId,
        required this.identifier,
        required this.identifierType,
        required this.verificationToken});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    identifier = json['identifier'];
    identifierType = json['identifier_type'];
    verificationToken = json['verification_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['identifier'] = this.identifier;
    data['identifier_type'] = this.identifierType;
    data['verification_token'] = this.verificationToken;
    return data;
  }
}