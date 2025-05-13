# Mapeo de Objetos Relacional (ORM)

-- Es una herramienta de software que actúa como un puente
-- entre un lenguaje de programacion Orientado a Obj y una BBDD relacional.

-- Tiene como objetivo permitir a los devs interactuar con la bbdd
-- utilizando objetos y clases de lenguaje de programación preferido,
-- en lugar de escribir sentencias SQL directamente.

-- Crea una "bbdd virtual" orientada a objetos.


## Data Access Object (utiliza DTO - Data Transfer Object)
-- es un patrón de diseño que permite separar tanto nuestra lógica de negocio 
-- de aquella implicada en el acceso a una bbdd, el patrón DAO (Data Access Object).
-- Resuelve el problema de desajuste e impedancia (se refiere a las 
-- diferencias fundamentales entre el paradigma orientado a objetos y el
-- paradigma relacional).


## Los ORM se basan en:
-- Mapeo: proceso que define estructura de bbdd.
-- Abstracción


## Ventajas del ORM
-- Desarrollo + rápido: Se escribe menos código, especialmente repetitivo.
-- Se reduce la posibilidad de errores de sintaxis SQL.

-- Abstracción de BBDD: se encarga de generar código SQL específico 
-- para nuestro motor. Le da una independencia y también facilita la migración.

-- Reducción de código SQL manual.

-- Seguridad mejorada: ayudan a prevenir vulnerabilidades comunes 
-- como la inyección SQL.

-- Mantenibilidad del código: al centralizar la lógica de acceso a 
-- datos, tiende a ser más organizado, legible y fácil de mantener.

-- Caract avanzadas integradas: posee funcionalidades adicionales 
-- como gestión de transacciones, pooling de conexiones, lazy loading 
-- de datos relacionados y herramientas de migración de esquemas.


## Posibles desventajas:
-- Curva de aprendizaje: cada ORM tiene su propia API, 
-- convenciones y complejidades. Aprender un ORM de manera 
-- efectiva, puede llevar tiempo y esfuerzo.

-- Rendimiento: Introucen una capa de abstracción adicional, lo que 
-- puede llevar a una sobrecarga de rendimiento en comparación
-- con el SQL escrito a mano y optimizado por un experto.

-- Complejidad: la abstracción puede ocultar lo que realmente está
-- sucediendo con la BBDD. Puede dificultar la depuración de problemas
-- de rendimiento o la comprensión del SQL exacto.

-- Dificultad para optimizar consultas complejas.

-- Dependencia del ORM: aunque promueven la independencia del motor de bbdd,
-- la aplicación se vuelve dependiente del ORM específico utilizado.
-- Cambiar de un ORM a otro puede requerir unan refactorización significativa
-- del código de acceso a datos.

-- Posible sobrecarga de recursos.

-- Abstracción con Fugas (Leaky Abstraction): a pesar de la abstracción,
-- a veces es necesario entender los detalles de SQL y del comportamiento
-- de la bbdd para usar el ORM de manera efectiva.


# ORM -> SQLAlchemy (Python)
-- Es una de las bibliotecas de acceso a bbdd de Python.
-- Posee un sistema que permite escribir consultas con python.
