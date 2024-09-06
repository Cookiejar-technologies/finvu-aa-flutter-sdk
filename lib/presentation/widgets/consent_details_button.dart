import 'package:flutter/material.dart';

import 'border_container.dart';
import 'consent_details_bottom_sheet.dart';

class ConsentDetailsButton extends StatelessWidget {
  const ConsentDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      child: ListTile(
        onTap: (){
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const ConsentDetailsBottomSheet()
          );
        },
        title: Text("VIEW CONSENT DETAILS"),
        trailing: Icon(Icons.arrow_forward_ios, size: 16,),
      ),
    );
  }
}
