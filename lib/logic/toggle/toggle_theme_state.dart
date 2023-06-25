part of 'toggle_theme_cubit.dart';

class ToggleThemeState extends Equatable {
  final CurrentToggle currentToggle;
  const ToggleThemeState({required this.currentToggle});
  @override
  // TODO: implement props
  List<Object?> get props => [currentToggle];
}
