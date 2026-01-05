import 'package:bctpay/globals/index.dart';

class Avatar extends StatelessWidget {
  final bool isLocalImage;
  final String url;
  final double dimension;
  final double radious;
  final void Function()? onTap;
  final String? errorImageUrl;
  const Avatar({
    super.key,
    required this.url,
    this.radious = 10,
    this.dimension = 100,
    this.isLocalImage = false,
    this.onTap,
    this.errorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radious),
        child: isLocalImage
            ? Image.asset(
                url,
                height: dimension,
                width: dimension,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: errorImageUrl != null
                      ? Image.asset(errorImageUrl ?? "")
                      : Icon(Icons.error),
                ),
              )
            : CachedNetworkImage(
                imageUrl: url,
                height: dimension,
                width: dimension,
                fit: BoxFit.cover,
                progressIndicatorBuilder: progressIndicatorBuilder,
                errorWidget: (context, error, stackTrace) => Center(
                  child: errorImageUrl != null
                      ? Image.asset(errorImageUrl ?? "")
                      : Icon(
                          Icons.error,
                          color: Colors.black,
                        ),
                ),
              ),
      ),
    );
  }
}
