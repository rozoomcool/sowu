class FormValidator {
  String? simpleValidate(String? val){
    if(val == null || val.isEmpty || val.length < 4) return 'The value must be longer';
    return null;
  }
}