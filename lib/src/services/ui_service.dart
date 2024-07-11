
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:toastification/toastification.dart';

enum DialogStatus { warning, success }

enum ToastType { success, error, info }

@singleton
class UIService {
  void showMessage({required BuildContext context, required String title, required String message, required ToastType type}) {
    toastification.show(
      context: context,
      type: type == ToastType.info
          ? ToastificationType.info
          : (type == ToastType.success)
              ? ToastificationType.success
              : ToastificationType.error,
      title: Text(title),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 6),
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
          backgroundColor: color ?? EcoColors.light,
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
                              backgroundColor: MaterialStateProperty.all(status == DialogStatus.success ? EcoColors.primary : EcoColors.destructiveAccent)),
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
