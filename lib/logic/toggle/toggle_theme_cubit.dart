import 'package:bloc/bloc.dart';
import 'package:cyclego/constants/enums/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'toggle_theme_state.dart';

class ToggleThemeCubit extends Cubit<ToggleThemeState> {
  late SharedPreferences sharedPreferences;
  final String _system = "system";
  final String _dark = "dark";
  final String _light = "light";
  ToggleThemeCubit({required this.sharedPreferences})
      : super(const ToggleThemeState(currentToggle: CurrentToggle.system));

  getSavedToggleOption() {
    final option = sharedPreferences.getString('option') ?? "";
    if (option == _system) {
      systemMode();
      return;
    }
    if (option == _light) {
      lightMode();
      return;
    }
    if (option == _dark) {
      darkMode();
      return;
    }
    systemMode();
  }

  onOptionChange(String option) async {
    await _saveOption(option);
  }

  darkMode() {
    onOptionChange(_dark);
    emit(const ToggleThemeState(currentToggle: CurrentToggle.dark));
  }

  lightMode() {
    onOptionChange(_light);
    emit(const ToggleThemeState(currentToggle: CurrentToggle.light));
  }

  systemMode() {
    onOptionChange(_light);
    emit(const ToggleThemeState(currentToggle: CurrentToggle.system));
  }

  Future _saveOption(String option) async {
    await sharedPreferences.setString(
        'option',
        option == _system
            ? _system
            : option == _light
                ? _light
                : option == _dark
                    ? _dark
                    : "");
  }
}
