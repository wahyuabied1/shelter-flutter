import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Page with bottom sheet behaviour
///
/// compatible with declarative route like [GoRoute]
///
/// example:
///
/// final routeExample = GoRoute(
//     path: '/example',
//     name: 'Example Bottom Sheet',
//     pageBuilder: (context, state) {
//       return BottomSheetPage(builder: (context) {
//         return const ExampleWidget();
//       });
//     },
//   );
///
class BottomSheetPage<T> extends Page<T> {
  final WidgetBuilder builder;
  final bool isScrollControlled;
  final bool isDismissible;
  final bool enableDrag;
  const BottomSheetPage({
    required this.builder,
    this.isScrollControlled = false,
    this.isDismissible = false,
    this.enableDrag = false,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        settings: this,
        builder: builder,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.r),
          ),
        ),
        backgroundColor: Colors.white,
      );
}
