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