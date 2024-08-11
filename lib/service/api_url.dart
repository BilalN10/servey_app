class ApiUrl {
  static const baseUrl = "http://192.168.10.232:6000"; //This is Local url
  // static const baseUrl = "http://94.130.57.216:80"; //This is Live url

  ///<======================= For Auth part ====================>
  static const login = "/api/login";
  static const register = "/api/register";
  static const forgetPass = "/api/forget-pass";
  static const emailVarify = "/api/email-verified";
  static const resetPass = "/api/reset-pass";

  ///<=========================== Profile =========================>

  static const getProfile = "/api/profile";
  static const updateProfile = "/api/update-profile";

  ///<============================ Company ========================>
  static getCompanies({required String search}) =>
      "/api/show-company?name=$search";
  static const joinCompany = "/api/join-company";
  static const joinedCompanyList = "/api/show-joined-company";

  ///<============================ Project =========================>

  static getProject({required String companyId}) =>
      "/api/company-wise-projects?company_id=$companyId";

  ///<============================ Survey =========================>
  static getSurvey({required String projectId}) =>
      "/api/project-based-survey?project_id=$projectId";

  static surveyQue({required String surveyId}) =>
      "/api/show-questions?survey_id=$surveyId";

  ///<============================ Ans Que =========================>
  static const submitAns = "/api/answer-question";

  ///<============================ Show Result =========================>
  static showResult({required String surveyId}) =>
      "/api/show-answer-report?survey_id=$surveyId";

  static queSurvey(
          {required String queID,
          required String surveyID,
          required String query}) =>
      "/api/employee-question-based-report?question_id=$queID&survey_id=$surveyID&date_range=$query";

  ///<============================ Privacy ===========================>
  static const privacy = "/api/privacy-policy";

  ///<============================ Terms ===========================>
  static const terms = "/api/terms-condition";
}
