import 'package:bctpay/lib.dart';

class ProfilePicView extends StatelessWidget {
  final double dimension;

  const ProfilePicView({super.key, this.dimension = 100});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BlocBuilder(
                bloc: getProfileDetailFromLocalBloc,
                builder: (context, state) {
                  if (state is SharedPrefGetUserDetailState) {
                    var profilePicUrl = state.user.profilePic;
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.imageView,
                            arguments: ImageView(
                              imageUrl: "$baseUrlProfileImage$profilePicUrl",
                            ));
                      },
                      child: Avatar(
                        dimension: dimension,
                        url: "$baseUrlProfileImage$profilePicUrl",
                        errorImageUrl: Assets.assetsImagesPerson,
                      ),
                    );
                  }
                  return const Loader();
                }),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: isDarkMode(context)
                          ? themeLogoColorBlue
                          : Colors.white,
                      builder: (context) => Container(
                        height: 150,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.photo_library_sharp),
                              title: Text(appLocalizations(context).gallery),
                              onTap: () {
                                ImagePickerController.pickImageFromGallery()
                                    .then((image) {
                                  if (image != null) {
                                    if (!context.mounted) return;
                                    onImageSelected(image, context);
                                  } else {
                                    if (!context.mounted) return;
                                    showToast(appLocalizations(context).close);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: Text(appLocalizations(context).camera),
                              onTap: () {
                                ImagePickerController.cameraCapture()
                                    .then((image) {
                                  if (image != null) {
                                    if (!context.mounted) return;
                                    onImageSelected(image, context);
                                  } else {
                                    if (!context.mounted) return;
                                    showToast(
                                        appLocalizations(context).tryAgain);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

void onImageSelected(XFile image, context) {
  showCustomDialog(
    appLocalizations(context).doYouReallyWantToUpdateProfileImage,
    context,
    title: appLocalizations(context).info,
    dialogType: DialogType.info,
    onYesTap: () {
      profileBloc.add(UploadProfilePicEvent(profilePic: image));
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );
}
