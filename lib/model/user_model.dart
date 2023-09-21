class User {
  late String _name;
  late String _username;
  late String _password;
  bool _flaglogged = false;
  User(this._name, this._username, this._password, this._flaglogged);

  User.map(dynamic obj) {
    _name = obj['name'];
    _username = obj['username'];
    _password = obj['password'];
    // Assuming 'flaglogged' is a boolean field in the object
    _flaglogged = obj['password'] ??
        false; // Assign a default value if 'flaglogged' is missing in the object
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;
  bool get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;
    map["flaglogged"] = _flaglogged;
    return map;
  }
}
