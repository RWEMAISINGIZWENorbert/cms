import 'package:flutter/material.dart';
import 'package:tech_associate/components/forms/sig_in_form.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   colors: const <Color>[
          //     Color.fromRGBO(207, 102, 9, 1),
          //     Color.fromARGB(255, 235, 142, 3),
          //     Color.fromRGBO(180, 136, 25, 1),
          // ])
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Login\n',  style: TextStyle(
                       color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600
                    ),
                    ),
                    TextSpan(text: 'Welcome',  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                    ),
                    ),
                  ]
                   )
                  ),
                ),
                // const SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),
                 child: Container(
                  margin: const EdgeInsets.only(top: 120),
                  child: const Center(
                     child: SigInForm(),
                  ) 
                  ), 
                ),           
               ),
             ]
           )
          )
         )
        )
        );
  }
}