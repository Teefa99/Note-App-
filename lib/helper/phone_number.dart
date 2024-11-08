class PhoneNumber {
  static String handle({required String phoneNumber}){
    if(phoneNumber.startsWith("0")){
      return phoneNumber.substring(1);
    } else {
      return phoneNumber;
    }
  }
}