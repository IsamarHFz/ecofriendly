import 'package:flutter/material.dart';
import 'package:ecofriendly/screens/base_screen.dart';
import 'package:ecofriendly/theme/app_theme.dart';
import 'package:intl/intl.dart';

class TicketDigital extends StatelessWidget {
  final String nombreCliente;
  final String gradoyGrupo;
  final String numeroTelefono;
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final double total;
  final double totalPagado;
  final String metodoPago;
  final String fecha;

  const TicketDigital({
    Key? key,
    required this.nombreCliente,
    required this.gradoyGrupo,
    required this.numeroTelefono,
    required this.items,
    required this.subtotal,
    required this.total,
    required this.totalPagado,
    required this.metodoPago,
    required this.fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return BaseScreen(
      selectedIndex: 0,
      body: SingleChildScrollView(
        // Envuelvo todo el contenido en un SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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

              // Customer details section
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              const Text(
                'Detalles del cliente',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('Nombre del cliente:', nombreCliente),
              _buildInfoRow('Grado y Grupo:', gradoyGrupo),
              _buildInfoRow('Número de teléfono:', numeroTelefono),
              const SizedBox(height: 16),

              // Items section
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              const Text(
                'Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Nombre')),
                    DataColumn(label: Text('Precio')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows:
                      items
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

              // Total info
              _buildInfoRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
              _buildInfoRow('Total', '\$${total.toStringAsFixed(2)}'),
              _buildInfoRow(
                'Total Pagado',
                '\$${totalPagado.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),

              // Payment details
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              Text(
                'Detalles del pago: ${dateFormat.format(DateTime.parse(fecha))} - $metodoPago',
                style: const TextStyle(fontSize: 16, color: AppTheme.textColor),
              ),
              const SizedBox(height: 16),

              // Thank you message
              const Divider(thickness: 2),
              const SizedBox(height: 8),
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

  // Helper method for displaying info rows
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
