part of widgets;

class BaseNetworkImage extends CachedNetworkImage {
  final BorderRadius borderRadius;
  final Widget? customErrorWidget;

  BaseNetworkImage({
    required super.imageUrl,
    super.key,
    super.width,
    super.height,
    super.alignment,
    super.fit,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.customErrorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (_, __) => BaseLoadingCard(
          height: height,
          width: width,
        ),
        alignment: alignment,
        imageBuilder: (c, image) => Image(
          image: image,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
        ),
        errorWidget: (_, __, ___) =>
            customErrorWidget ??
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: const BaseIcon(
                icon: AppIcons.logo,
                fit: BoxFit.fill,
              ),
            ),
      ),
    );
  }
}
