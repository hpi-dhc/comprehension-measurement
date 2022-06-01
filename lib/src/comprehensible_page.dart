import 'package:auto_route/auto_route.dart';
import 'package:comprehension_measurement/comprehension_measurement.dart';
import 'package:flutter/material.dart';

abstract class AutoComprehensiblePage extends StatefulWidget {
  const AutoComprehensiblePage({
    Key? key,
    this.comprehensionContext,
    required this.surveyId,
    this.tab = false,
    this.didOpenTab,
  }) : super(key: key);

  @protected
  Widget build(BuildContext context);

  final BuildContext? comprehensionContext;
  final int surveyId;
  final bool tab;
  final Function? didOpenTab;

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
    measureComprehension(
        widget.comprehensionContext ?? context, widget.surveyId);
    super.didPushNext();
  }

  @override
  void didPop() {
    measureComprehension(
        widget.comprehensionContext ?? context, widget.surveyId);
    super.didPop();
  }
}
