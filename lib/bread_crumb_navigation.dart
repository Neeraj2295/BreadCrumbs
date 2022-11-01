import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'navigation_observer.dart';

class BreadCrumbNavigator extends StatelessWidget {
  final List<Route> currentRouteStack;
  BreadCrumbNavigator() : this.currentRouteStack = routeStack.toList();
  @override
  Widget build(BuildContext context) {
    return RowSuper(
      alignment: Alignment.topLeft,
      children: List<Widget>.from(currentRouteStack
          .asMap()
          .map(
            (index, value) => MapEntry(
                index,
                GestureDetector(
                    onTap: () {
                      Navigator.popUntil(context,
                          (route) => route == currentRouteStack[index]);
                    },
                    child: _BreadButton(
                        index == 0
                            ? 'Home'
                            : currentRouteStack[index].settings.name,
                        currentRouteStack.last.settings.name,
                        index == 0,
                        currentRouteStack,
                    index))),
          )
          .values),
      mainAxisSize: MainAxisSize.max,
      innerDistance: -16,
    );
  }
}

class _BreadButton extends StatelessWidget {
  final String text;
  final String lastText;
  final bool isFirstButton;
  final List<Route<dynamic>> currentRouteStack;
  final int index;
  _BreadButton(this.text,this.lastText, this.isFirstButton, this.currentRouteStack, this.index);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TriangleClipper(!isFirstButton),
      child: Container(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: isFirstButton ? 8 : 8, end: 18, top: 8, bottom: 8),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(color:lastText==text||lastText=='/'?Colors.blue:Colors.black, fontSize: 16),
              ),
            Visibility(
                visible: lastText!=text,
                child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.blue,))
            ],
          ),
        ),
      ),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  final bool twoSideClip;

  _TriangleClipper(this.twoSideClip);

  @override
  Path getClip(Size size) {
    final Path path = new Path();
    if (twoSideClip) {
      path.moveTo(20, 0.0);
      path.lineTo(0.0, size.height / 2);
      path.lineTo(20, size.height);
    } else {
      path.lineTo(0, size.height);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 20, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
