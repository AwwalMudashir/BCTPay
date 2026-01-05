import 'package:bctpay/lib.dart';
import 'package:bctpay/views/widget/common_address_view.dart';

class KYCIdentityVerificationDetails extends StatelessWidget {
  final bool isAddressProof;

  const KYCIdentityVerificationDetails(
      {super.key, this.isAddressProof = false});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as KYCIdentityVerificationDetails?;
    bool isAddProof = arg?.isAddressProof ?? false;

    isPDF(String? extension) => extension?.toLowerCase() == "pdf";

    return BlocConsumer(
        bloc: kycBloc,
        listener: (context, state) {
          if (state is DeleteKYCAddressDocState) {
            var code = state.value.code;
            if (code == 200) {
              showSuccessDialog(
                  state.value.message ?? state.value.error ?? "", context);
            } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(
                  state.value.message ?? state.value.error ?? "", context);
            } else {
              showFailedDialog(
                  state.value.message ?? state.value.error ?? "", context);
            }
            kycBloc.add(GetKYCDetailEvent());
          }
          if (state is DeleteKYCIdDocState) {
            var code = state.value.code;
            if (code == 200) {
              showSuccessDialog(
                  state.value.message ?? state.value.error ?? "", context);
            } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(
                  state.value.message ?? state.value.error ?? "", context);
            } else {
              showFailedDialog(
                  state.value.message ?? state.value.error ?? "", context);
            }
            kycBloc.add(GetKYCDetailEvent());
          }
        },
        builder: (context, state) {
          if (state is GetKYCDetailState) {
            var kycData = state.value.data;
            var kycStatus = kycData?.kycStatus ?? KYCStatus.pending;
            var proof = isAddProof ? kycData?.addProof : kycData?.identityProof;
            return Scaffold(
              appBar: CustomAppBar(
                title: "",
                titleWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations(context).kycDetails,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${appLocalizations(context).kycStatus} : ",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          kycStatus.name,
                          style: TextStyle(
                              color: getKYCStatusColor(kycStatus),
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  if (kycStatus != KYCStatus.pending)
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.kycHistory);
                        },
                        icon: const Icon(Icons.history))
                ],
              ),
              body: ListView(
                padding: EdgeInsets.all(5),
                children: [
                  Text(
                    isAddProof
                        ? appLocalizations(context).addressVerification
                        : appLocalizations(context).identityVerification,
                    style: textTheme(context)
                        .headlineMedium
                        ?.copyWith(color: themeLogoColorOrange),
                  ),
                  10.height,
                  isAddProof
                      ? _buildUserDetails(kycData, context)
                      : _buildIdProofDetails(kycData, context),
                  10.height,
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: (proof?.isEmpty ?? true)
                        ? Center(
                            child: Column(
                              children: [
                                Text(appLocalizations(context).noData),
                                OutlinedButton(
                                    onPressed: () {
                                      edit(context, kycData, isAddProof);
                                    },
                                    child:
                                        Text(appLocalizations(context).update))
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: proof?.length,
                            itemBuilder: (context, index) {
                              var idProof = proof?[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        idProof?.docType ??
                                            appLocalizations(context).unknown,
                                        style: textTheme(context)
                                            .titleMedium
                                            ?.copyWith(
                                                color: themeLogoColorOrange),
                                      ),
                                      2.width,
                                      KYCStatusView(
                                          kycStatus: idProof?.status ??
                                              KYCStatus.pending),
                                      Spacer(),
                                      if (canUploadKYC(
                                          mainKYCStatus: kycData?.kycStatus,
                                          canUpload: idProof?.canUpload,
                                          docStatus: idProof?.status))
                                        InkWell(
                                          onTap: () {
                                            edit(context, kycData, isAddProof);
                                          },
                                          child: Card(
                                              color: Colors.green,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                      if (canUploadKYC(
                                          mainKYCStatus: kycData?.kycStatus,
                                          canUpload: idProof?.canUpload,
                                          docStatus: idProof?.status))
                                        InkWell(
                                          onTap: () {
                                            kycBloc.add(isAddProof
                                                ? DeleteKYCAddressDocEvent(
                                                    identityProof: idProof!,
                                                    kycData: kycData,
                                                    isFile: false)
                                                : DeleteKYCIdDocEvent(
                                                    identityProof: idProof!,
                                                    kycData: kycData,
                                                    isFile: false));
                                          },
                                          child: const Card(
                                            color: Colors.red,
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                  10.height,
                                  _buildDocDetails(
                                      isAddProof, proof?[index], context),
                                  10.height,
                                  SizedBox(
                                    height: 150,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: idProof?.files?.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          5.width,
                                      itemBuilder: (context, i) => Stack(
                                        children: [
                                          isPDF(idProof
                                                  ?.files?[i].fileExtension)
                                              ? Image.asset(
                                                  Assets.assetsImagesPdf,
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.imageView,
                                                        arguments: ImageView(
                                                          imageUrl:
                                                              "$baseUrlKYCImage${idProof?.files?[i].fileName}",
                                                        ));
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "$baseUrlKYCImage${idProof?.files?[i].fileName}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                          if (canUploadKYC(
                                              mainKYCStatus: kycData?.kycStatus,
                                              canUpload: idProof?.canUpload,
                                              docStatus: idProof?.status))
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  kycBloc.add(isAddProof
                                                      ? DeleteKYCAddressDocEvent(
                                                          identityProof:
                                                              idProof!,
                                                          kycData: kycData,
                                                        )
                                                      : DeleteKYCIdDocEvent(
                                                          identityProof:
                                                              idProof!,
                                                          kycData: kycData));
                                                },
                                                child: const Card(
                                                  elevation: 5,
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                  )
                ],
              ),
              bottomNavigationBar: Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(
                    5, 5, 5, MediaQuery.of(context).viewInsets.bottom + 5),
                child: CustomBtn(
                    onTap: () {
                      isAddProof
                          ? Navigator.popUntil(
                              context,
                              (route) =>
                                  route.settings.name == AppRoutes.bottombar)
                          : Navigator.of(context).pushNamed(
                              AppRoutes.kycIdentityVerificationDetails,
                              arguments: KYCIdentityVerificationDetails(
                                  isAddressProof: true));
                    },
                    text: isAddProof
                        ? appLocalizations(context).done
                        : appLocalizations(context).next),
              ),
            );
          }
          return Loader();
        });
  }

  void edit(BuildContext context, KYCData? kycData, bool isAddProof) {
    isAddProof
        ? Navigator.of(context).pushNamed(AppRoutes.kycProofOfAddress,
            arguments: KYCProofOfAddress(
              kycData: kycData,
              fromDetail: true,
            ))
        : Navigator.of(context).pushNamed(AppRoutes.kycProofOfIdentity,
            arguments: KYCProofOfIdentity(
              kycData: kycData,
              fromDetail: true,
            ));
  }

  Column _buildDocDetails(
          bool isAddProof, IdentityProof? proof, BuildContext context) =>
      Column(
        children: [
          ProductRow(
              subtitle: appLocalizations(context).docIdNumber,
              value: proof?.docIdNumber ?? ""),
          ProductRow(
              subtitle: appLocalizations(context).validity,
              value:
                  "${proof?.validFrom?.formattedDate()} - ${proof?.validTill?.formattedDate()}"),
          if (proof?.viewComment == "true")
            ProductRow(
                subtitle: appLocalizations(context).comment,
                value: proof?.comment ?? ""),
        ],
      );

  Column _buildIdProofDetails(KYCData? kycData, BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${appLocalizations(context).name}${kycData?.userName ?? ""}",
          ),
          Text(
              "${appLocalizations(context).emailAddress}: ${kycData?.email ?? ""}"),
          Row(
            children: [
              Text(appLocalizations(context).phoneNumber),
              CountryFlag.fromCountryCode(
                selectedCountry?.countryCode ?? "GN",
                height: 15,
                width: 20,
              ),
              5.width,
              Text(kycData?.phoneNumber ?? ""),
            ],
          ),
          Text(
              "${appLocalizations(context).dob}: ${kycData?.userDob?.formattedDate()}"),
        ],
      );

  Widget _buildUserDetails(KYCData? kycData, BuildContext context) {
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    return BlocBuilder(
      bloc: getProfileDetailFromLocalBloc,
      builder: (context, state) {
        if (state is SharedPrefGetUserDetailState) {
          var user = state.user;
          return CommonAddressView(
            showAddressIcon: false,
            line1: user.line1,
            line2: user.line2,
            city: user.city,
            country: user.countryName,
            mainAxisAlignment: MainAxisAlignment.start,
            textStyle: textTheme(context).bodyMedium,
          );
        }
        return Loader();
      },
    );
  }
}
