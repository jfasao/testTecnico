# testTecnico
Trabajo de Test técnico para consultora MAvha Tech Challenge

Se desarrollo aplicacion para el alta de tareas/Todo al cula se le pueden asociar uno o mas archivos, ademas de asignarle un estado 

Se adjunta diagrama de clases en archivo todos.png

se utilizo para el desarrollo las siguientes herramientas:

      ECLIPSE PHOTOM
      TOMCAT 8.5.5
      MYSQL 10.1.34 MARIADB
      
Para el desarrollo se utilizaron las siguientes tecnologias:
  
      STRUTS2 2.3.34
      SPRIG 3.0.5
      HIBERNET 3.3.31
      JAVA 1.8
      EXTJS 3
      STRUTS2-REST-PLUGIN 2.3.34 (EXPORTAR API REST)
      MAVEN4
      JASPERREPORTS 3.0


Configuraciones

Se deben agregar en el archivo context de la configuracion del tomcat (ruta {path_tomcat}\conf\context.xml) lo siguiente:
                   <ResourceLink name="jdbc/testTecnico"
                      global="jdbc/testTecnico"
                      auth="Container"
                      type="javax.sql.DataSource" />  
                      
Asimismo Se deben agregar en el archivo server de la configuracion del tomcat (ruta {path_tomcat}\conf\server.xml) lo siguiente:
                        <Resource 
                              auth="Container" 
                              driverClassName="com.mysql.jdbc.Driver" 
                              maxIdle="30" 
                              maxTotal="100" 
                              maxWaitMillis="10000" 
                              name="jdbc/testTecnico" 
                              password="testTecnico" 
                              type="javax.sql.DataSource" 
                              url="jdbc:mysql://localhost:3306/test" 
                              username="test"/>

La aplicacion quedo configurada para que una vez conectada a la base de datos cree las tablas necesarias para operar, se deben dar permisos al usuario de base test para poder crear, update,insert y drop en la base.

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER ON *.* TO 'test'@'localhost' IDENTIFIED BY PASSWORD '*5B8BF3391F2A5275667A89E8E39F589ED8011281' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `test`.* TO 'test'@'localhost' WITH GRANT OPTION;


La aplicacion web corre en la siguiente url: http://localhost:8080/test/

se ingresa con el usuario:falcalde
                  clave:1234
 
 La Api Rest corre en la url: http://localhost:8080/test/api/todo/
 
 Se publicaron servicios GET, pudieno filtrar por id, descripcion y estado (descripcion) usando query params
 
  Metodo POST aceptando datos por query params, como por json en el body del request, se deben setear el content-Type aplication/json, acepta parametros id, descripcion, estadoId.
  
 Tambien se publico metodo PUT aceptando datos por query params, como por json en el body del request, se deben setear el content-Type aplication/json, acepta parametros id, descripcion, estadoId.
 
 Metodo DELETE, se debe indicar el id a eliminar.
 
 Se realizo reporte que imprime el listado de Todos, solo para mostrar la posibilidad de usar jasperreports, herramienta muy facil de operar para reportes a cualquier formato (html, excel, word, etc)
 
 
 
 

 
 
 



