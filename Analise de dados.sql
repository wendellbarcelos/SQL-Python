-- EXERCITANDO AN�LISES DE DADOS COM SQL --

-- Exercicio 1. O time comercial presia saber qual a propor��o entre clientes pessoa f�sica e clientes
-- pessoa jur�dica para dimensionar melhor a equipe de vendas B2C e B2B. Para isso, voc� precisar� fazer
-- um relat�rio que resuma o total de clientes PF e PJ. Como fazer isso?

SELECT * FROM DimCustomer;

SELECT CustomerType, COUNT(*) Total_clientes
FROM DimCustomer
GROUP BY CustomerType;

-- Ex2. Agora voc� � um analista de dados que d� suporte � �rea de RH. Voc� dever� preparar um relat�rio 
-- mostrando o total de funcion�rios para cada departamento, mais tamb�m subdividido por sexo.
-- Obs: Tome cuidado com essa an�lise!

SELECT * FROM DimEmployee;

SELECT DepartmentName, COUNT(*) Qtd_departamento, Gender
FROM DimEmployee
WHERE Status = 'Current'
GROUP BY DepartmentName, Gender
ORDER BY DepartmentName;

-- Ex3. Voc� � responsavel pelo time de Produtos da empresa e precisa enviar um relat�rio de controle
-- com o total de produtos para cada marca. S� que o seu gestor quer apenas as marcas que possuem mais que 
-- 200 exemplares de produtos. ??

SELECT * FROM DimProduct;

SELECT BrandName, COUNT(*) Prod_Marca
FROM DimProduct
GROUP BY BrandName
HAVING COUNT(BrandName) > 200
ORDER By Prod_Marca DESC;

-- Ex4. Voc� � responsavel por controlar os dados de clientes e de produtos da sua empresa. Confirme se:

-- a. Existem 2.517 produtos cadastrados na base e, se n�o tiver, voc� dever� reportar ao seu gestor
-- para saber se existe alguma defasagem no controle dos produtos. Quantidade de produtos se mant�m

SELECT COUNT(ProductName) Qtd_Produtos FROM DimProduct;

-- b. At� o m�s passado, a empresa tinha um total de 19.500 clientes na base de controle. Verifique se
-- esse n�mero aumentou ou reduziu. Quantidade atual reduziu tendo 18.869 clientes

SELECT COUNT(CustomerKey) Qtd_Clientes FROM DimCustomer;

/* Ex5. Voc� trabalha no setor de marketing da empresa Contoso e acaba de ter uma ideia de oferecer 
descontos especiais para os clientes no dia de seus anivers�rios. Para isso, voc� vai precisar
listar todos os clientes e as suas respectivas datas de nascimento, al�m de um contato. */

--a. Selecione as colunas: CustomerKey, FirstName, EmailAddress, BirthDate da tabela DimCustomer
--b. Renomeie as colunas dessa tabela usando o alias 

SELECT CustomerKey AS 'Id_Cliente', 
	FirstName AS 'Primeiro_Nome', 
	EmailAddress AS 'Email_Cliente', 
	BirthDate AS 'Data_Nascimento'
FROM DimCustomer;


/* Ex6. A Contoso est� comemorando anivers�rio de inaugura��o de 10 anos e pretende fazer uma a��o de 
premia��o para os clientes. A empresa quer presentear os primeiros clientes desde a inaugura��o. Voc�
foi alocado para levar adiante essa a��o, para isso voc� ter� que fazer o seguinte:

A Contoso decidiu presentear os primeiros 100 clientes da hist�ria com um vale compras de R$ 10.000.
Utilize um comando em SQL para retornar uma tabela com os primeiros 100 clientes da tabela DimCustomers */

SELECT TOP(100) * FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY DateFirstPurchase;

/* Ex7. A empresa Contoso precisa fazer contato com os fornecedores de produtos para repor o estoque.
Voc� � da �rea de compras e precisa descobrir quem s�o esses fornecedores.

Retorne apenas os nomes dos fornecedores na tabela DimProduct e renomeie essa nova coluna da tabela */

SELECT DISTINCT(Manufacturer) Fabricantes FROM DimProduct;

/* Ex8. O seu trabalho de investiga��o n�o para. Voc� precisa descobrir se existe algum
produto registrado na base de produtos que ainda n�o tenha sido vendido. Tente chegar
nessa informa��o */ 

SELECT COUNT(DISTINCT ProductKey) AS Qtd_Vendida FROM FactSales
-- Tem apenas um produto n�o vendido necess�rio invistigar mais afundo

-- Base de dados muito grande
SELECT TOP(100) ProductName, SalesQuantity, SalesAmount 
FROM DimProduct, FactSales
ORDER BY NEWID();