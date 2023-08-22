part of 'theme_cubit.dart';

/// A class representing the state of the application's theme.
class ThemeState extends Equatable {
  /// The current theme data.
  ThemeData themeData;

  /// Indicates whether the current theme is dark.
  bool isDark;

  /// Creates a ThemeState instance with the provided theme data and darkness status.
  ThemeState({
    required this.themeData,
    required this.isDark,
  });

  /// Creates an initial ThemeState instance with light theme and not in dark mode.
  factory ThemeState.initial() {
    return ThemeState(themeData: ThemeData.light(), isDark: false);
  }

  /// Creates a new ThemeState instance based on the provided parameters, or uses the existing values if not provided.
  ThemeState copyWith({
    ThemeData? themeData,
    bool? isdark,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      isDark: isdark ?? this.isDark,
    );
  }

  @override
  List<Object> get props => [themeData, isDark];
}
