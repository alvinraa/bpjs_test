import 'package:bpjs_test/core/common/assets.dart';
import 'package:bpjs_test/core/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorContent extends StatefulWidget {
  final String? title;
  final String? message;
  final String? detailMessage;
  final int? statusCode;
  final Function()? onRefresh;
  final Widget? top;
  final bool showRefresh;
  final String? refreshText;
  final ErrorType type;
  final double? paddingTop;

  const ErrorContent({
    super.key,
    this.title,
    this.message,
    this.detailMessage,
    this.statusCode,
    this.onRefresh,
    this.top,
    this.showRefresh = true,
    this.refreshText,
    this.type = ErrorType.general,
    this.paddingTop,
  });

  @override
  State<ErrorContent> createState() => _ErrorContentState();
}

class _ErrorContentState extends State<ErrorContent> {
  late Widget top;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case ErrorType.empty:
        return buildEmptyError(context);
      case ErrorType.general:
        return buildGeneralError(context);
      case ErrorType.generalSmall:
        return buildGeneralSmallError(context);
      default:
        return buildGeneralError(context);
    }
  }

  Widget buildEmptyError(BuildContext context) {
    //var colorScheme = Theme.of(context).colorScheme;
    var paddingTop =
        widget.paddingTop ?? MediaQuery.of(context).size.height / 8;

    if (widget.top == null) {
      top = Image.asset(
        Assets.emptyData,
        scale: 3,
      );
    } else {
      top = widget.top!;
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, paddingTop, 16, 100),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            top,
            const SizedBox(height: 32),
            GestureDetector(
              onLongPress: () async {
                await Helper.copyToClipboard(
                    widget.detailMessage ?? widget.message);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.message ?? "empty search",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: widget.showRefresh,
              child: ElevatedButton(
                onPressed: widget.onRefresh,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.refreshText ?? "retry",
                  style: GoogleFonts.nunitoSans(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGeneralError(BuildContext context) {
    //var colorScheme = Theme.of(context).colorScheme;
    var paddingTop =
        widget.paddingTop ?? MediaQuery.of(context).size.height / 8;

    if (widget.top == null) {
      top = Image.asset(
        Assets.emptyData,
        scale: 3,
      );
    } else {
      top = widget.top!;
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, paddingTop, 16, 100),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            top,
            const SizedBox(height: 32),
            GestureDetector(
              onLongPress: () async {
                await Helper.copyToClipboard(
                    widget.detailMessage ?? widget.message);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title ?? "failed get data",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.message ?? "default error",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: widget.showRefresh,
              child: ElevatedButton(
                onPressed: widget.onRefresh,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.refreshText ?? "retry",
                  style: GoogleFonts.nunitoSans(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGeneralSmallError(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPress: () async {
                await Helper.copyToClipboard(
                    widget.detailMessage ?? widget.message);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title ?? "failed get data",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.message ?? "default error",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: widget.showRefresh,
              child: ElevatedButton(
                onPressed: widget.onRefresh,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.refreshText ?? "retry",
                  style: GoogleFonts.nunitoSans(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum ErrorType { general, empty, generalSmall }
