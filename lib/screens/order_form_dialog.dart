import 'package:flutter/material.dart';

class OrderFormDialog extends StatefulWidget {
  final void Function(String nombre, String grado, String telefono) onSubmit;

  const OrderFormDialog({super.key, required this.onSubmit});

  @override
  State<OrderFormDialog> createState() => _OrderFormDialogState();
}

class _OrderFormDialogState extends State<OrderFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String grado = '';
  String telefono = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Formulario de pedido'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              onSaved: (value) => nombre = value ?? '',
              validator: (value) => value!.isEmpty ? 'Ingresa tu nombre' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Grado y grupo'),
              onSaved: (value) => grado = value ?? '',
              validator:
                  (value) => value!.isEmpty ? 'Ingresa grado y grupo' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Número de teléfono',
              ),
              keyboardType: TextInputType.phone,
              onSaved: (value) => telefono = value ?? '',
              validator:
                  (value) => value!.isEmpty ? 'Ingresa tu teléfono' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.pop(context);
              widget.onSubmit(nombre, grado, telefono);
            }
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
