-- Criação de BD de E-Commerce
create database ecommerce;
-- drop database ecommerce;
use ecommerce;
show tables;

-- Criando tabela clientes
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    Ctype enum('PF','PJ') default 'PF',
	
);
desc clients;

alter table clients auto_increment=1;

create table clientsPf(
	idClientPf int auto_increment primary key,
	CPF char(11) not null,
    Address varchar(255)
);
create table clientsPj(
	idClientPj int auto_increment primary key,
    CNPJ char(15) not null,    
);



-- Criando tabela produtos
-- size = dimenssão do produto / evaluation =  avaliação
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(255) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestuario','Brinquedos','Alimentos','Móveis') not null,
    evaluation float default 0,
    size varchar(10)
);
desc product;

-- Tabela de Pagamentos
create table payments(
	idClients int,
    idPayments int,
    typePayment enum('Boleto','Cartão','Outro Cartão'),
    limitAvaliable float,
   
    primary key (idClients, idPayments),
    constraint fk_payment_client foreign key (idClients) references clients(idClient)
);


-- Criando tabela pedidos
-- shipping =  frete por default ele é 10, quer dizer que o frete é no minimo 10
create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
    orderStatus enum ('Cancelado', 'Confirmado','Em processamento') default 'Em processamento',
    ordersDescription varchar(255),
    shipping float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrdersClient) references clients(idClient)
			on update cascade
);
desc orders;

-- Criando tabela Estoque
create table productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(45),
    quantity int default 0
);

-- Criando tabela Fornecedor
-- supplier = fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(45) not null,
    CNPJ char(15) not null,
    contact varchar(11) not null,
    constraint unique_supplier unique(CNPJ)    
);
desc supplier;

-- Criando tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
	location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
);

-- Criando tabela gerada da relação das tabelas produto e vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
	primary key(idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- Tabela de relação produto e pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_order_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_order_order foreign key (idPOorder) references orders(idOrders)

);


-- Tabela relação estoque e produto
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
	primary key(idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
desc productSupplier;
use information_schema;
show tables;

desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
