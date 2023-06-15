import 'package:flutter/material.dart';

import 'infrastructure/ui/adr_notes/saveNotes.dart';
import 'infrastructure/ui/adr_styles/color.dart';
import 'infrastructure/ui/login.dart';

void main() => runApp(const NoteApp());

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNote',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => SaveNotes(),
      },
      theme: _noteTheme,
    );
  }
}

final ThemeData _noteTheme = _buildNoteTheme();

ThemeData _buildNoteTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: noteThemePink100,
      onPrimary: noteThemeBrown900,
      secondary: noteThemeBrown900,
      error: noteThemeErrorRed,
    ),
    textTheme: _buildNoteTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: noteThemePink100,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: noteThemeBrown900,
        ),
      ),
      floatingLabelStyle: TextStyle(
        color: noteThemeBrown900,
      ),
    ),
  );
}

TextTheme _buildNoteTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontSize: 18.0,
        ),
        bodySmall: base.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: noteThemeBrown900,
        bodyColor: noteThemeBrown900,
      );
}
