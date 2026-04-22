class ApiUrl {
  //static const baseUrl = "http://103.174.189.197:7000"; //This is Local url
  // static const baseUrl = "http://94.130.57.216:80"; //This is Live url
  static const baseUrl =
      "https://marcusapi.sistemasolutions.com"; //This is Live url

  ///<======================= For Auth part ====================>
  static const login = "/api/login";
  static const register = "/api/register";
  static const forgetPass = "/api/forget-pass";
  static const emailVarify = "/api/email-verified";
  static const resetPass = "/api/reset-pass";
  static const resendOTP = "/api/resend-otp";

  ///<=========================== Profile =========================>

  static const getProfile = "/api/profile";
  static const updateProfile = "/api/update-profile";

  ///<============================ Company ========================>
  static getCompanies({required String search}) =>
      "/api/show-company?name=$search";
  static const joinCompany = "/api/join-company";
  static const joinedCompanyList = "/api/show-joined-company";
  static const allCompanies = "/api/company/all-companies";

  ///<============================ Project =========================>

  static getProject({required String companyId}) =>
      "/api/company-wise-projects?company_id=$companyId";
  static const getAllProjects = "/api/projects";
  static getCompanyProjects({required String companyId}) =>
      "/api/company/projects/$companyId";

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
      "/api/employee-question-based-report?question_id=$queID&survey_id=$surveyID$query";

  ///<============================ History ===========================>

  static const submittedProject = "/api/my-survey";
  static submittedSurvey({required String projectID}) =>
      "/api/project-based-survey?project_id=$projectID&auth_user=1";

  ///<============================ Content ===========================>
  static const privacy = "/api/privacy-policy";

  static const terms = "/api/terms-condition";

  ///<============================ Notification ===========================>
  static const notification = "/api/notifications";
  static const readNotification = "/api/mark-as-read";

  ///<============================ Delete Account ===========================>
  static const deleteEmployee = "/api/delete-employee";

  ///<============================ Project Issues ===========================>
  static const createProjectIssue = "/api/project-issues";
  static getProjectIssuesByProject({required String projectId}) =>
      "/api/project-issues/by-project/$projectId";
  static updateProjectIssue({required String issueId}) =>
      "/api/project-issues/$issueId";
  static getProjectIssuesWithConfigurations({required String projectId}) =>
      "/api/project-issues/with-configurations/$projectId";
  static getProjectIssuesWithConfigurationsAndFilters({
    required String projectId,
    Map<String, String>? queryParams,
  }) {
    String url = "/api/project-issues/with-configurations/$projectId";
    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .where((e) => e.value.isNotEmpty)
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
      if (queryString.isNotEmpty) {
        url += '?$queryString';
      }
    }
    return url;
  }

  static uploadProjectIssueImages({required String issueId}) =>
      "/api/project-issues/$issueId/images";
  static getProjectIssueImages({required String issueId}) =>
      "/api/project-issues/$issueId/images";
}
