import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:comprehension_measurement/comprehension_measurement.dart';
import 'package:flutter/material.dart';

abstract class AutoComprehensiblePage extends StatefulWidget {
  AutoComprehensiblePage({
    Key? key,
    this.comprehensionContext,
    required this.surveyId,
    this.feedbackId,
    this.introText = 'Was the last page understandable for you?',
    this.surveyButtonText = 'Yes',
    this.feedbackButtonText = 'Close',
    this.questionContext,
    this.tab = false,
    this.didOpenTab,
    this.probability = 0.5,
    required this.supabaseConfig,
  }) {
    questionContext ??= {};
  }

  void setContext(String key, List<int> value) {
    questionContext![key] = value;
  }

  @protected
  Widget build(BuildContext context);

  final BuildContext? comprehensionContext;
  final int surveyId;
  final int? feedbackId;
  final String introText;
  final String surveyButtonText;
  final String feedbackButtonText;
  late Map<String, List<int>>? questionContext;
  final bool tab;
  final Function? didOpenTab;
  final double probability;
  final SupabaseConfig supabaseConfig;

  @override
  State<AutoComprehensiblePage> createState() => _AutoComprehensiblePageState();
}

class _AutoComprehensiblePageState extends State<AutoComprehensiblePage>
    with AutoRouteAwareStateMixin<AutoComprehensiblePage> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    if (widget.didOpenTab != null) {
      widget.didOpenTab!(previousRoute);
    }
    super.didChangeTabRoute(previousRoute);
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    if (widget.didOpenTab != null) {
      widget.didOpenTab!(previousRoute);
    }
    super.didInitTabRoute(previousRoute);
  }

  @override
  void didPushNext() {
    _measureComprehensionWithProbability();
    super.didPushNext();
  }

  @override
  void didPop() {
    _measureComprehensionWithProbability();
    super.didPop();
  }

  void _measureComprehensionWithProbability() {
    Random random = Random();
    double randomDouble = random.nextDouble();

    if (randomDouble <= widget.probability) {
      measureComprehension(
        context: widget.comprehensionContext ?? context,
        surveyId: widget.surveyId,
        feedbackId: widget.feedbackId,
        introText: widget.introText,
        surveyButtonText: widget.surveyButtonText,
        feedbackButtonText: widget.feedbackButtonText,
        questionContext: widget.questionContext,
        supabaseConfig: widget.supabaseConfig,
      );
    }
  }
}
