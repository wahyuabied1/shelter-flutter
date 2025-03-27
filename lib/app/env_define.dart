import 'package:flutter/foundation.dart';

/// Configurable compilation environment declarations.
/// This contain list of all available compilation environment
/// To set it, you can add --dart-define=environmentName=environmentValue
/// Ref : https://dart.dev/guides/environment-declarations
///
/// Example:
/// flutter run --dart-define=enableDevOps=true
/// flutter build apk --dart-define=enableDevOps=true

// Enable DevOps screen
const kEnableDevOps = !kReleaseMode || bool.fromEnvironment('enableDevOps');

const String kFlavor = String.fromEnvironment('flavor');

const isDev = 'dev';
const isProd = 'prod';

const kInternalOnly = bool.fromEnvironment(
  'internalOnly',
  defaultValue: false,
);

// Enable Page Indicator
// It's the thing that enable you to see the page Class Name on top of the page
const kEnablePageIndicator =
    !kReleaseMode || bool.fromEnvironment('enablePageIndicator');
