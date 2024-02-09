part of widgets;

class BaseLoader extends StatelessWidget {
  final Color color;

  const BaseLoader({
    super.key,
    this.color = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: 2,
    );
  }
}
