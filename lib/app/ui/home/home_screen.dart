part of home_part;

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Center(child: BaseLoader(color: Colors.orange)),
    );
  }
}
