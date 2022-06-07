import 'package:hive/hive.dart';

part 'surveydata.g.dart';

const _boxName = 'surveydata';

@HiveType(typeId: 14)
class SurveyData {
  factory SurveyData() => _instance;

  // private constructor
  SurveyData._();

  static final SurveyData _instance = SurveyData._();
  static SurveyData get instance => _instance;

  /// Writes the current instance to local storage
  static Future<void> save() async =>
      Hive.box<SurveyData>(_boxName).put('data', _instance);

  @HiveField(0)
  List<int> completedQuestions = [];

  @HiveField(1)
  List<int> completedSurveys = [];

  @HiveField(2)
  bool optOut = false;
}

Future<void> initSurveyData() async {
  try {
    Hive.registerAdapter(SurveyDataAdapter());
  } catch (e) {
    return;
  }

  await Hive.openBox<SurveyData>(_boxName);
  final questionData = Hive.box<SurveyData>(_boxName);
  questionData.get('data') ?? SurveyData();
}
