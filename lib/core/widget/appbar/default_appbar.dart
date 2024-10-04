import 'package:bpjs_test/app.dart';
import 'package:bpjs_test/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppBarType { basic, main }

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? centerTitle;
  final AppBarType type;
  final bool useWidgetTitle;
  final Widget? titleWidget;
  final bool automaticallyImplyLeading;

  const DefaultAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.type = AppBarType.basic,
    this.useWidgetTitle = false,
    this.titleWidget,
    this.automaticallyImplyLeading = true,
  });

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    var isDark = App.of(context).themeType == ThemeType.dark;
    SystemChrome.setSystemUIOverlayStyle(
        isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);

    switch (widget.type) {
      case AppBarType.basic:
        return basicAppbar(context);

      case AppBarType.main:
        return mainAppbar(context);

      default:
        return basicAppbar(context);
    }
  }

  Widget basicAppbar(BuildContext context) {
    if (widget.useWidgetTitle) {
      assert(widget.titleWidget != null,
          "useWidgetTitle == true, then titleWidget cannot be null");
    }

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      leading: widget.leading,
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: widget.useWidgetTitle
          ? widget.titleWidget
          : Text(
              widget.title ?? "",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
      actions: widget.actions,
    );
  }

  Widget mainAppbar(BuildContext context) {
    List<Widget> list = <Widget>[];
    list.add(widget.leading ?? Container());

    return AppBar(
      elevation: 0,
      // backgroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: list,
      ),
      actions: widget.actions,
    );
  }
}
