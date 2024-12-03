abstract class UiStateRepository {
  abstract bool sampleBoolean;

  Future<bool> get seenOnboarding;
  Future<bool> get hasLaunchedBrivaEwallet;
  Future<bool> get isSurveyEdited;
  Future<bool> get isFirstGradLoanCacheChecked;
  Future<bool> get hasLaunchedTopUpOtcEwallet;
  Future<bool> get hasLaunchedFormGuidance;
  Future<bool> get isErrorPaymentWidget;

  Future<void> setSeenOnboarding(bool value);
  Future<void> setHasLaunchedBrivaEwallet(bool value);

  Future<void> setSurveyEditted(bool value);
  Future<void> setHasLaunchedFormGuidance(bool value);
  Future<void> setIsFirstGradLoanCacheChecked(bool value);
  Future<void> setHasLaunchedTopUpOtcEwallet(bool value);
  Future<void> setErrorPaymentWidget(bool value);
}
