// Make a light ColorScheme from the seeds.
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/constants/app_colors.dart';

final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: AppColors.primarySeedColor,
  secondaryKey: AppColors.secondarySeedColor,
  tertiaryKey: AppColors.tertiarySeedColor,
  errorKey: AppColors.errorSeedColor,
  tones: FlexTones.vivid(Brightness.light),
);

// Make a dark ColorScheme from the same seed colors.
final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: AppColors.primarySeedColor,
  secondaryKey: AppColors.secondarySeedColor,
  tertiaryKey: AppColors.tertiarySeedColor,
  errorKey: AppColors.errorSeedColor,
  tones: FlexTones.vivid(Brightness.dark),
);
