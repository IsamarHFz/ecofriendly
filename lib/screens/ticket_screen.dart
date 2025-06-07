import 'package:flutter/material.dart';
import 'package:ecofriendly/services/email_service.dart';
import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoFriendly',
      debugShowCheckedModeBanner: false,
      home: const FormularioCompra(),
    );
  }
}

class FormularioCompra extends StatefulWidget {
  const FormularioCompra({Key? key}) : super(key: key);

  @override
  State<FormularioCompra> createState() => _FormularioCompraState();
}

class _FormularioCompraState extends State<FormularioCompra> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final gradoController = TextEditingController();
  final telefonoController = TextEditingController();
  String? tallaSeleccionada;
  final List<String> tallasDisponibles = ['M', 'G'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Compra')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: gradoController,
                decoration: const InputDecoration(labelText: 'Grado y Grupo'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Selecciona tu talla',
                  border: OutlineInputBorder(),
                ),
                value: tallaSeleccionada,
                items:
                    tallasDisponibles
                        .map(
                          (talla) => DropdownMenuItem(
                            value: talla,
                            child: Text(talla),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => tallaSeleccionada = value),
                validator:
                    (value) => value == null ? 'Selecciona una talla' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TicketDigital(
                              nombreCliente: nombreController.text,
                              emailCliente: emailController.text,
                              gradoyGrupo: gradoController.text,
                              numeroTelefono: telefonoController.text,
                              talla: tallaSeleccionada!,
                              items: [
                                {
                                  'nombre': 'Playera Eco',
                                  'precio': 150.0,
                                  'total': 150.0,
                                },
                              ],
                              subtotal: 150.0,
                              total: 150.0,
                              totalPagado: 150.0,
                              metodoPago: 'Efectivo',
                              fecha: DateTime.now().toIso8601String(),
                            ),
                      ),
                    );
                  }
                },
                child: const Text('Generar Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🌿 TICKET DIGITAL
class TicketDigital extends StatefulWidget {
  final String nombreCliente;
  final String emailCliente;
  final String gradoyGrupo;
  final String numeroTelefono;
  final String talla;
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final double total;
  final double totalPagado;
  final String metodoPago;
  final String fecha;

  const TicketDigital({
    Key? key,
    required this.nombreCliente,
    required this.emailCliente,
    required this.gradoyGrupo,
    required this.numeroTelefono,
    required this.talla,
    required this.items,
    required this.subtotal,
    required this.total,
    required this.totalPagado,
    required this.metodoPago,
    required this.fecha,
  }) : super(key: key);

  @override
  State<TicketDigital> createState() => _TicketDigitalState();
}

class _TicketDigitalState extends State<TicketDigital> {
  @override
  void initState() {
    super.initState();
    _enviarCorreo();
  }

  void _enviarCorreo() {
    final mensaje = '''
Se ha generado una nueva compra.

Cliente: ${widget.nombreCliente}
Grado y Grupo: ${widget.gradoyGrupo}
Teléfono: ${widget.numeroTelefono}
Talla: ${widget.talla}
Total Pagado: \$${widget.totalPagado.toStringAsFixed(2)}
Método de Pago: ${widget.metodoPago}
Fecha: ${widget.fecha}

Productos:
${widget.items.map((item) => '- ${item['nombre']}: \$${(item['total'] as double).toStringAsFixed(2)}').join('\n')}
''';

    sendEmail(widget.nombreCliente, 'compras@ecofriendly.com', mensaje);

    if (widget.emailCliente.trim().isNotEmpty) {
      sendEmail(widget.nombreCliente, widget.emailCliente, mensaje);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return BaseScreen(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Eco-Friendly',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const Text(
                'M. Hidalgo',
                style: TextStyle(fontSize: 16, color: AppTheme.textColor),
              ),
              const Text(
                '90460 Xaloztoc, Tlaxcala',
                style: TextStyle(fontSize: 16, color: AppTheme.textColor),
              ),
              const Text(
                'México',
                style: TextStyle(fontSize: 16, color: AppTheme.textColor),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 2),
              const Text(
                'Detalles del cliente',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              _buildInfoRow('Nombre del cliente:', widget.nombreCliente),
              _buildInfoRow('Correo electrónico:', widget.emailCliente),
              _buildInfoRow('Grado y Grupo:', widget.gradoyGrupo),
              _buildInfoRow('Número de teléfono:', widget.numeroTelefono),
              _buildInfoRow('Talla:', widget.talla),
              const SizedBox(height: 16),
              const Divider(thickness: 2),
              const Text(
                'Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Nombre')),
                    DataColumn(label: Text('Precio')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows:
                      widget.items
                          .map(
                            (item) => DataRow(
                              cells: [
                                DataCell(Text(item['nombre'])),
                                DataCell(
                                  Text(
                                    '\$${(item['precio'] as double).toStringAsFixed(2)}',
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '\$${(item['total'] as double).toStringAsFixed(2)}',
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Subtotal',
                '\$${widget.subtotal.toStringAsFixed(2)}',
              ),
              _buildInfoRow('Total', '\$${widget.total.toStringAsFixed(2)}'),
              _buildInfoRow(
                'Total Pagado',
                '\$${widget.totalPagado.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 2),
              Text(
                'Detalles del pago: ${dateFormat.format(DateTime.parse(widget.fecha))} - ${widget.metodoPago}',
                style: const TextStyle(fontSize: 16, color: AppTheme.textColor),
              ),
              const Divider(thickness: 2),
              const Text(
                '¡Gracias por su compra!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: AppTheme.textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
