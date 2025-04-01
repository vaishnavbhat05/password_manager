class PasswordData {
  final int? id;
  final String websiteName;
  final String userId;
  final String websiteLink;
  final String password;

  PasswordData({this.id,required this.websiteName,required this.userId, required this.websiteLink, required this.password});
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'websiteName': websiteName,
      'userId': userId,
      'websiteLink': websiteLink,
      'password': password,
    };
  }

  factory PasswordData.fromMap(Map<String, dynamic>map){
    return PasswordData(
      id: map['id'],
      websiteName: map['websiteName'],
      userId: map['userId'],
      websiteLink: map['websiteLink'],
      password: map['password'],
    );
  }
}