part of widgets;

class BaseLoadingCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;

  const BaseLoadingCard({
    super.key,
    this.width,
    this.height,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CustomShimmer(
        highlightColor: Colors.white,
        baseColor: Colors.grey,
        child: ShimmerLoading(
          isLoading: true,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
