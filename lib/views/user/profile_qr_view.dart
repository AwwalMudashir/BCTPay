import 'dart:io';

import 'package:bctpay/globals/index.dart';

class ProfileQRScreen extends StatefulWidget {
  const ProfileQRScreen({super.key});

  @override
  State<ProfileQRScreen> createState() => _ProfileQRScreenState();
}

class _ProfileQRScreenState extends State<ProfileQRScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  UserModel? user;

  @override
  void initState() {
    bankAccountListBloc.add(GetBankAccountListEvent());
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.qrCode,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder(
                bloc: getProfileDetailFromLocalBloc,
                builder: (context, state) {
                  if (state is SharedPrefGetUserDetailState) {
                    user = state.user;
                    return Screenshot(
                        controller: screenshotController,
                        child: ProfileQRScreenView(
                          user: user,
                        ));
                  }
                  return const Loader();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                    onPressed: () {
                      screenshotController
                          .captureFromWidget(
                              buildProfileQRScreenshot(
                                  context: context, user: user),
                              context: context)
                          .then((image) async {
                        DocumentFileSavePlus()
                            .saveFile(
                                image,
                                "BCTPay_Profile_QR_${DateTime.now()}.png",
                                "appliation/png")
                            .whenComplete(() {
                          if (!context.mounted) return;
                          showToast(appLocalizations(context).fileDownloaded);
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.file_download_outlined,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.download,
                    )),
                OutlinedButton.icon(
                    onPressed: () {
                      screenshotController
                          .captureFromWidget(
                              buildProfileQRScreenshot(
                                  context: context, user: user),
                              context: context)
                          .then((image) async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final pathOfImage = await File(
                                '${directory.path}/BCTPay_Profile_QR_${DateTime.now()}.png')
                            .create();
                        await pathOfImage.writeAsBytes(image.toList()).then(
                            (value) => SharePlus.instance.share(
                                ShareParams(files: [XFile(value.path)])));
                      });
                    },
                    icon: const Icon(
                      Icons.share,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.share,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
