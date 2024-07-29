class ApiUrl {
  static const baseUrl = "http://192.168.10.64:6000"; //This is Local url

  ///<======================= For Auth part ====================>
  static const login = "/api/login";
  static const register = "/api/register";
  static const forgetPass = "/api/forget-pass";
  static const emailVarify = "/api/email-verified";
  static const resetPass = "/api/reset-pass";

  ///<=========================== Profile =========================>

  static const getProfile = "/api/profile";
  static const updateProfile = "/api/update-profile";

  ///<============================ Company ======================>
  static const getCompanies = "/api/show-company";
  static const joinCompany = "/api/join-company";
}
