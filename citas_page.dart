import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unadtelemedicina/utils/extensions.dart';
import '../components/app_text_form_field.dart';
import '../models/CitaModel.dart';
import '../values/app_colors.dart';

class CitasPage extends StatefulWidget {
  const CitasPage({super.key});

  @override
  State<CitasPage> createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();

  final todaysDate = DateTime.now();
  late int _dateIndex;
  final double _width = 70;
  final double _margin = 15;
  final _scrollController = ScrollController();

  late int days;
  final List<CitaModel> _tasksList = [
    CitaModel(
        nombre: 'Hola',
        apellido: 'HO',
        desde : DateTime(2022, 03, 16, 12),
        hasta: DateTime(2022, 03, 16, 1),
        area: 'Odontologia',),
  ];

  void getDates() {
    final date = DateTime(todaysDate.year, todaysDate.month);
    days = DateTimeRange(
      start: date,
      end: DateTime(todaysDate.year, todaysDate.month + 1),
    ).duration.inDays;
    _dateIndex = todaysDate.day;

  }

  void _scroll() {
    _scrollController.animateTo(
      (days * _dateIndex.toDouble()) +
          (_dateIndex.toDouble() * _width) -
          (_dateIndex * _margin),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    getDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulario Citas',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,

      ),
      body: _buildBody(context),
    );
  }

SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildDateHeader(context),
            const SizedBox(
              height: 20,
            ),
            _buildDateDays(),
            const SizedBox(
              height: 20,
            ),
            _buildFormCitas(context),
          ],
        ),
      ),
    );
  }

  SizedBox _buildDateHeader(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMMM, dd').format(todaysDate),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Citas pendientes',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),

        ],
      ),
    );
  }

  void _limpiaCampos(){
    nombreController.text = '';
    apellidoController.text = '';
  }

  SizedBox _buildDateDays() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final monthDate =
          DateTime(todaysDate.year, todaysDate.month, index + 1);
          return InkWell(
            onTap: () {
              _dateIndex = index;
              _scroll();
            },
            child: Container(
              width: 350,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: _margin,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: todaysDate.day == (index + 1)
                    ? AppColors.getLinearGradient(Colors.orange)
                    : null,
                borderRadius: BorderRadius.circular(65),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 0.2,
                    //   offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: todaysDate.day == (index + 1)
                            ? Colors.white
                            : null,),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat('EEE').format(monthDate),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: todaysDate.day == (index + 1)
                          ? Colors.white
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _buildFormCitas(BuildContext context) {

    final size = context.mediaQuerySize;

    final doctores=<String>['Doctor 1', 'Doctor 2', 'Doctor 3'];
    final areas=<String>['Odontologia', 'Pediatria', 'Medicina General',
    'Ginecologia', 'Medicina Interna',];

    return SizedBox(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
             Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextFormField(
                    labelText: 'Nombre',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      //_formKey.currentState?.validate();
                    },
                    controller: nombreController,
                  ),
                  AppTextFormField(
                    labelText: 'Apellido',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      //_formKey.currentState?.validate();
                    },
                    controller: apellidoController,
                  ),
                  const SizedBox(
                    height: 30,
                    child: Center(child: Text('Detalle de cita')),
                  ),
                  const Text('Doctor'),
                  DropdownButtonFormField(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    items: doctores.map((e){
                      return DropdownMenuItem(
                        value: e,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                        //
                    },
                    isExpanded: true,
                  ),
                  const Text('Area'),
                  DropdownButtonFormField(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    items: areas.map((e){
                      return DropdownMenuItem(
                        value: e,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {

                    },
                    isExpanded: true,
                  ),
                  FilledButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Agendado!'),
                        ),
                      );
                      _limpiaCampos();
                    },
                    style: const ButtonStyle().copyWith(
                      backgroundColor: MaterialStateProperty.all(
                        _formKey.currentState?.validate() ?? false
                            ? null
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: const Text('Agendar Cita'),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
