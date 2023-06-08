#1

  Scenario: Validar modificacion de "Valor comercial"

  Given que se tiene un aviso en estado <estado>
  When el usuario ingresa a la pantalla "Crud" desde el boton "Ir"
  Then siste muestra el valor comercial asociado al vehiculo en el campo "Valor comercial"



  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
