// ignore_for_file: file_names, constant_identifier_names

enum SubmitStateEnum{
  EntregaTiempo("Entregado a tiempo"), 
  EntregaRetraso("Entrega con retraso"), 
  NoEntregado("No entregado");

  final String state;
  const SubmitStateEnum(this.state);
}