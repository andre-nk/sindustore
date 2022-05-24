part of "../screens.dart";

class QRScanPage extends StatelessWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AutoSizeText(
          "Woi, ini QR",
          style: Theme.of(context).textTheme.displayLarge,
        )
      ) 
    );
  }
}