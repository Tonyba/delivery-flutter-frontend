import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:delivery_flutter/services/usuario_service.dart';
import 'package:delivery_flutter/theme/colors.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
  final usuarioService = Provider.of<UsuarioService>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
           DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.primaryColor
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${usuarioService.usuario?.nombre ?? ''} ${usuarioService.usuario?.apellido ?? ''}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
               Text(
                  usuarioService.usuario?.correo ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                Text(
                  usuarioService.usuario?.telefono ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 10),
                  child: FadeInImage(
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 50),
                    placeholder: const  AssetImage('assets/img/no-image.png') , 
                    image: usuarioService.usuario?.imagen != null ? NetworkImage(usuarioService.usuario!.imagen!) : const AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                ),
             
              ],
            )
          ),
           ListTile(
              onTap: () => Navigator.pushNamed(context, 'profile'),
              title: const Text('Editar perfil') ,
              trailing: const Icon(Icons.edit_outlined),
          ),
          ListTile(
              onTap: () {},
              title: const Text('Mis pedidos') ,
              trailing: const Icon(Icons.shopping_bag_outlined),
          ),
          usuarioService.usuario != null 
          ?  usuarioService.usuario!.roles.length > 1 
            ? ListTile(
              onTap: () =>  Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false),
              title: const Text('Seleccionar Rol') ,
              trailing: const Icon(Icons.person_outline))
               : const SizedBox()
            : const SizedBox(),
          ListTile(
              onTap: () => usuarioService.logout(context),
              title: const Text('Cerrar Sesion') ,
              trailing: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  static menuDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    return GestureDetector(
      onTap: () {
        scaffoldKey.currentState?.openDrawer();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20,),
      )
    );
  }

}