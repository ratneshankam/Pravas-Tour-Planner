class SingleChildModalUsersData {
  int? id;
  String name;
  String phone;
  String username;
  String password;

  SingleChildModalUsersData({
    required this.name,
    required this.phone,
    required this.username,
    required this.password,
    this.id,
  });
  Map<String, dynamic> getUserMap() {
    return {
      "name": name,
      "phone": phone,
      "username": username,
      "password": password,
    };
  }
}
