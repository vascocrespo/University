No ficheiro application.properties localizado na pasta src/main/resources e necessario alterar os dados da base de dados para a base de dados postgresql à escolha
Alterar tambem neste ficheiro o valor de "spring.jpa.hibernate.ddl-auto" para "create-drop" da primeira vez que corremos o programa para criar as tabelas 
e para "update" depois disso para apenas alterar os valores da base de dados


para compilar o programa
mvn install

para iniciar a web app
java -jar target/Trabalho2-0.0.1-SNAPSHOT.jar