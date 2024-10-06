SELECT * from HistoricoEmprego;

-- Rotornando os 5 primeiros colaboradores ativos com os maiores salarios --
SELECT * from HistoricoEmprego
WHERE datatermino ISNULL
ORDER BY salario DESC
LIMIT 5;

-- Buscando os valores a partir de um texto, o % informa que apos o informado ainda contem texto --
SELECT * from Treinamento
WHERE curso LIKE 'O Poder %';

-- Retornando as linhas que tem o palavra realizar em algum lugar dentro do texto --
SELECT * from Treinamento
WHERE curso LIKE '% realizar %';

-- Retornando colaborador por nome, usando o filtro LIKE e % --
SELECT* from Colaboradores
WHERE nome LIKE 'Isadora %';

-- A empresa FOKUS precisa preencher algumas vagas especificas, quais seriam essas vagas?
SELECT * from HistoricoEmprego
WHERE cargo LIKE 'Professor' and datatermino NOT NULL;

-- Usando o OR para retornar um valor ou o outro dentro da condiçãoColaboradores
SELECT * from  HistoricoEmprego
WHERE cargo = 'Oftalmologista' OR cargo = 'Dermatologista' 
AND datatermino NOT NULL;

-- Usando o IN para retornar um valor, passando uma lista de valores
SELECT * from  HistoricoEmprego
WHERE cargo IN ('Oftalmologista','Dermatologista', 'Professor')
AND datatermino NOT NULL;

-- Usando o NOT IN retorna todos os valores menos os valores da lista
SELECT * from  HistoricoEmprego
WHERE cargo NOT IN ('Oftalmologista','Dermatologista', 'Professor')
AND datatermino NOT NULL;

-- Retornando valores separando por parenteses, usando a logica em ambas as condições
SELECT * FROM Treinamento
WHERE (curso LIKE 'O direito %' AND instituicao = 'da Rocha')
OR (curso like 'O conforto %' and instituicao = 'das Neves');

-- Retorne o mes de maior e menor faturamento da empresa --
SELECT mes,  MAX(faturamento_bruto) AS 'Maior Faturamento', lucro_liquido from faturamento;
SELECT mes,  MIN(faturamento_bruto) AS 'Menor Faturamento', lucro_liquido from faturamento;

-- Retorne a soma de todo o faturamento no ano de 2023 --
SELECT SUM(numero_novos_clientes) As 'Total Clientes 2023' FROM faturamento
WHERE mes LIKE '%2023';

-- Qual a média de faturamento do ano de 2023 --
SELECT AVG(lucro_liquido) AS 'lucro Média' from faturamento
WHERE mes LIKE '%2023';

SELECT AVG(despesas) AS 'Despesas Média' from faturamento
WHERE mes LIKE '%2023';

-- Qual seria a quantidade de trabalhadores que estão desempregado --
SELECT COUNT(*) from HistoricoEmprego
WHERE datatermino NOT NULL;

-- Quantidade de trabalhadores que tiraram ferias no ano 2023 --
SELECT COUNT(*) from Licencas
WHERE tipolicenca = 'férias' and datainicio LIKE '2023%';

-- Retorne a quantidade de dependentes agrupando pelo tipo de dependente
SELECT parentesco, COUNT(*) AS 'Total' FROM Dependentes
GROUP BY parentesco;

/* A cláusula HAVING em SQL é utilizada para especificar condições de filtro que se aplicam a grupos de registros, 
em contraste com a cláusula WHERE, que se aplica a registros individuais. */

-- A ordem das cláusulas em uma consulta SQL é importante: SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY

-- Qual a quantidade de cursos por instituição --
SELECT instituicao, COUNT(curso) AS 'Total' FROM Treinamento
GROUP BY instituicao
HAVING Total >= 2
ORDER by Total DESC;


-- Qual a quantidade de cargo na empresa --
SELECT cargo, COUNT(cargo) Qtd_Cargo, SUM(salario) Total_Salarios from HistoricoEmprego
GROUP by cargo
HAVING Total_Salarios > 20000
ORDER BY Total_Salarios DESC;


-- Retornar o tamanho do CPF ou de qualquer valor
SELECT COUNT(*), LENGTH(cpf) qtd
FROM Colaboradores
WHERE qtd = 11;

--Medidas de Dispersão -> Média, Variancia e Desvio Padrão

-- Tamanho da amostra
SELECT COUNT(salario) AS N from HistoricoEmprego
-- Média -> Calculando ou pode usar a função AVG
SELECT SUM(salario) / COUNT(salario) AS Média From HistoricoEmprego
-- Variancia
SELECT POWER(salario - AVG(salario),2) / COUNT(salario - 1) AS Variancia FROM HistoricoEmprego
-- Desvio Padrão
SELECT SQRT(POWER(salario - AVG(salario),2) / COUNT(salario - 1)) AS DesvioPadrão FROM HistoricoEmprego

-- Categorizando os salarios como Alto, Médio e Baixo (Case = If)
SELECT ID, cargo, salario, 
Case 
WHEN salario < 3000 THEN 'Baixo'
WHEN salario BETWEEN 3000 AND 6000 THEN 'Médio'
ELSE 'Alto'
END AS Categoria_Salario 
from HistoricoEmprego

-- Precisamos dar de salario de 15% para salarios abaixo de 3000, 10% entre 3000 e 6000, e 5% acima de 6000 e classifica-los
SELECT ID, cargo, salario, 
	Case 
		WHEN salario < 3000 THEN 'Baixo'
		WHEN salario BETWEEN 3000 AND 6000 THEN 'Médio'
		ELSE 'Alto'
	END AS Categoria_Salario,
	FLOOR(Case 
		WHEN salario < 3000 THEN salario * 1.15
		WHEN salario BETWEEN 3000 AND 6000 THEN salario * 1.10
		ELSE salario * 1.05
	END) AS Salario_Aumento
from HistoricoEmprego

/* Exiba o departamento e a média salarial dos funcionários em cada departamento na tabela funcionarios, agrupando por departamento, 
apenas para os departamentos cuja média salarial é superior a $5000. */

SELECT cargo, ROUND(AVG(salario),0) As Média_Salario FROM HistoricoEmprego
GROUP BY cargo
HAVING Média_Salario > 5000
order BY Média_Salario ASC

