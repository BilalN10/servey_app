class ApiConstant {
  //static const baseUrl="http://192.168.10.16:5001"; //This is local url
   static const baseUrl ="http://209.38.136.64:5000"; //This is live url
   //static const socketUrl="http://192.168.10.16:5001";
   static const socketUrl="http://209.38.136.64:5000";

///<=================================== For Auth part ====================>
  static const signIn = "/api/v1/auth/login";
  static const changePassWord = "/api/v1/auth/change-password";
  static const resetPassword = "/api/v1/auth/reset-password";
  static const forgotPassword = "/api/v1/auth/forget-password";
  static const verifyOTP = "/api/v1/auth/verify-otp";
  static const userProfile = "/api/v1/user/profile";
  static const getContact = "/api/v1/contact";

  ///<============================ For home ==============================>

  static const banner = "/api/v1/banner";
  static const offer = "/api/v1/offer";
  static const smartCheck = "/api/v1/smart-check";
  static const faq = "/api/v1/faq";
  static const package = "/api/v1/package";
  static const articleCategory = "/api/v1/article-category";
  static const article = "/api/v1/article";
  static const articleByCategory = "/api/v1/article/category/";
  static const singleArticle = "/api/v1/article/";
  static const editProfile = "/api/v1/patient/profile-update";

  ///<===================== For settings ==========================>
  static const termsCondition = "/api/v1/rule/terms-and-conditions";
  static const aboutUs = "/api/v1/rule/about";
  static const privacyPolicy = "/api/v1/rule/privacy-policy";

  ///<========================= For messaging ======================>
  static const creatChat="/api/v1/chat";
  static const getMessage="/api/v1/message/chatId/";
  static const sendMessage="/api/v1/message/send-message";

  ///<===================== This is for notification =================>

  static const getNotification="/api/v1/notifications";

  static const readNotification="/api/v1/notifications/read-notifications";

 }
