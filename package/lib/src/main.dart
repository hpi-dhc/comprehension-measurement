import 'package:comprehension_measurement/src/constants.dart';
import 'package:comprehension_measurement/src/models/survey.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

Future<void> measureComprehension(BuildContext context, int surveyId) async {
  final client = SupabaseClient(
    supabaseUrl,
    supabaseKey,
  );

  // syntax is equivalent to https://postgrest.org/en/stable/api.html

  final response = await client
      .from('surveys')
      .select('*,questions(*),questions(*,answers(*))')
      .eq('id', surveyId)
      .single()
      .execute();

  final survey = Survey.fromJson(response.data);

  print(survey.title);
  print(survey.questions.length);

  showBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const Text("Text"),
        ),
      );
    },
  );
}
