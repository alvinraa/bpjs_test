import 'package:bpjs_test/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final String? label;
  final String? hintText;
  final String? hintDesc;
  final TextStyle? hintDescStyle;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? errorText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isDone;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final int maxLines;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? errorMaxLines;
  final bool hasAsterixOnLabel;
  final double? borderRadius;
  final Color? border;
  final bool isLabelOutside;
  final int? maxLength;
  final bool autofocus;

  /// suffixIcon must null if want to use passsword
  final bool isPassword;
  final bool obscureText;

  const DefaultTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.isDone = false,
    this.label,
    this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.prefix,
    this.suffixText,
    this.suffixIcon,
    this.suffix,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.textStyle,
    this.labelStyle,
    this.textInputAction,
    this.fillColor,
    this.maxLines = 1,
    this.initialValue,
    this.hintStyle,
    this.textCapitalization = TextCapitalization.none,
    this.hintDesc,
    this.hintDescStyle,
    this.inputFormatters,
    this.errorMaxLines,
    this.hasAsterixOnLabel = false,
    this.borderRadius,
    this.border,
    this.isLabelOutside = false,
    this.maxLength,
    this.autofocus = false,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool _securePassword = false;

  TextStyle? _textStyle = GoogleFonts.lato(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  TextStyle? _labelStyle = GoogleFonts.lato(
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  );

  TextStyle? _hintDescStyle = GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
  );

  @override
  void initState() {
    if (widget.textStyle != null) {
      _textStyle = widget.textStyle;
    }

    if (widget.labelStyle != null) {
      _labelStyle = widget.labelStyle;
    }

    if (widget.hintDescStyle != null) {
      _hintDescStyle = widget.hintDescStyle;
    }

    if (widget.isPassword) {
      _securePassword = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.label != null && widget.isLabelOutside == true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.label ?? '-',
                    style: _labelStyle,
                  ),
                ),
                if (widget.hasAsterixOnLabel)
                  Text(
                    '*',
                    style: TextStyle(
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        ),
        TextFormField(
          key: widget.key,
          initialValue: widget.initialValue,
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          autofocus: widget.autofocus,
          textCapitalization: widget.textCapitalization,
          onFieldSubmitted: widget.onFieldSubmitted ??
              (val) {
                !widget.isDone
                    ? widget.focusNode?.nextFocus()
                    : widget.focusNode?.unfocus();
              },
          textInputAction: widget.textInputAction ??
              (!widget.isDone ? TextInputAction.next : TextInputAction.done),
          onEditingComplete: widget.onEditingComplete,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          style: _textStyle,
          keyboardType: widget.textInputType,
          obscureText: _securePassword ? true : false,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          cursorColor: theme.colorScheme.secondary,
          decoration: InputDecoration(
            label: widget.isLabelOutside == false && widget.label != null
                ? UnconstrainedBox(
                    child: Row(
                      children: [
                        Text(
                          "${widget.label}",
                          style: widget.enabled == true
                              ? TextStyle(color: theme.colorScheme.secondary)
                              : const TextStyle(color: Colors.grey),
                        ),
                        if (widget.hasAsterixOnLabel)
                          Text(
                            '*',
                            style: TextStyle(
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.w700),
                          ),
                      ],
                    ),
                  )
                : null,
            floatingLabelBehavior: widget.isLabelOutside == false
                ? FloatingLabelBehavior.always
                : null,
            contentPadding: EdgeInsets.symmetric(
                horizontal:
                    widget.prefixIcon == null && widget.borderRadius != null
                        ? 32
                        : 16,
                vertical: widget.maxLines > 1 ? 10 : 0.0),
            filled: true,
            fillColor: widget.fillColor ?? theme.colorScheme.onPrimary,
            isDense: widget.prefixIcon != null ? true : false,
            prefixIconConstraints: widget.prefixIcon != null
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            prefixText: widget.prefixText,
            prefixIconColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.focused)
                    ? theme.colorScheme.secondary
                    : Colors.grey),
            suffix: widget.suffix,
            suffixText: widget.suffixText,
            suffixIcon: widget.suffixIcon ??
                (widget.isPassword
                    ? IconButton(
                        icon: _securePassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _securePassword = !_securePassword;
                          });
                        },
                      )
                    : null),
            suffixIconColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.focused)
                    ? theme.colorScheme.secondary
                    : Colors.grey),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.4),
                ),
            errorText: widget.errorText,
            errorMaxLines: widget.errorMaxLines,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.border ?? Styles().color.border,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.border ?? Styles().color.border,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: theme.colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.border ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: theme.colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: theme.colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
            ),
          ),
        ),
        Visibility(
          visible: widget.hintDesc != null,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 6.0, bottom: 6.0),
            child: Text(
              widget.hintDesc ?? '-',
              style: _hintDescStyle,
            ),
          ),
        ),
      ],
    );
  }
}
