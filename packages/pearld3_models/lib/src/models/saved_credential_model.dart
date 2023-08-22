/// Represents saved login credentials.
class SavedCredential {
  /// The username associated with the credential.
  final String username;

  /// The password associated with the credential.
  final String password;

  /// Creates a [SavedCredential] instance.
  ///
  /// The [username] is the username associated with the credential.
  /// The [password] is the password associated with the credential.
  const SavedCredential({
    required this.username,
    required this.password,
  });

  /// Returns a string representation of the [SavedCredential] instance.
  @override
  String toString() {
    return 'SavedCredential{username: $username, password: $password}';
  }

  /// Converts the [SavedCredential] instance to a JSON map.
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  /// Creates a [SavedCredential] instance from a JSON map.
  factory SavedCredential.fromMap(Map<String, dynamic> map) {
    return SavedCredential(
      username: map['username'],
      password: map['password'],
    );
  }
}
