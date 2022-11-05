-- Inserindo dados na Table E-Commerce

use ecommerce;
show tables;

desc clients;
insert into clients (Fname,Minit,Lname,CPF,Address) 
			values('José','A','Santos', 12345697825, 'rua Quinze de Novembro 942-MT'),
				   ('Rosa','S','Santos',74125896376,'rua Maranhão 61-RJ '),
					('Julia','S','França', 789123456,'rua lareijras 861-MT '),
					 ('Roberta','G','Assis', 98745631,'avenidade koller 19-RJ'),
					  ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28-MT');
                      
 -----------------------------------------------------------                     
insert into product (Pname, classification_kids, category, evaluation, size)
			values('Fones',false,'Eletrônico','4',null),
					('Barbie',true,'Brinquedos','3',null),
						('Revistinha da Turma da Mônica',true,'Brinquedos','5',null),
							('Drone',False,'Eletrônico','4',null),
								('Sofá',False,'Móveis','3','3x57x80'),
									('Flocao de Milho',False,'Alimentos','2',null),
										('Alexa Echo Dot 4ª',False,'Eletrônico','3',null);
                                        
                                        
select * from clients;
select * from product;

-----------------------------------------------------------

insert into orders (idOrdersClient, orderStatus, ordersDescription, shipping, paymentCash) 
			values 	(1, default,'compra via aplicativo',null,1),
						(2,default,'compra via aplicativo',50,0),
							(3,'Confirmado',null,null,1),
								(4,default,'compra via web site',150,0);
                                                             
select * from orders;

-----------------------------------------------------------

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) 
			values	(1,1,2,null),
						(2,1,1,null),
							(3,2,1,'Sem estoque');

select * from productOrder;

-----------------------------------------------------------

insert into productStorage (storageLocation,quantity) 
			values	('Fortaleza',1000),
						('Fortaleza',500),
							('Salvador',10),
								('Salvador',100),
									('Salvador',10),
										('Brasília',60);		
SELECT * FROM productStorage;

 -----------------------------------------------------------    
 
insert into storageLocation (idLproduct, idLstorage, location)
			values	(1,2,'CE'),
						(2,6,'GO');
SELECT * FROM  storageLocation;      
               
 ----------------------------------------------------------- 
 
insert into supplier (SocialName, CNPJ, contact)
			values 	('Almeida e filhos', 123456789123456,'21985474'),
						('Eletrônicos Silva',854519649143457,'21985484'),
							('Eletrônicos Valma', 934567893934695,'21975474');
SELECT * FROM  supplier;                           

 -----------------------------------------------------------  
 
insert into productSupplier (idPsSupplier, idPsProduct, quantity) 
			values	(1,1,500),
						(1,2,400),
							(2,4,633),
								(3,3,5),
									(2,5,10);
 SELECT * FROM  productSupplier; 
 
 ----------------------------------------------------------- 
 
insert into seller (SocialName, AbsName, CNPJ, CPF, location, contact) 
			values	('Tech eletronics', null, 123456789456321, null, 'Fortaleza', 219946287),
						('Botique Durgas',null,null,123456783,'Fortaleza', 219567895),
							('Kids World',null,456789123654485,null,'Salvador', 1198657484);
SELECT * FROM  seller;  

-----------------------------------------------------------

insert into productSeller (idPseller, idPproduct, prodQuantity) 
			values	(1,6,80),
						(2,7,10);
SELECT * FROM  productSeller; 

-----------------------------------------------------------



SELECT COUNT(*) FROM clients; -- Número de Clientes
SELECT * FROM clients c, orders o where c.idClient = idOrdersClient; -- Recuperando pedido de cada Cliente

SELECT Fname,Lname,CPF,idOrders,orderStatus FROM clients c, orders o WHERE c.idClient = idOrdersClient; -- Recuperando colunas especificas das tabelas client e orders

-- Usando a função Concat para unir os nomes e usando o as para nomear as colunas 
SELECT CONCAT(Fname, ' ', Minit,'.', ' ',Lname) as Client, idOrders as Request, orderStatus as Status from clients c, orders o WHERE c.idClient = idOrdersClient;


SELECT * FROM clients c 
				INNER JOIN orders o ON c.idClient = o.idOrdersClient
                INNER JOIN productOrder p ON p.idPOorder = o.idOrders
		GROUP BY idClient; 

-- Número de pedido por cliente
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders FROM clients c 
				INNER JOIN orders o ON c.idClient = o.idOrderSClient
		GROUP BY idClient; 