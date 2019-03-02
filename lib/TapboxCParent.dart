import 'package:flutter/material.dart';
import 'package:app/TapboxC.dart';

class TapboxCParent extends StatefulWidget {
  @override
  _TapboxCParentState createState() => _TapboxCParentState();
}

class _TapboxCParentState extends State<TapboxCParent> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}