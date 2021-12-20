import 'package:flutter/material.dart';

class IconTileWidget extends StatefulWidget {
  final void Function()? onTap;
  final Color? leadingColor;
  final Color? backgroundColor;
  final double? height;
  final double? leadingWidth;
  final Widget? leadingWidget;
  final List<Widget>? listInputs;
  final Icon? trailingIcon;

  const IconTileWidget(
      {Key? key,
      this.onTap,
      this.leadingColor,
      this.backgroundColor,
      this.height,
      this.leadingWidth,
      this.leadingWidget,
      this.listInputs,
      this.trailingIcon})
      : super(
          key: key,
        );

  @override
  _IconTileWidgetState createState() => _IconTileWidgetState();
}

class _IconTileWidgetState extends State<IconTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: widget.height ?? 70,
        color: widget.backgroundColor ?? Colors.white,
        child: Row(
          children: [
            Container(
              color: widget.leadingColor ?? Colors.white,
              width: widget.leadingWidth ?? 50,
              child: Center(
                child: widget.leadingWidget,
              ),
            ),
            Expanded(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: widget.listInputs ?? [],
                ),
              ),
            )),
            Container(
              width: 80,
              child: widget.trailingIcon,
            )
          ],
        ),
      ),
    );
  }
}
