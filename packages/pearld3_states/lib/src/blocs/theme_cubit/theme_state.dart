part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  ThemeData themeData;
  bool isDark;

  ThemeState({
    required this.themeData,
    required this.isDark,
  });
  factory ThemeState.initial() {
    return ThemeState(themeData: ThemeData.light(), isDark: false);
  }

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
