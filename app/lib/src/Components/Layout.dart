import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listchat/src/Navigator/StringScreen.dart';

List<dynamic> _list = <dynamic>[
  {'icon': Icons.home, 'screenName': HOMESCREEN},
  {'icon': Icons.info_outline, 'screenName': ACCOUNTSCREEN},
  {'icon': Icons.settings, 'screenName': SETTINGSCREEN}
];

class ThemeApp extends StatefulWidget {
  final Widget title;
  final Widget leading;
  final Color backgroundColor;
  final Widget child;
  final bool isShowingBottomBar;
  final bool isScroll;
  final bool isLoading;
  final Widget floatingActionButton;
  final Widget buttom;
  final List<Widget> actions;

  ThemeApp({
    this.title,
    this.leading,
    this.backgroundColor,
    this.floatingActionButton,
    this.buttom,
    this.actions,
    @required this.isLoading,
    @required this.child,
    @required this.isShowingBottomBar,
    this.isScroll = true,
  }) : super();

  @override
  ThemeAppState createState() => ThemeAppState();
}

class ThemeAppState extends State<ThemeApp> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _showBottomBar(bool isShowing) => !isShowing
      ? null
      : BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            ..._list.map(
              (elemnt) => BottomNavigationBarItem(
                icon: Icon(elemnt['icon']),
                title: Text(elemnt['screenName']),
              ),
            ),
          ],
          selectedItemColor: Colors.blue,
          onTap: _onTap,
          currentIndex: _currentIndex,
        );

  List<Widget> _buildScreen() {
    List<Widget> widgets = <Widget>[];

    widgets.add(Scaffold(
      appBar: AppBar(
        title: widget.title,
        backgroundColor: widget.backgroundColor,
        leading: widget.leading,
        bottom: widget.buttom,
        actions: widget.actions,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: widget.isScroll
              ? SingleChildScrollView(
                  child: widget.child,
                  primary: false,
                )
              : widget.child,
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: _showBottomBar(widget.isShowingBottomBar),
    ));

    if (widget.isLoading) {
      widgets.add(Container(
          alignment: Alignment.center,
          color: Color.lerp(Colors.black, null, 0.5),
          child: CircularProgressIndicator()));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: _buildScreen(),
      );
}
