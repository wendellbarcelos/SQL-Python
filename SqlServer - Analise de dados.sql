-- EXERCITANDO ANÁLISES DE DADOS COM SQL --

-- Exercicio 1. O time comercial presia saber qual a proporção entre clientes pessoa física e clientes
-- pessoa jurídica para dimensionar melhor a equipe de vendas B2C e B2B. Para isso, você precisará fazer
-- um relatório que resuma o total de clientes PF e PJ. Como fazer isso?

SELECT * FROM DimCustomer;

SELECT CustomerType, COUNT(*) Total_clientes
FROM DimCustomer
GROUP BY CustomerType;

-- Ex2. Agora você é um analista de dados que dá suporte à área de RH. Você deverá preparar um relatório 
-- mostrando o total de funcionários para cada departamento, mais também subdividido por sexo.
-- Obs: Tome cuidado com essa análise!

SELECT * FROM DimEmployee;

SELECT DepartmentName, COUNT(*) Qtd_departamento, Gender
FROM DimEmployee
WHERE Status = 'Current'
GROUP BY DepartmentName, Gender
ORDER BY DepartmentName;

-- Ex3. Você é responsavel pelo time de Produtos da empresa e precisa enviar um relatório de controle
-- com o total de produtos para cada marca. Só que o seu gestor quer apenas as marcas que possuem mais que 
-- 200 exemplares de produtos. ??

SELECT * FROM DimProduct;

SELECT BrandName, COUNT(*) Prod_Marca
FROM DimProduct
GROUP BY BrandName
HAVING COUNT(BrandName) > 200
ORDER By Prod_Marca DESC;

-- Ex4. Você é responsavel por controlar os dados de clientes e de produtos da sua empresa. Confirme se:

-- a. Existem 2.517 produtos cadastrados na base e, se não tiver, você deverá reportar ao seu gestor
-- para saber se existe alguma defasagem no controle dos produtos. Quantidade de produtos se mantém

SELECT COUNT(ProductName) Qtd_Produtos FROM DimProduct;

-- b. Até o mês passado, a empresa tinha um total de 19.500 clientes na base de controle. Verifique se
-- esse número aumentou ou reduziu. Quantidade atual reduziu tendo 18.869 clientes

SELECT COUNT(CustomerKey) Qtd_Clientes FROM DimCustomer;

/* Ex5. Você trabalha no setor de marketing da empresa Contoso e acaba de ter uma ideia de oferecer 
descontos especiais para os clientes no dia de seus aniversários. Para isso, você vai precisar
listar todos os clientes e as suas respectivas datas de nascimento, além de um contato. */

--a. Selecione as colunas: CustomerKey, FirstName, EmailAddress, BirthDate da tabela DimCustomer
--b. Renomeie as colunas dessa tabela usando o alias 

SELECT CustomerKey AS 'Id_Cliente', 
	FirstName AS 'Primeiro_Nome', 
	EmailAddress AS 'Email_Cliente', 
	BirthDate AS 'Data_Nascimento'
FROM DimCustomer;


/* Ex6. A Contoso está comemorando aniversário de inauguração de 10 anos e pretende fazer uma ação de 
premiação para os clientes. A empresa quer presentear os primeiros clientes desde a inauguração. Você
foi alocado para levar adiante essa ação, para isso você terá que fazer o seguinte:

A Contoso decidiu presentear os primeiros 100 clientes da história com um vale compras de R$ 10.000.
Utilize um comando em SQL para retornar uma tabela com os primeiros 100 clientes da tabela DimCustomers */

SELECT TOP(100) * FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY DateFirstPurchase;

/* Ex7. A empresa Contoso precisa fazer contato com os fornecedores de produtos para repor o estoque.
Você é da área de compras e precisa descobrir quem são esses fornecedores.

Retorne apenas os nomes dos fornecedores na tabela DimProduct e renomeie essa nova coluna da tabela */

SELECT DISTINCT(Manufacturer) Fabricantes FROM DimProduct;

/* Ex8. O seu trabalho de investigação não para. Você precisa descobrir se existe algum
produto registrado na base de produtos que ainda não tenha sido vendido. Tente chegar
nessa informação */ 

SELECT COUNT(DISTINCT ProductKey) AS Qtd_Vendida FROM FactSales
-- Tem apenas um produto não vendido necessário invistigar mais afundo

-- Ex A Empresa gostaria de presentear todas as clientes que moram na Europa para lhes 
-- e sejam acima de 40 anos, porem esta no mês das mulheres com a letra M. 
-- Usando a função Datediff para criar a coluna idade e usado no Where

SELECT DISTINCT CONCAT(FirstName,' ', LastName) AS Nome_Cliente,  
	Gender AS Sexo,
	BirthDate AS Data_Nascimento,
	DATEDIFF(YEAR, BirthDate,'2023/06/22' ) AS Idade,
	ContinentName AS Continente,
	EmailAddress AS Email,
	DateFirstPurchase AS Primeira_Compra
FROM DimCustomer, DimGeography
WHERE Gender = 'F' AND (DATEDIFF(YEAR, BirthDate,'2023/06/22' ) BETWEEN 40 AND 45) AND FirstName LIKE 'M%' AND ContinentName = 'Europe';

-- Ex. A o setor financeiro necessita das projeções das vendas do mês de Jan a Mar
-- solicitando a quant vendida, total de vendas e custo, e o lucro

-- Base de dados muito grande
SELECT TOP(1000)
	ROUND(SUM(UnitCost), 2) AS Preco_Custo_Un, 
	ROUND(SUM(UnitPrice), 2) AS Preco_Venda_Un, 
	SUM(SalesQuantity) AS Qtd_Vendas,
	AVG(SalesQuantity) AS Media_Vendas,
	SUM(TotalCost) AS Total_Custo, 
	ROUND(SUM(SalesAmount), 2) AS Total_Vendas,
	ROUND(SUM(SalesAmount - TotalCost), 2) AS Lucro	
FROM FactSales;  
-- buscar forma de trazer os valores por periodo

-- O setor comercial solicitou a quantidade de clientes de cada país. O resultado deverá
-- ter o nome do país e a quantidade de clientes em ordem decrescente de número de clientes

SELECT RegionCountryName AS Paises, COUNT(FirstName) AS Qtd_Clientes 
FROM DimCustomer, DimGeography
WHERE RegionCountryName IS NOT NULL
GROUP BY RegionCountryName
ORDER BY Qtd_Clientes DESC


-- Usando duas tabelas, idealizando consulta
SELECT 
	CONCAT(FirstName,' ', LastName) AS NomeCliente,
	BirthDate AS Data_Nasc,
	Occupation AS Profissao,
	AddressLine1 AS Endereco,
	CityName AS Nome_Cidade, 
	RegionCountryName AS Nome_Pais 
FROM DimCustomer, DimGeography
WHERE RegionCountryName IS NOT NULL AND CityName IS NOT NULL