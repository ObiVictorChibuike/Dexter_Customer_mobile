import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0.0,
            title: Text("Privacy Policy", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 16),),
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back, color: black,)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                const SizedBox(height: 24,),
                Text("Type of Data we Collect", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 16),),
                const SizedBox(height: 8,),
                Text("Quo repellat esse voluptas aut ipsam exercitationem ex quis quis. "
                    "Harum voluptatum et aut. Ipsam rerum culpa veritatis quaerat. "
                    "Reiciendis laborum explicabo sit sit dolor tempore id fugiat. Placeat"
                    " ut ducimus et minima beatae autem id qui. Ipsa consequuntur "
                    "necessitatibus ipsa qui laudantium et sequi. Aut alias molestiae "
                    "voluptates consequuntur qui quaerat. Aliquid quidem maxime ut totam "
                    "optio et voluptatum fugit. Odit qui eos voluptatem officiis inventore. "
                    "Aut nam error rerum assumenda.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontWeight: FontWeight.w400, fontSize: 14),),
                const SizedBox(height: 24,),
                Text("Use of your Personal Data", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 16),),
                const SizedBox(height: 8,),
                Text("Quo repellat esse voluptas aut ipsam exercitationem ex quis quis. "
                    "Harum voluptatum et aut. Ipsam rerum culpa veritatis quaerat. "
                    "Reiciendis laborum explicabo sit sit dolor tempore id fugiat. Placeat"
                    " ut ducimus et minima beatae autem id qui. Ipsa consequuntur "
                    "necessitatibus ipsa qui laudantium et sequi. Aut alias molestiae "
                    "voluptates consequuntur qui quaerat. Aliquid quidem maxime ut totam "
                    "optio et voluptatum fugit. Odit qui eos voluptatem officiis inventore. "
                    "Aut nam error rerum assumenda.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontWeight: FontWeight.w400, fontSize: 14),),
              ],
            ),
          ),
        )
    );
  }
}
