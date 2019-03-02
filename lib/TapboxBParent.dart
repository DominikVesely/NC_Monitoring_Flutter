import 'package:flutter/material.dart';
import 'package:app/TapboxB.dart';

class TapboxBParent extends StatefulWidget {
  @override
  _TapboxBParentState createState() => _TapboxBParentState();
}

class _TapboxBParentState extends State<TapboxBParent> {
  bool _active = false;

  void _handleTabboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTabboxChanged,
      ),
    );
  }
}
