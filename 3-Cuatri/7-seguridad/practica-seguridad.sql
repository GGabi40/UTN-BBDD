# 1. Cree un usuario llamado sakila_local_user que tenga todos los privilegios
# sobre la base de datos sakila. Tenga en cuenta que el usuario
# sakila_local_user sólo podrá conectarse desde la máquina local.

use sakila;
CREATE USER 'sakila_local_user'@'localhost' IDENTIFIED BY '1234'; 

GRANT ALL PRIVILEGES ON sakila.* TO 'sakila_local_user'@'localhost';
flush privileges;


# 2. Cree un usuario llamado sakila_remote_user que tenga todos los privilegios
# sobre la base de datos sakila y que pueda conectarse desde cualquier máquina.

CREATE USER 'sakila_remote_user'@'%' IDENTIFIED BY '4321'; 
GRANT ALL PRIVILEGES ON sakila.* TO 'sakila_remote_user'@'%';


# 3. Cree un usuario llamado sakila_local_user que tenga todos los privilegios
# sobre la base de datos sakila. Tenga en cuenta que el usuario
# sakila_local_user sólo podrá conectarse desde la máquina local.


