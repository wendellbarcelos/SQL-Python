-- Vamos considerar algumas consultas típicas que podem ser realizadas em um sistema de gerenciamento escolar.

-- Consulta 1: Retornar a média de Notas dos Alunos em história.
SELECT AVG(Nota) from Notas

-- Consulta 2: Retornar as informações dos alunos cujo Nome começa com 'A'.
SELECT * FROM Alunos
WHERE nome_aluno LIKE 'A%'

-- Consulta 3: Buscar apenas os alunos que fazem aniversário em fevereiro.
SELECT * FROM Alunos
WHERE STRFTIME('%m', data_nascimento) = '02'

-- Consulta 4: Realizar uma consulta que calcula a idade dos Alunos.
SELECT id_aluno, nome_aluno, data_nascimento, genero, 
date() - data_nascimento AS Idade 
FROM Alunos


-- Consulta 5: Retornar se o aluno está ou não aprovado. Aluno é considerado aprovado se a sua nota foi igual ou maior que 6.
SELECT data_avaliacao, nome_aluno, nota, 
	CASE
    	When nota >= 6 THEN 'Aprovado'
        ELSE 'Reprovado'
    END As Situação,
nome_disciplina, nome_professor 
from Notas
INNER JOIN Alunos on Alunos.ID_Aluno = Notas.ID_Aluno
INNER JOIN Disciplinas on Disciplinas.ID_Disciplina = Notas.ID_Disciplina
INNER JOIN Professores on Professores.ID_Professor = Disciplinas.ID_Professor


-- Retornando somente os reprovados
SELECT data_avaliacao, nome_aluno, nota, 
	CASE
    	When nota >= 6 THEN 'Aprovado'
        ELSE 'Reprovado'
    END As Situação,
nome_disciplina, nome_professor 
from Notas
INNER JOIN Alunos on Alunos.ID_Aluno = Notas.ID_Aluno
INNER JOIN Disciplinas on Disciplinas.ID_Disciplina = Notas.ID_Disciplina
INNER JOIN Professores on Professores.ID_Professor = Disciplinas.ID_Professor
WHERE Situação = 'Reprovado'

