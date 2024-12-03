abstract class GeneralUiEvent {}

@Deprecated('No UI handler allowed in EventBus')
class UIShowSnackbar extends GeneralUiEvent {
  final String message;

  UIShowSnackbar(this.message);
}
