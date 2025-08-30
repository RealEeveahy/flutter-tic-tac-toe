import 'package:flutter/material.dart';

class UserDataLabel extends StatelessWidget {
  UserDataLabel({required this.labelName, required this.child, super.key});

  final String labelName;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text('$labelName: '),
          child,
        ],
    );
  }
}

class UserDataCount extends StatefulWidget {
  late _DataCountState myState;
  UserDataCount({required this.initCount,super.key});

  final int initCount;

  @override
  State createState()
  // ignore: no_logic_in_create_state
  {
    myState=_DataCountState();
    return myState;
  }
}

class _DataCountState extends State<UserDataCount>
{
  int myStat = 0;

  @override
  void initState() {
    myStat = widget.initCount;
    super.initState();
  }

  void updateCount(int setCount) { setState(() {
    myStat = setCount;
  });}

  @override
  Widget build(BuildContext context,) {
    return Text(myStat.toString());
  }
}