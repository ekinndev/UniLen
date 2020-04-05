enum LogMethod{
  Google,
  Facebook,
  Standart
}
class User {
  final uid;
  final token;
  final photoUrl;
  final name;
  final email;
  final LogMethod logMethod;
  User({this.uid, this.email, this.name, this.photoUrl, this.token,this.logMethod});
}
