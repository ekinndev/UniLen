class FirebaseError {
  Error error;

  FirebaseError({this.error});

  FirebaseError.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
  static String hatayiCevir(String hata){
    switch (hata) {
      case 'USER_NOT_FOUND':
        return 'Kullanıcı bulunamadı.';
        break;
        case 'EMAIL_NOT_FOUND':
        return 'Email bulunamadı.';
        break;
        case 'INVALID_PASSWORD':
        return 'Şifre hatalı.';
        break;
        case 'EMAIL_EXISTS':
        return 'Bu email kullanılmaktadır.';
        break;
      default:
      return 'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.';
      
    }
  }
  
}

class Error {
  int code;
  String message;
  List<Errors> errors;

  Error({this.code, this.message, this.errors});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = new List<Errors>();
      json['errors'].forEach((v) {
        errors.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  String message;
  String domain;
  String reason;

  Errors({this.message, this.domain, this.reason});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    domain = json['domain'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['domain'] = this.domain;
    data['reason'] = this.reason;
    return data;
  }
}