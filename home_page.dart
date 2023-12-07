import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unadtelemedicina/values/app_colors.dart';

import '../widgets/cita_group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final user = arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Telemedicina - Ubaté',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,

      ),
      extendBody: true,
      body: _buildBody(user),
    );
  }

  Stack _buildBody(String user) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _taskHeader(user),
                const SizedBox(
                  height: 15,
                ),
                PanelGrid(user),
                const SizedBox(
                  height: 25,
                ),
                _ProximasCitasHeader(),
                const SizedBox(
                  height: 10,
                ),
                const ProximasCitas(),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _ProximasCitasHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Citas agendadas:',
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Text(
            'Ver todas',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Row _taskHeader(String user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          'Hola $user',
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
      ],
    );
  }

  StaggeredGrid PanelGrid(String user) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: CitasGroupContainer(
            color: Colors.pink,
            icon: Icons.menu_book_rounded,
            taskCount: 0,
            taskGroup: 'Agendar Cita',
            ruta: '/citas',
            usuario: user,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: CitasGroupContainer(
            color: Colors.orange,
            icon: Icons.phone,
            taskCount: 0,
            taskGroup: 'Conferencia',
            ruta: '/conferencia',
            usuario: user,
          ),
        ),
      ],
    );
  }
}

class ProximasCitas extends StatelessWidget {
  const ProximasCitas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    width: MediaQuery.of(context).size.width*0.95,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.access_time, size: 8,),
        const SizedBox(width: 10),
        SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Odontologia 12:30pm-1:30pm 28/11/2023',
                style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'General 3:30pm-4:30pm 29/11/2023',
                style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),

      ],
    ),
    );
  }
}


