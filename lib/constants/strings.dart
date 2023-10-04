//package
import 'package:uuid/uuid.dart';

//app titel
const String signUpTitle = 'Sign Up';
const String loginTitle = 'Login';
const String corpperTitle = 'Corpper';
const String drawerAccountTitle = 'Account';
const String drawerThemeText = 'Theme';
const String profileTitle = 'Profile';
const String adminPageTitle = 'Admin';

//  text
const String sigInText = 'Sign In';
const String loginText = 'Log In';
const String logOut = 'Log Out';
const String upLoadText = 'Up Loading...';
const String signInNotMemberText = "Not a member?";
const String registerText = "Register now";

//showSnackBar text
const String showSnackBarAddUserText = 'User Created';

// Message
const String loadingText = 'Loading...';

//hinttext
const String hintEmailText = 'Email';
const String hintPasswordText = 'Password';

// firebaseStore key
const String usersFieldKey = 'users';

//bottombar text
const String homeText = 'Home';
const String searchText = 'Search';
const String profileText = 'Profile';

//preferences key
const String preferencesKey = "isDarkTheme";

String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => '${returnUuidV4()}.jpg';
