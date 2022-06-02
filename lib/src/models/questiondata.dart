import 'package:hive/hive.dart';

part 'questiondata.g.dart';

const _boxName = 'questiondata';

@HiveType(typeId: 14)
class QuestionData {
  factory QuestionData() => _instance;

  // private constructor
  QuestionData._();

  static final QuestionData _instance = QuestionData._();
  static QuestionData get instance => _instance;

  /// Writes the current instance to local storage
  static Future<void> save() async =>
      Hive.box<QuestionData>(_boxName).put('data', _instance);

  @HiveField(0)
  List<int>? questionIds;
}

Future<void> initQuestionData() async {
  try {
    Hive.registerAdapter(QuestionDataAdapter());
  } catch (e) {
    return;
  }

  await Hive.openBox<QuestionData>(_boxName);
  final questionData = Hive.box<QuestionData>(_boxName);
  questionData.get('data') ?? QuestionData();
}
