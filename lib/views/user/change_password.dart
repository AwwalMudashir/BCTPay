import 'package:bctpay/globals/index.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  final oldPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final newPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final confirmNewPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));

  var changePwdBloc = ApisBloc(ApisBlocInitialState());
  final enableSubmitBtnBloc = SelectionBloc(SelectBoolState(false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).changePassword),
      body: SafeArea(
        child: BlocConsumer(
            bloc: changePwdBloc,
            listener: (context, state) {
              if (state is ChangePasswordState) {
                if (state.value.code == 200) {
                  showSuccessDialog(state.value.message, context,
                      onOkBtnPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall: state is ApisBlocLoadingState,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        BlocBuilder(
                            bloc: oldPasswordVisiblityBloc,
                            builder: (context, pwdVisiblityState) {
                              if (pwdVisiblityState is SelectBoolState) {
                                return CustomTextField(
                                  controller: oldPasswordController,
                                  obscureText: pwdVisiblityState.value,
                                  labelText:
                                      "${appLocalizations(context).oldPassword} *",
                                  hintText: appLocalizations(context)
                                      .enterOldPassword,
                                  prefix: Image.asset(
                                    Assets.assetsImagesKey,
                                    scale: textFieldSuffixScale,
                                  ),
                                  suffix: InkWell(
                                    onTap: () {
                                      oldPasswordVisiblityBloc.add(
                                          SelectBoolEvent(
                                              !pwdVisiblityState.value));
                                    },
                                    child: Icon(
                                      pwdVisiblityState.value
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: validate,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appLocalizations(context)
                                          .pleaseEnterYourOldPassword;
                                    }
                                    return null;
                                  },
                                );
                              }
                              return const Loader();
                            }),
                        BlocBuilder(
                            bloc: newPasswordVisiblityBloc,
                            builder: (context, pwdVisiblityState) {
                              if (pwdVisiblityState is SelectBoolState) {
                                return CustomTextField(
                                  controller: newPasswordController,
                                  obscureText: pwdVisiblityState.value,
                                  labelText:
                                      "${appLocalizations(context).newPassword} *",
                                  hintText: appLocalizations(context)
                                      .enterNewPassword,
                                  prefix: Image.asset(
                                    Assets.assetsImagesKey,
                                    scale: textFieldSuffixScale,
                                  ),
                                  suffix: InkWell(
                                    onTap: () {
                                      newPasswordVisiblityBloc.add(
                                          SelectBoolEvent(
                                              !pwdVisiblityState.value));
                                    },
                                    child: Icon(
                                      pwdVisiblityState.value
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: validate,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appLocalizations(context)
                                          .pleaseEnterYourNewPassword;
                                    }
                                    if (!validatePassword(value)) {
                                      return appLocalizations(context)
                                          .includesALetterDigitAndSpecialCharacter;
                                    }
                                    return null;
                                  },
                                );
                              }
                              return const Loader();
                            }),
                        BlocBuilder(
                            bloc: confirmNewPasswordVisiblityBloc,
                            builder: (context, pwdVisiblityState) {
                              if (pwdVisiblityState is SelectBoolState) {
                                return CustomTextField(
                                  controller: confirmNewPasswordController,
                                  obscureText: pwdVisiblityState.value,
                                  labelText:
                                      "${appLocalizations(context).confirmNewPassword} *",
                                  hintText: appLocalizations(context)
                                      .enterConfirmNewPassword,
                                  prefix: Image.asset(
                                    Assets.assetsImagesKey,
                                    scale: textFieldSuffixScale,
                                  ),
                                  suffix: InkWell(
                                    onTap: () {
                                      confirmNewPasswordVisiblityBloc.add(
                                          SelectBoolEvent(
                                              !pwdVisiblityState.value));
                                    },
                                    child: Icon(
                                      pwdVisiblityState.value
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: validate,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appLocalizations(context)
                                          .pleaseEnterYourConfirmNewPassword;
                                    }
                                    if (value != newPasswordController.text) {
                                      return appLocalizations(context)
                                          .passwordIsNotMatching;
                                    }
                                    if (!validatePassword(value)) {
                                      return appLocalizations(context)
                                          .includesALetterDigitAndSpecialCharacter;
                                    }
                                    return null;
                                  },
                                );
                              }
                              return const Loader();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder(
                                  bloc: enableSubmitBtnBloc,
                                  builder: (context, enableSubmitBtnState) {
                                    if (enableSubmitBtnState
                                        is SelectBoolState) {
                                      bool canChange =
                                          enableSubmitBtnState.value;
                                      return CustomBtn(
                                        text: appLocalizations(context).submit,
                                        onTap: canChange
                                            ? () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  changePwdBloc.add(
                                                      ChangePasswordEvent(
                                                          oldPassword:
                                                              oldPasswordController
                                                                  .text,
                                                          newPassword:
                                                              newPasswordController
                                                                  .text));
                                                }
                                              }
                                            : null,
                                      );
                                    }
                                    return const Loader();
                                  }),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomBtn(
                              color: Colors.red,
                              text: appLocalizations(context).cancel,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void validate(String p1) {
    enableSubmitBtnBloc.add(SelectBoolEvent(_formKey.currentState!.validate()));
  }
}
