import 'package:bctpay/globals/index.dart';

// Custom text field widget with enhanced styling and full parameter support
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixWidget;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final InputBorder? border;
  final TextAlign textAlign;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final double borderRadius;
  final AutovalidateMode? autovalidateMode;
  final int? maxLength;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.suffix,
    this.suffixText,
    this.prefix,
    this.prefixWidget,
    this.keyboardType,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.style,
    this.border,
    this.textAlign = TextAlign.start,
    this.initialValue,
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = false,
    this.inputFormatters,
    this.height = 70,
    this.borderRadius = 10,
    this.autovalidateMode,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          constraints: BoxConstraints(minHeight: height ?? 0.0),
          decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              border: Border.all(
                  color: isDarkMode ? Colors.white24 : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(borderRadius)),
          margin: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              if (prefixWidget != null) prefixWidget!,
              Expanded(
                child: TextFormField(
                  inputFormatters: inputFormatters,
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  initialValue: initialValue,
                  maxLines: maxLines,
                  minLines: minLines,
                  autovalidateMode: autovalidateMode,
                  style: style ??
                      const TextStyle().copyWith(
                        color: isDarkMode ? Colors.white : Colors.black,
                        height: 1.2,
                      ),
                  textAlign: textAlign,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.red),
                      labelText: labelText,
                      floatingLabelStyle:
                          Theme.of(context).inputDecorationTheme.floatingLabelStyle,
                      hintText: hintText,
                      labelStyle: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black87),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                          color: isDarkMode ? Colors.white54 : Colors.grey),
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        height: 1.1,
                        inherit: false,
                      ),
                      suffixText: suffixText,
                      suffixIcon: suffix,
                      prefixIcon: prefix,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      border: InputBorder.none),
                  validator: validator,
                  readOnly: readOnly,
                  onTap: onTap,
                  onChanged: onChanged,
                  autofocus: autofocus,
                  onEditingComplete: () {},
                  onSaved: (s) {},
                  onFieldSubmitted: (value) {},
                  onAppPrivateCommand: (action, data) {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? validator1(String? value) => null;
}
