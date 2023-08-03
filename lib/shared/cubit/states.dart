abstract class AppStates {}

class InitialState extends AppStates {}

class BottomIndex extends AppStates {}

class Business_Load extends AppStates {}

class Business_Succeeded extends AppStates {}

class Business_Fail extends AppStates {
  final String error;

  Business_Fail(this.error);
}

class Sports_Load extends AppStates {}

class Sports_Succeeded extends AppStates {}

class Sports_Fail extends AppStates {
  final String error;

  Sports_Fail(this.error);
}

class Science_Load extends AppStates {}

class Science_Succeeded extends AppStates {}

class Science_Fail extends AppStates {
  final String error;

  Science_Fail(this.error);
}

class Country extends AppStates {}

class Change_Theme extends AppStates {}
class ChangeTheme extends AppStates {}

class Search_Load extends AppStates {}

class Search_Succeeded extends AppStates {}

class Search_Fail extends AppStates {
  final String error;

  Search_Fail(this.error);
}
