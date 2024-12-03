import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/app/theme_extensions.dart';
import 'package:shelter_super_app/feature/routes/homepage_routes.dart';

/// Provide helper and utility function for debugging a page
class PageWrapper extends StatelessWidget {
  final Widget child;

  const PageWrapper({
    super.key,
    required this.child,
  });

  List<DebugAction> _getAction() {
    return [
      DebugAction(
        title: 'Dev Ops',
        action: (context) => context.pushNamed(
          HomepageRoutes.main.name!,
        ),
      ),
    ];
  }

  void _showDebugMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (innnerContext) {
        return CupertinoActionSheet(
          actions: _getAction()
              .map((e) => CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(innnerContext);
                      e.action(context);
                    },
                    child: Text(e.title),
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Positioned.fill(child: child),
          if (kEnablePageIndicator || kInternalOnly) ...[
            if (kInternalOnly)
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Color(0xff1960D3).withOpacity(0.6),
                  child: Text(
                    'Internal Only',
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white),
                    maxLines: 1,
                  ),
                ),
              ),
            if (kEnablePageIndicator)
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        child: Builder(builder: (context) {
                          final screenType = child.runtimeType.toString();
                          return Text(
                            '($screenType)',
                            overflow: TextOverflow.ellipsis,
                            key: const Key('text-debug'),
                            style: context.textTheme.bodyMedium,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          );
                        }),
                        onLongPress: () {
                          _showDebugMenu(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ]
        ],
      );
  }
}

class DebugAction {
  DebugAction({
    required this.title,
    required this.action,
  });

  /// Action title
  final String title;

  /// On tap action
  final Function(BuildContext context) action;
}
