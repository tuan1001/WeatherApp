enum Method { get, post, delete, put }

enum ContentType { multipartForm, applicationJson }

extension ParseString on ContentType {
  String string() {
    switch (this) {
      case ContentType.applicationJson:
        return "application/json";
      case ContentType.multipartForm:
        return "multipart/form-data";
      default:
        return "";
    }
  }
}
