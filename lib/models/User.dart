class User {
  late String username;
  late String nama;
  late String password;
  late String nomor_telpon;
  User(
      {required this.username,
      required this.nama,
      required this.password,
      required this.nomor_telpon});
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'nama': nama,
      'password': password,
      'nomor_telpon': nomor_telpon,
    };
  }
  //     User.fromMap(Map<String, dynamic> item):
  //   id=item[NoteColumn.id],
  //   title = item[NoteColumn.title],
  //   description = item[NoteColumn.description];

  // Map<String, Object> toMap(){
  //   return {
  //     NoteColumn.id:id,
  //     NoteColumn.title: title,
  //     NoteColumn.description: description,
  //   };
  String toString() {
    return 'User{, username: $username, password: $password}';
  }

  void setUsername(username) {
    this.username = username;
  }

  String getUsername() {
    return username;
  }
}
