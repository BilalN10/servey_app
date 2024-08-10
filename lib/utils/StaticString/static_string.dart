class AppStaticStrings {
  //============================= OnBoarding ================================
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passRegexp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  static const matchPettern = "Password must have 8 and one capital latter";
  static const wellComeMarkus = "Welcome!      Markus";
  static const signUp = "Sign Up";
  static const signIn = "Sign In ";
  static const welcomeBack = "WellCome Back";
  static const login = "Login";
  static const rememberMe = "Remember me";
  static const byRegister =
      "By registration you are agree to our terms of use and privacy policy.";
  static const byRegistasion = "By registration you are agree to our ";
  static const email = "Email";
  static const emailConfirmation = "Email Confirmation";
  static const enterYourEmail = "Enter your email here";
  static const forgotPassword = "Forgot password";
  static const enterYourName = "Enter your name here";
  static const dontHaveAcount = "Don’t have a account";
  static const survey = "Survey";
  static const submit = "Submit";
  static const somethingWentWrong = "Something went wrong";
  static const String enterValidEmail = "Enter a valid email";

  static const enterYourOldPass = "Enter your old password";

  static const enterYourNewPass = "Enter your new password";
  static const confirmPass = "Confirm Password";

  static const allSurveyCompany = "All Survey Company";
  static const searchHere = "Search here";
  static const password = "Password";

  static const fieldCantNotBeEmpty = "Field can't be empty";

  static const oldPass = "Old password";
  static const newPass = "New password";

  static const enterYourPassword = "Enter your Password";
  static const logIn = "Log in";
  static const scanQRCode = "Scan QR Code";
  static const sendCode = "Send Code";
  static const verification = "Verification";
  static const verify = "Verify";
  static const enterVerificationCode = "Enter verification code";
  static const ifYouDidntAnyCode = "If you didn't any code!";
  static const resend = "Resend ";
  static const enterAValidOTP = "Enter a valid OTP";

  static const dontWorry =
      "Don’t worry! It Occurs. Please enter the email address linked with your account.";

  static const String passWordMustBeAtLeast =
      "Password must contain at least one uppercase letter, one lowercase letter, one number";

  static const String passwordLengthAndContain =
      "Password must be at least 8 characters long and at least one uppercase letter, one lowercase letter, one number";

  ///============================= Home Screen ================================

  static const searchhere = "Search here";
  static const pleaseChoosYour =
      "Please choose your native language for translating the question";

  static const allProjects = "All Projects";
  static const joinedCompany = "Joined Company";
  static const joinedSurvey = "Joined Survey";

  ///==================== Side Drawer ======================

  static const profile = "Profile";
  static const gotQRCode = "Got QR Code";
  static const yourSurvey = "Your Survey";
  static const editProfile = "Edit Profile";
  static const privacyPolicy = "Privacy Policy";
  static const termsAndCondition = "Terms & Condition";
  static const logOut = "Log Out";

  ///|<========================== Survey section ====================>

  static const allSurvey = "All Survey";
  static const howSatisfiedYou =
      "How satisfied are you with your current work environment?";
  static const bad = "Bad";
  static const verySatisfied = "Very satisfied";
  static const good = "Good";
  static const totalQuestion = "Total Question ";
  static const writeYourQuestion = "Write your comment here";
  static const next = "Next";
  static const quit = "Quit";
  static const joinCompany = "Join Company";
  static const joinReqSended = "Join request sended";
  static const pending = "pending";
  static const emoji = "emoji";
  static const noQuesFound = "No Question Found";

  static const noSurveyFound = "No survey found";

  ///<============================== All result section ======================>

  static const allResult = "All Results";
  static const companyName = "Company Name";
  static const name = "Name";
  static const update = "Update";
  static const userId = "User Id";

  static const projectName = "Project Name:";
  static const surveyName = "Survey Name:";
  static const totalQuestionWithColon = "Total Question:";
  static const qN = "QN.";
  static const ans = "Ans:";
  static const export = "Export";
  static const today = "Today";
  static const thisWeek = "This week";
  static const thisMonth = "This Month";
  static const lastMonth = "Last Month";
  static const paiChart = "Pai chart";
  static const lineChart = "Line chart";
  static const satisfied = "Satisfied";
  static const angry = "Angry";
  static const history = "History";

  static const notifications = "Notifications";
  static const companyID = "Company ID";
}
