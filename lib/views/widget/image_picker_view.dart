import 'package:bctpay/globals/index.dart';

class ImagePickerView extends StatelessWidget {
  final double? iconSize;
  final void Function()? onTap;
  final String? btnText;
  final bool isSelected;
  final String? bgImageUrl;

  const ImagePickerView({
    super.key,
    this.onTap,
    this.iconSize,
    this.btnText,
    this.isSelected = false,
    this.bgImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white10 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: isSelected ? themeLogoColorOrange : Colors.grey,
          ),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: bgImageUrl ?? "",
                  errorWidget: (context, url, error) => Center(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_rounded,
                    size: iconSize ?? 100,
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      btnText ?? appLocalizations(context).uploadImage,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: Colors.white,
                          backgroundColor: Colors.black12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      appLocalizations(context).noteDocFormates,
                      style: textTheme(context).bodySmall?.copyWith(
                            color: Colors.white,
                            backgroundColor: Colors.black12,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
