import 'package:bctpay/globals/index.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var messageController = TextEditingController();

  var selectPhoneCodeBloc = SelectionBloc(SelectionBlocInitialState());

  List<QueryType> topic = [];

  var selectTopicBloc = SelectionBloc(SelectionBlocInitialState());
  var contactUsBloc = ApisBloc(ApisBlocInitialState());
  var queryTypeBloc = ApisBloc(ApisBlocInitialState());
  String? selectedPhoneCode;

  QueryType? selectedTopic;

  var formKey = GlobalKey<FormState>();

  String? selectedCountryPhoneCode;

  var imagePickerBloc = SelectionBloc(SelectionBlocInitialState());

  List<XFile?> selectedAttachments = [];

  @override
  void initState() {
    super.initState();
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    queryTypeBloc.add(GetTypeOfQueriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).queries,
      ),
      body: BlocConsumer(
          bloc: contactUsBloc,
          listener: (context, state) {
            if (state is ContactUsState) {
              if (state.value.code == 200) {
                showSuccessDialog(state.value.message, context,
                    onOkBtnPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.queries);
                });
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              } else {
                showFailedDialog(state.value.message, context);
              }
            }
            if (state is ApisBlocErrorState) {
              showFailedDialog(state.message, context);
            }
          },
          builder: (context, contactUsState) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: contactUsState is ApisBlocLoadingState,
              child: BlocConsumer(
                  bloc: getProfileDetailFromLocalBloc,
                  listener: (context, state) {
                    if (state is SharedPrefGetUserDetailState) {
                      emailController.text = state.user.email;
                      phoneController.text = state.user.phone;
                      nameController.text = state.user.userName;
                      seperatePhoneAndDialCode(state.user.phoneCode,
                              selectPhoneCountryBloc: selectPhoneCodeBloc)
                          .then((country) {
                        if (country != null) {
                          selectPhoneCodeBloc.add(SelectCountryEvent(
                              Country.parse(country.countryCode), country));
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(appLocalizations(context)
                                .leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon),
                            CustomTextField(
                              controller: nameController,
                              labelText:
                                  "${appLocalizations(context).fullName} *",
                              hintText:
                                  appLocalizations(context).enterYourFullName,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return appLocalizations(context)
                                      .pleaseEnterYourFullName;
                                } else if (!specialCharRegex.hasMatch(p0)) {
                                  return appLocalizations(context)
                                      .pleaseEnterValidValue;
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              labelText:
                                  "${appLocalizations(context).emailAddress} *",
                              hintText:
                                  appLocalizations(context).enterEmailAddress,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return appLocalizations(context)
                                      .pleaseEnterYourEmailAddress;
                                } else if (!validateEmail(p0)) {
                                  return appLocalizations(context)
                                      .pleaseEnterYourValidEmailAddress;
                                }
                                return null;
                              },
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    labelText:
                                        "${appLocalizations(context).mobileNumber} *",
                                    hintText: AppLocalizations.of(context)!
                                        .enterMobileNumber,
                                    onChanged: (phone) async {
                                      var country =
                                          await seperatePhoneAndDialCode(phone,
                                              selectPhoneCountryBloc:
                                                  selectPhoneCodeBloc);
                                      if (country != null) {
                                        selectPhoneCodeBloc.add(
                                            SelectCountryEvent(
                                                Country.parse(
                                                    country.countryCode),
                                                country));
                                      }
                                    },
                                    prefixWidget: CountryPickerTxtFieldPrefix(
                                      readOnly: false,
                                      selectPhoneCountryBloc:
                                          selectPhoneCodeBloc,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return appLocalizations(context)
                                            .pleaseEnterYourMobileNumber;
                                      }
                                      if (selectedCountryPhoneCode == "224" &&
                                          !gnPhoneRegx.hasMatch(value)) {
                                        return appLocalizations(context)
                                            .pleaseEnterValidMobileNumber;
                                      } else if (!validatePhone(value)) {
                                        return appLocalizations(context)
                                            .pleaseEnterValidMobileNumber;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                width: width,
                                height: 60,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 30),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: shadowDecoration,
                                child: BlocConsumer(
                                    bloc: queryTypeBloc,
                                    listener: (context, state) {
                                      if (state is GetTypeOfQueriesState) {
                                        var code = state.value.code;
                                        if (code == 200) {
                                          topic = state.value.data ?? [];
                                          if (topic.isNotEmpty) {
                                            selectedTopic = topic.first;
                                            selectTopicBloc.add(
                                                SelectQueryTypeEvent(
                                                    topic.first));
                                          }
                                        } else if (code ==
                                            HTTPResponseStatusCodes
                                                .sessionExpireCode) {
                                          sessionExpired(
                                              state.value.message ?? "",
                                              context);
                                        } else {
                                          showFailedDialog(
                                              state.value.message ?? "",
                                              context);
                                        }
                                      }
                                    },
                                    builder: (context, queryTypeState) {
                                      if (topic.isEmpty) {
                                        return Center(
                                          child: Text(
                                            appLocalizations(context).noData,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        );
                                      }
                                      return BlocConsumer(
                                          bloc: selectTopicBloc,
                                          listener: (context, state) {
                                            if (state is SelectQueryTypeState) {
                                              selectedTopic = state.value;
                                            }
                                          },
                                          builder:
                                              (context, selectionBlocState) {
                                            if (selectionBlocState
                                                is SelectQueryTypeState) {
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: DropdownButton(
                                                    style: textTheme.titleMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    dropdownColor:
                                                        const Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                    itemHeight: 60,
                                                    iconEnabledColor:
                                                        Colors.black,
                                                    iconDisabledColor:
                                                        Colors.black,
                                                    underline: const SizedBox(),
                                                    isExpanded: true,
                                                    value: selectionBlocState
                                                        .value,
                                                    items: topic
                                                        .map((e) => DropdownMenuItem(
                                                            value: e,
                                                            child: Text(selectedLanguage ==
                                                                    "en"
                                                                ? (e.typeOfQueriesEn ??
                                                                    "")
                                                                : (e.typeOfQueriesGn ??
                                                                    ""))))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      selectedTopic = value;
                                                      selectTopicBloc.add(
                                                          SelectQueryTypeEvent(
                                                              value!));
                                                    }),
                                              );
                                            }
                                            return const Loader();
                                          });
                                    })),
                            CustomTextField(
                              controller: messageController,
                              maxLines: 5,
                              minLines: 1,
                              height: 150,
                              labelText:
                                  "${appLocalizations(context).message} *",
                              hintText: appLocalizations(context).enterMessage,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return appLocalizations(context)
                                      .pleaseEnterMessage;
                                }
                                return null;
                              },
                            ),
                            5.height,
                            Row(
                              children: [
                                Expanded(
                                  child: BlocBuilder(
                                      bloc: selectPhoneCodeBloc,
                                      builder: (context, selectPhoneCodeState) {
                                        if (selectPhoneCodeState
                                            is SelectCountryState) {
                                          selectedCountryPhoneCode =
                                              selectPhoneCodeState
                                                  .countryData.phoneCode;
                                          return CustomBtn(
                                            text: appLocalizations(context)
                                                .submit,
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                contactUsBloc.add(ContactUsEvent(
                                                    fullname:
                                                        nameController.text,
                                                    email: emailController.text,
                                                    phonenumber:
                                                        "+${selectPhoneCodeState.countryData.phoneCode}${phoneController.text}",
                                                    message:
                                                        messageController.text,
                                                    type: selectedTopic
                                                            ?.typeOfQueriesEn ??
                                                        "",
                                                    queryImage:
                                                        selectedAttachments));
                                              }
                                            },
                                          );
                                        }
                                        return CustomBtn(
                                            text: appLocalizations(context)
                                                .submit);
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
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
