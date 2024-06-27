class FirebaseConstant{
  static Firestore firestore = Firestore._internal();
  static Storage storage = Storage._internal();
}

class Firestore{
  Firestore._internal();
  final String api = 'Api';
  final String openApi = 'OpenApi';
  final String dialogue = 'Dialogue';
  final String statistics = 'Statistics';
  final String dialogueAnalysis = 'DialogueAnalysis';
  final String dictionary = 'Dictionary_v3';
  final String editor = 'Editor';
  final String feedback = 'Feedback';
  final String login = 'Login';
  final String premium = 'Premium';
  final String story = 'Story_v3';
}

class Storage{
  Storage._internal();
}