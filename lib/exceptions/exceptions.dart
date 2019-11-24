class LoginFailed implements Exception{

  @override
  String toString() {
    return 'Credentials rejected';
  }
}
class RedirectionFound implements Exception{

  @override
  String toString() {
    return 'To many redirection';
  }
}
class ResourceNotFound implements Exception{

  String message ;


  ResourceNotFound(this.message);

  @override
  String toString() {
    return 'Resource${this.message} Not Found';
  }
}
class UnprocessedEntity implements Exception{

  @override
  String toString() {
    return 'Missing fields';
  }
}
class NoInternetConnection implements Exception {


  @override
  String toString() {
    return 'No internet connection available!!!!!';
  }
}
class PropertyIsRequired implements Exception{

  String property;

  PropertyIsRequired(this.property);

  @override
  String toString() {
    return 'this ${this.property} is required';
  }
}