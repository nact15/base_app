part of widgets;

class BaseIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? height;
  final double? width;
  final double size;
  final BoxFit fit;

  const BaseIcon({
    required this.icon,
    super.key,
    this.fit = BoxFit.cover,
    this.color,
    this.size = 18,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      fit: fit,
      width: width ?? size,
      height: height ?? size,
      color: color,
    );
  }
}
