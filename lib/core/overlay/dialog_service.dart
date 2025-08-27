import 'package:expense_splitter/core/constants/responsive_breakpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DialogRoute? dialogRoute;

class DialogService {
  void dismissDialog({required BuildContext context}) {
    try {
      if (dialogRoute != null) {
        Navigator.of(context).removeRoute(dialogRoute!);
        dialogRoute = null;
      }
    } catch (_) {}
  }

  Future<void> showConfirmDialog({
    required BuildContext context,
    String label = "Are you sure?",
    String? yesLabel,
    String? noLabel,
    Function()? onClickYes,
    Function()? onClickNo,
  }) async {
    if (dialogRoute != null) {
      dismissDialog(context: context);
    }

    dialogRoute = DialogRoute(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadiusM),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kBasePaddingM,
              vertical: kBasePaddingM,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: kButtonHeightS,
                        child: FilledButton(
                          onPressed: () {
                            if (onClickNo != null) onClickNo();
                            dismissDialog(context: context);
                          },

                          child: const Text("Cancel"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: kButtonHeightS,
                        child: FilledButton(
                          onPressed: () {
                            if (onClickYes != null) onClickYes();
                            dismissDialog(context: context);
                          },

                          child: const Text("Confirm"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    Navigator.of(context).push(dialogRoute!);
  }

  // Future<void> showCustomDialog({
  //   required BuildContext context,
  //   required Widget widget,
  // }) async {
  //   if (dialogRoute != null) {
  //     dismissDialog(context: context);
  //   }

  //   dialogRoute = DialogRoute(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return Dialog(
  //         // backgroundColor: AppColors.bg1,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(AppConstants.baseBorderRadiusS),
  //         ),
  //         child: widget,
  //       );
  //     },
  //   );
  //   Navigator.of(context).push(dialogRoute!);
  // }

  Future<void> showLoadingDialog({required BuildContext context}) async {
    if (dialogRoute != null) {
      dismissDialog(context: context);
    }

    dialogRoute = DialogRoute(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kBasePaddingL,
              vertical: kBasePaddingL,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      shape: const CircleBorder(),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CupertinoActivityIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    Navigator.of(context).push(dialogRoute!);
  }
}
