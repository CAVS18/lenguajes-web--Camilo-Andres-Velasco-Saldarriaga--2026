1. Mecanismo de Hoisting

El hoisting es un comportamiento del motor de JavaScript mediante el cual las declaraciones de variables y funciones son registradas en memoria durante la fase de compilación antes de ejecutar el código.
Cuando se declara una variable con var, el motor:

Reserva espacio en memoria para la variable.
La inicializa automáticamente con el valor undefined.
Posteriormente ejecuta las instrucciones del programa.

permite el accesso previo a su inicializacion porque la variable ya existe en memoria desde el inicio de la ejecución del contexto. Aunque la asignación del valor aún no ha ocurrido, la referencia ya fue creada con el valor inicial undefined.

Desde una perspectiva de seguridad y calidad del software, este comportamiento puede generar estados ambiguos en la aplicación, ya que una variable puede existir en memoria sin contener aún la información esperada. Esto puede provocar errores lógicos, validaciones incorrectas, comportamientos inesperados y dificultades durante las tareas de mantenimiento y depuración. Por esta razón, las prácticas modernas de desarrollo recomiendan utilizar let y const, impidiendo el acceso a la variable antes de su inicialización.

---------------------------------------------------------------------------------------------
2. Coerción de Tipos

La coerción de tipos es el proceso mediante el cual JavaScript convierte automáticamente un valor de un tipo de dato a otro cuando una operación requiere compatibilidad entre ellos. Este comportamiento es una consecuencia del sistema de tipificación dinámica y débil del lenguaje.
Al evaluar la expresión [] == ![], el motor ejecuta una serie de conversiones implícitas definidas por la especificación ECMAScript. Primero evalúa el operador lógico de negación, posteriormente convierte valores booleanos a números cuando interviene la comparación abstracta, y finalmente transforma el arreglo en un valor primitivo antes de continuar con la comparación. El resultado final se obtiene después de varias conversiones sucesivas realizadas automáticamente por el motor.
Para mitigar los problemas, se debe utilizar operadores de igualdad estricta, realizar conversiones explícitas cuando sean necesarias, adoptar herramientas de análisis estático y emplear sistemas de tipado como TypeScript. Esto reduce la dependencia de las conversiones automáticas y mejoran la robustez del software.
---------------------------------------------------------------------------------------------
3. Gestión de Estados Nulos
El valor undefined indica que una propiedad no ha sido definida, no existe dentro de una estructura de datos o aún no se le ha asignado ningún valor. Generalmente representa la ausencia de información desde el punto de vista técnico del sistema.
Null representa una ausencia de valor intencional y explícitamente establecida. Su uso comunica que el atributo forma parte del modelo de datos, pero que actualmente no posee información asociada.
En el contexto del modelado de libros, el criterio recomendado consiste en utilizar undefined cuando la información aún no ha sido registrada o la propiedad no forma parte de los datos disponibles, mientras que null debe emplearse cuando la propiedad existe conceptualmente dentro del modelo pero carece temporalmente de un valor. Esta diferenciación mejora la claridad semántica, facilita las validaciones, optimiza la interoperabilidad con APIs y reduce la probabilidad de errores durante el procesamiento de datos.