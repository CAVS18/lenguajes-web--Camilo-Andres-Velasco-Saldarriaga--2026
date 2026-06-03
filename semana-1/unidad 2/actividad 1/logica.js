
const libros = [
    { titulo: "El Aleph", autor: "Borges", ventas: 500, stock: 10 },
    { titulo: "Rayuela", autor: "Cortázar", ventas: 1200, stock: 2 },
    { titulo: "Ficciones", autor: "Borges", ventas: 850, stock: 5 },
    { titulo: "100 años de soledad", autor: "García Márquez", ventas: 3000, stock: 0 },
];

// 1. Títulos con más de 1.000 ventas
const masVendidos = libros
    .filter(libro => libro.ventas > 1000)
    .map(libro => libro.titulo);
// → ["Rayuela", "100 años de soledad"]

// 2. Sumatoria de ventas de Borges
const ventasBorges = libros
    .filter(libro => libro.autor === "Borges")
    .reduce((acc, libro) => acc + libro.ventas, 0);
// → 1350

// 3. Catálogo con disponibilidad, ordenado descendente
const catalogo = libros
    .map(libro => ({
        titulo: libro.titulo,
        estado: libro.stock > 0 ? "Disponible" : "Agotado",
        ventas: libro.ventas
    }))
    .sort((a, b) => b.ventas - a.ventas);