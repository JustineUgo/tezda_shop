import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:toastification/toastification.dart';

enum DialogStatus { warning, success }

enum ToastType { success, error, info }

@singleton
class UIService {
  void showToast({required String text, required ToastType type}) {
    toastification.show(
      type: type == ToastType.info
          ? ToastificationType.info
          : (type == ToastType.success)
              ? ToastificationType.success
              : ToastificationType.error,
      title: Text(text),
      // description: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 6),
    );
  }

  Future<void> showEcoBottomSheet(BuildContext context, {String? title, required Widget child, bool enableDecoration = false}) async {
    await showModalBottomSheet(
      context: context,
      barrierColor: enableDecoration ? TezdaColors.dark.withOpacity(0) : null,
      isScrollControlled: true,
      builder: (context) => Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              color: TezdaColors.light,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
              boxShadow: enableDecoration
                  ? [
                      BoxShadow(
                        color: TezdaColors.neutral.withOpacity(.3),
                        spreadRadius: 8,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.baseDouble),
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (title != null)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title, style: context.textTheme.headlineLarge),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: Sizes.baseSingleQuarter),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showConfirmationDialog(
    BuildContext context, {
    required String icon,
    required String title,
    required String body,
    Widget? content,
    required DialogStatus status,
    String? confirmText,
    String? cancelText,
    Function()? onConfirm,
    Function()? onCancel,
    Color? color,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color ?? TezdaColors.light,
          icon: SvgPicture.asset(icon),
          contentPadding: const EdgeInsets.fromLTRB(Sizes.baseSingleHalf, 0, Sizes.baseSingleHalf, Sizes.baseTriple),
          title: Text(title, style: context.textTheme.headlineLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(body, textAlign: TextAlign.center, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400)),
              if (content != null) content,
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (cancelText != null && onCancel != null)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onCancel();
                          },
                          child: Center(child: Text(cancelText, textAlign: TextAlign.center)),
                        ),
                      ),
                    if (confirmText != null && cancelText != null) const SizedBox(width: Sizes.baseSingle),
                    if (confirmText != null && onConfirm != null)
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(status == DialogStatus.success ? TezdaColors.primary : TezdaColors.destructiveAccent)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            onConfirm();
                          },
                          child: Center(child: Text(confirmText)),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
