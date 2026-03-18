# Correccion de cierre del modal final (Submit)

## Hallazgo
- El keyword `Cerrar Modal` hacia click en el boton `#closeLargeModal`, pero no validaba si el modal realmente se cerraba.
- Con esa implementacion, el test podia quedar en `PASS` aunque el modal siguiera abierto (falso positivo).

## Por que podia pasar
- En UI web movil (Appium + Chrome) un `click` no siempre garantiza cambio de estado inmediato.
- Habia solo `Sleep 1s`; si el cierre tardaba o no se ejecutaba correctamente, no existia ninguna asercion para detectarlo.

## Correccion aplicada
- Archivo: `resources/keywords/forms/forms_android_keywords.robot`
- Se reemplazo el `Sleep` por verificacion activa:
  - `Wait Until Keyword Succeeds    10x    500ms    Verificar Modal Cerrado`
- Se agrego keyword:
  - `Verificar Modal Cerrado`
  - Evalua por JS que no exista `.modal.show`
  - Falla el test si el modal sigue abierto.

## Beneficio
- El cierre del modal deja de ser "asumido" y pasa a ser un criterio validado del test.
- Se eliminan falsos `PASS` en el paso final.
