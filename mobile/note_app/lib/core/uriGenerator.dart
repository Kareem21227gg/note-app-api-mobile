import 'constant.dart';

Uri deleteNote_Uri(String id) {
  return Uri.https(MAIN_URL, DELETE_NOTE + "/" + id);
}

Uri createNote_Uri() {
  return Uri.https(MAIN_URL, CREATE_NOTE);
}

Uri getAllNote_Uri() {
  return Uri.https(MAIN_URL, GET_ALL_NOTE);
}
