class SavedCredential {
  final String username;
  final String password;

  const SavedCredential({
    required this.username,
    required this.password,
  });

  @override
  String toString() {
    return 'SavedCredential{username: $username, password: $password}';
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory SavedCredential.fromMap(Map<String, dynamic> map) {
    return SavedCredential(
      username: map['username'],
      password: map['password'],
    );
  }
}
