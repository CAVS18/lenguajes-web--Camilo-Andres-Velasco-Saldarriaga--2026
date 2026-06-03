function crearSistemaSeguridad(claveInicial) {

  // Variable privada — atrapada en el ámbito de la clausura,
  // completamente inaccesible desde el exterior
  let _clave = claveInicial;
  let _intentosFallidos = 0;
  const MAX_INTENTOS = 3;

  // Interfaz pública — lo único que escapa al exterior
  return {

    validarClave(claveIngresada) {
      if (_intentosFallidos >= MAX_INTENTOS) {
        return { ok: false, mensaje: "Sistema bloqueado por exceso de intentos." };
      }

      const esValida = claveIngresada === _clave;

      if (esValida) {
        _intentosFallidos = 0;
        return { ok: true, mensaje: "Acceso concedido." };
      } else {
        _intentosFallidos++;
        const restantes = MAX_INTENTOS - _intentosFallidos;
        return {
          ok: false,
          mensaje: restantes > 0
            ? `Clave incorrecta. Intentos restantes: ${restantes}.`
            : "Sistema bloqueado. Contacte al administrador."
        };
      }
    },

    cambiarClave(claveActual, nuevaClave) {
      if (_intentosFallidos >= MAX_INTENTOS) {
        return { ok: false, mensaje: "Sistema bloqueado. No se puede cambiar la clave." };
      }

      if (claveActual !== _clave) {
        _intentosFallidos++;
        return { ok: false, mensaje: "Clave actual incorrecta." };
      }

      if (!nuevaClave || nuevaClave.length < 4) {
        return { ok: false, mensaje: "La nueva clave debe tener al menos 4 caracteres." };
      }

      _clave = nuevaClave;
      _intentosFallidos = 0;
      return { ok: true, mensaje: "Clave actualizada correctamente." };
    },

    desbloquear(claveAdmin) {
      // Simula una clave maestra de administrador (también privada)
      if (claveAdmin === "ADMIN_MASTER") {
        _intentosFallidos = 0;
        return { ok: true, mensaje: "Sistema desbloqueado." };
      }
      return { ok: false, mensaje: "Clave de administrador inválida." };
    },

    obtenerEstado() {
      return {
        bloqueado: _intentosFallidos >= MAX_INTENTOS,
        intentosFallidos: _intentosFallidos,
        intentosRestantes: Math.max(0, MAX_INTENTOS - _intentosFallidos)
      };
      // Nota: _clave nunca se expone aquí
    }
  };
}

// --- Uso ---
const sistema = crearSistemaSeguridad("abc123");

console.log(sistema.validarClave("wrongpass")); // { ok: false, mensaje: "Clave incorrecta. Intentos restantes: 2." }
console.log(sistema.validarClave("abc123"));    // { ok: true,  mensaje: "Acceso concedido." }
console.log(sistema.cambiarClave("abc123", "xyz789")); // { ok: true, mensaje: "Clave actualizada correctamente." }
console.log(sistema.validarClave("abc123"));    // { ok: false, ... } — la clave vieja ya no sirve
console.log(sistema.validarClave("xyz789"));    // { ok: true,  mensaje: "Acceso concedido." }

// Intento de acceso directo a la variable privada → undefined
console.log(sistema._clave); // undefined