class CuentaBancaria {
  #saldo;
  #titular;

  constructor(titular, saldoInicial = 0) {
    if (saldoInicial < 0) {
      throw new Error('Saldo inicial no puede ser negativo');
    }
    if (!titular?.trim()) {
      throw new Error('El titular es obligatorio');
    }
    this.#titular = titular.trim();
    this.#saldo  = saldoInicial;
  }

  get titular() { return this.#titular; }
  get saldo()   { return this.#saldo;   }

  depositar(monto) {
    this.#validarMonto(monto);
    this.#saldo += monto;
    return this.#saldo;
  }

  retirar(monto) {
    this.#validarMonto(monto);
    if (monto > this.#saldo) {
      throw new Error('Fondos insuficientes');
    }
    this.#saldo -= monto;
    return this.#saldo;
  }

  #validarMonto(monto) {
    if (typeof monto !== 'number' || isNaN(monto))
      throw new Error('Monto debe ser un número');
    if (monto <= 0)
      throw new Error('Monto debe ser mayor a cero');
  }
}

class CuentaAhorro extends CuentaBancaria {
  #tasaInteres;
  constructor(titular, saldo, tasa = 0.03) {
    super(titular, saldo);
    this.#tasaInteres = tasa;
  }
  aplicarInteres() {
    const interes = this.saldo * this.#tasaInteres;
    this.depositar(interes);
    return interes;
  }
}

class CuentaCorriente extends CuentaBancaria {
  #limiteDescubierto;
  constructor(titular, saldo, limite = 500) {
    super(titular, saldo);
    this.#limiteDescubierto = limite;
  }
  retirar(monto) {
    if (monto > this.saldo + this.#limiteDescubierto)
      throw new Error('Supera límite de descubierto');
    return super.retirar(monto);
  }
}

class CuentaEmpresarial extends CuentaBancaria {
  #limiteTransaccion;
  constructor(titular, saldo, limite = 50000) {
    super(titular, saldo);
    this.#limiteTransaccion = limite;
  }
  depositar(monto) {
    if (monto > this.#limiteTransaccion)
      throw new Error(`Supera límite por transacción`);
    return super.depositar(monto);
  }
}