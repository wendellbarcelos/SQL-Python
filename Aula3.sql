/*Durante os nossos estudos, vamos conhecer o projeto da empresa Serenatto café e bistrô. Atualmente, a empresa armazena as suas informações
em diversas fontes de dados, e nosso trabalho é centralizar todos esses dados em um só lugar e extrair informações essenciais para os gestores 
da empresa. Então, vamos utilizar o SQLite Online, para criar as nossas tabelas e executar as nossas consultas utilizando a linguagem SQL.*/

-- Tabelas: Produtos, Clientes, Pedidos, Itens de Pedido, Colaboradores, Fornecedores


SELECT * FROM colaboradores;

SELECT * FROM fornecedores;

/*Precisamos buscar o endereço dos colaboradores e fornecedores da empresa, usando o UNION ele 
retorna o que precisamos porem ele só tras valores distintos, e os duplicados ele ignora*/

SELECT Rua, Bairro, Cidade, Estado, cep FROM colaboradores
UNION 
SELECT Rua, Bairro, Cidade, Estado, cep FROM fornecedores;

/*Para ter os valores completos precisa usar a clasula UNION ALL que ele retornará todos os dados*/

SELECT nome, Rua, Bairro, Cidade, Estado, cep FROM colaboradores
UNION ALL
SELECT nome, Rua, Bairro, Cidade, Estado, cep FROM fornecedores;

/*O operador EXCEPT é usado para retornar todas as linhas que estão presentes na primeira 
consulta (conjunto A) e não estão presentes na segunda consulta (conjunto B). Em outras palavras, 
ele subtrai o conjunto B do conjunto A.

SELECT colunas FROM tabelaA
EXCEPT
SELECT colunas FROM tabelaB;

O operador INTERSECT é usado para retornar todas as linhas que estão presentes tanto na 
primeira consulta (conjunto A) quanto na segunda consulta (conjunto B). Em outras palavras, 
ele retorna a interseção dos dois conjuntos.

SELECT * FROM TabelaA
INTERSECT
SELECT * FROM TabelaB;*/

/*Muitas as vezes precisamos buscar um valor atraves de algumas consultas distintas para isso
podemos fazer uma consulta aninhada, as famosas sub-consultas
Precisamos de um relatorio de clientes para enviar um presente para o primeiro cliente a fazer
um pedido em nossa empresa*/

SELECT * FROM clientes
WHERE id = (
  SELECT idcliente from pedidos 
  WHERE id = 1);

/*Aqui buscamos o cliente a fazer o primeiro pedido na loja, usando o ID do cliente do pedido*/

/*Você é um professor e deseja identificar o aluno que obteve a maior nota em sua disciplina. 
Você tem duas tabelas em seu banco de dados: "Alunos" e "Notas". A tabela "Notas" registra as 
notas dos alunos em sua disciplina. Seu desafio é encontrar o aluno com a maior nota.

SELECT * from Alunos
WHERE id_aluno = (
  SELECT id_aluno from Notas
  WHERE nota = (
    SELECT MAX(Nota)
    FROM Notas
    )); */

/*Agora precisamos de todos os clientes que fizeram pedidos no mês Janeiro, para isso será
necessario usar uma subquery usando a função IN para pegar todos os valores em uma lista */

SELECT nome from clientes 
WHERE id IN (
  SELECT idcliente from pedidos 
  WHERE strftime('%m', datahorapedido) = '01' )
   

/*Agora precisamos saber os valores maiores que a media, retorne a media e os valores
Usando o HAVING para trabalhar com valores agrupados*/

SELECT nome, preco FROM produtos
GROUP BY nome, preco
HAVING preco > (
  SELECT AVG(preco) from produtos)
ORDER BY preco DESC


/*Em contrapartida, o HAVING é usado para filtrar dados depois que eles foram agrupados
com a cláusula GROUP BY. Isso é útil quando você quer aplicar uma condição de filtro 
não nas linhas individuais, mas nos grupos resultantes. HAVING é frequentemente usado 
com funções de agregação, como COUNT(), SUM(), AVG(), etc.*/

SELECT cidade, COUNT(*)
FROM colaboradores
GROUP BY cidade
HAVING COUNT(*) > 5;

/*Imagine que você tem um quebra-cabeça: cada peça representa uma informação que está guardada em uma tabela diferente no 
seu banco de dados. Para ver a imagem completa, você precisa encaixar essas peças. No mundo dos bancos de dados, esse 
"encaixe" é feito através de uma operação chamada JOIN.

O que é JOIN?
JOIN é um comando usado em SQL (a linguagem de consulta de bancos de dados) para combinar linhas de duas ou mais tabelas, 
baseado em uma coluna relacionada entre elas. Isso é muito útil quando você quer ver informações que estão distribuídas em 
diferentes tabelas.*/

/*Selecione nome, id e data do pedido relacionando as duas tabelas cliente e pedidos*/

SELECT c.nome, p.id, p.datahorapedido from clientes c
INNER JOIN pedidos p
ON c.id = p.idcliente

/*Precisamos de uma analise por categoria de produtos*/
SELECT p.categoria AS Categoria, 
	COUNT(i.quantidade) AS Qtd_por_Categ,
	SUM(i.precounitario) AS Total_PrecoUn, 
	SUM(p.preco) As Total_Preco
from produtos p
INNER JOIN itenspedidos i
on p.id = i.idproduto
GROUP BY categoria

/*E os produtos que foram pedidos somente no mês de outubro?*/

SELECT pr.nome, x.idproduto, x.idpedido
FROM(
    SELECT ip.idpedido, ip.idproduto
    FROM pedidos p
    JOIN itenspedidos ip
    ON p.id = ip.idpedido
    WHERE strftime('%m', p.datahorapedido) = '10') x
RIGHT JOIN produtos pr
ON pr.id = x.idproduto











