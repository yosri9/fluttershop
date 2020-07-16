class UnProcessedEntity implements Exception{

}

class LoginFailed implements Exception{

  @override
  String toString() {
    return 'credentials rejected';
  }
}
class RedirectionFound implements Exception{


  @override
  String toString() {
    return 'Too many redirection.';
  }
}
class ResourceNotFound implements Exception{

  String message;


  ResourceNotFound(this.message);

  @override
  String toString() {
    return "Resource ${this.message} Not Found";
  }
}
class NoInternetConnection implements Exception{

  @override
  String toString() {
    return 'No Internet Connection available';
  }
}

class PropertyRequired implements Exception{
  String field;

  PropertyRequired(this.field);

  @override
  String toString() {
    return 'Property${this.field} is requred';
  }
}