import 'package:bctpay/globals/index.dart';

ThemeData darkTheme() => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      visualDensity: VisualDensity.standard,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: themeLogoColorBlue,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFF0E2439),
      ),
      listTileTheme: const ListTileThemeData(
        dense: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        iconColor: Colors.white,
        textColor: Colors.white,
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.6,
        space: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0E2439),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: themeLogoColorOrange, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        floatingLabelStyle: const TextStyle(color: themeLogoColorOrange),
      ),
      textTheme: TextTheme(
        titleSmall: const TextStyle(
            fontSize: 16,
            color: Colors.white),
        titleMedium: const TextStyle(
            fontSize: 15,
            color: Colors.white),
        displayMedium: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        displayLarge: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        headlineLarge: GoogleFonts.poppins(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.poppins(fontSize: 12, color: themeGreyColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: themeLogoColorOrange,
        foregroundColor: Colors.white,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: themeLogoColorOrange,
        foregroundColor: Colors.white,
      )),
      checkboxTheme: const CheckboxThemeData(
        side: BorderSide(color: Colors.white),
      ),

      popupMenuTheme: PopupMenuThemeData(color: themeLogoColorBlue),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: themeLogoColorBlue,
        modalBackgroundColor: themeLogoColorBlue,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: themeLogoColorBlue,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: themeLogoColorBlue,
      ),
      chipTheme: ChipThemeData(
        selectedColor: themeLogoColorOrange,
      ),
      scaffoldBackgroundColor: themeLogoColorBlue,
    );
