-- Criação de BD de E-Commerce
create database oficina;

use oficina;
show tables;


-- Criando tabela clientes
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(45),
    Minit char(45),
    Lname varchar(45),
    Phone varchar(45),
   Address varchar(255)
);


-- Criando tabela Veiculo
create table vehicle(
	idClients int,
	idVehicle int,
    primary key (idClients, idVehicle),
    constraint fk_vehicle_client foreign key (idClients) references clients(idClient)
);