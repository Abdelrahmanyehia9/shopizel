import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class FormfeildLabel extends StatelessWidget {
  const FormfeildLabel({super.key, required this.label});
final String label  ;
  @override
  Widget build(BuildContext context) {
    return             Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 4),
      child: Text(label.toUpperCase() , style: GoogleFonts.sen(fontSize: 13 , fontWeight: FontWeight.normal) , textAlign: TextAlign.center, ),
    ) ;

  }
}
