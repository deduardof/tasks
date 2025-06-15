import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks/src/core/routes/routes_app.dart';
import 'package:tasks/src/core/themes/app_themes.dart';
import 'package:tasks/src/features/themes/theme_cubit.dart';

class TasksApp extends StatelessWidget {
  const TasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) => MaterialApp.router(
        routerConfig: routesApp,
        themeMode: themeMode,
        theme: ThemeData(
          colorScheme: schemeLight,
          textTheme: GoogleFonts.ralewayTextTheme().copyWith(
            titleLarge: GoogleFonts.poppins(),
            titleMedium: GoogleFonts.poppins(),
            titleSmall: GoogleFonts.poppins(),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: schemeDark,
          textTheme: GoogleFonts.ralewayTextTheme().copyWith(
            titleLarge: GoogleFonts.poppins(),
            titleMedium: GoogleFonts.poppins(),
            titleSmall: GoogleFonts.poppins(),
          ),
        ),
      ),
    );
  }
}
