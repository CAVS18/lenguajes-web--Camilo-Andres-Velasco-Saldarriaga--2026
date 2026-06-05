retirar(monto) {
  const saldoTras = this.saldo - monto;
  if (saldoTras < this.#umbralMinimo)
    throw new Error(`Saldo remanente ($${saldoTras.toFixed(2)}) quedaría bajo el umbral mínimo`);
  return super.retirar(monto); // delega validación de monto a la clase base
}
const enSobregiro = Math.max(0, -saldoTras);   // rojo resultante
const prevRojo    = Math.max(0, -this.saldo);   // rojo previo (si ya estaba sobregirado)
const montoEnRojo = enSobregiro - prevRojo;     // nueva deuda generada en esta operación

if (montoEnRojo > 0) {
  const comision = +(montoEnRojo * this.#tasaComision).toFixed(2);
  this._ajustarSaldo(-monto - comision); // retiro + comisión se descuentan juntos
}