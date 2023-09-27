abstract class HomeStates {}

class InitialState extends HomeStates {}

class BottomIndex extends HomeStates {}

class Business_Load extends HomeStates {}

class Business_Succeeded extends HomeStates {}
class CreatDb extends HomeStates{}
class InsertToDb extends HomeStates{}
class GetFormDb extends HomeStates{}
class LoadData extends HomeStates{}
class DeleteElement extends HomeStates{}

class Business_Fail extends HomeStates {
  final String error;

  Business_Fail(this.error);
}

class Sports_Load extends HomeStates {}

class Sports_Succeeded extends HomeStates {}

class Sports_Fail extends HomeStates {
  final String error;

  Sports_Fail(this.error);
}

class Science_Load extends HomeStates {}

class Science_Succeeded extends HomeStates {}

class Science_Fail extends HomeStates {
  final String error;

  Science_Fail(this.error);
}

class Country extends HomeStates {}

class Change_Theme extends HomeStates {}

class Search_Load extends HomeStates {}

class Search_Succeeded extends HomeStates {}

class Search_Fail extends HomeStates {
  final String error;

  Search_Fail(this.error);
}
