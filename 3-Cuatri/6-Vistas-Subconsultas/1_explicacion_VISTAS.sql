# Gestión de Vistas y Subconsultas en MySQL

-- Vistas: ventana a los datos de una tabla.
--  Contienenfilas y columnas pero no almacenan físicamente los datos.

# CREATE OR REPLACE VIEW nombre_vista (columna1, columna2) AS consulta_select;

# SELECT * FROM nombre_vista; --> para ver la consulta
# DROP VIEW IF EXISTS nombre_vista; --> para dropear la vista
# ALTER VIEW nombre_vista AS nueva_consulta; --> para modificarla

-- Una vista es actualizabla cuando se pueden realizar INSERT, UPDATE, DELETE.


# CREATE OR REPLACE VIEW nombre_vista (columna1, columna2) 
# AS consulta_select 
# WHERE id = d_id
# WITH CHECK OPTION; -> Verifica si cumple o no el WHERE