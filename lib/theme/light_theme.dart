import 'package:bctpay/globals/index.dart';

ThemeData lightTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    visualDensity: VisualDensity.standard,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    listTileTheme: const ListTileThemeData(
      dense: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: Colors.black,
      textColor: Colors.black,
    ),
    dividerTheme: const DividerThemeData(
      thickness: 0.7,
      space: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: themeLogoColorOrange, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      floatingLabelStyle: const TextStyle(color: themeLogoColorOrange),
    ),
    textTheme: TextTheme(
      titleSmall: const TextStyle(
          fontSize: 16,
          color: Colors.black),
      titleMedium: const TextStyle(
          fontSize: 15,
          color: Colors.black),

      displayMedium: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayLarge: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      headlineLarge: GoogleFonts.poppins(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.poppins(),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 12,
        color: themeGreyColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: themeLogoColorBlue,
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: themeLogoColorBlue,
    )),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(color: Colors.black),
    ),
    chipTheme: ChipThemeData(
      selectedColor: themeLogoColorOrange,
    ),
    scaffoldBackgroundColor: Colors.white,
    popupMenuTheme: PopupMenuThemeData(iconColor: Colors.black));
