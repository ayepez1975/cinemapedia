import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

   

   Stream<String> getloadingMessage(){
    const  messages =<String>[
    'Cargando peliculas',
    'Comprando palomitas de maìz'
    'Cargando populares',
    'Cargando ',
    'Cargando màs ..... :('
   ];


    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }
    ).take(messages.length);
   }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text('Espere por favor..'),
      const SizedBox( height: 15,),
      const CircularProgressIndicator(),
      const SizedBox( height: 15,),
      StreamBuilder(
        stream: getloadingMessage(),
        
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if( !snapshot.hasData)  return const Text('Cargando... ');

            return Text(snapshot.data);

          
        },
      ),

    ],),);
  }
}
