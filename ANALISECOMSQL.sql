-- GABRIEL LORENTE LOPES 
-- ESTUDANTE DE CIÊNCIA DA COMPUTAÇÃO
# --- ANÁLISES DE DADOS COM SQL --- #

SELECT * FROM alugueis;
SELECT * FROM atores;
SELECT * FROM atuacoes;
SELECT * FROM clientes;
SELECT * FROM filmes;

-- CASE 1.fazer uma análise para descobrir o preço médio de aluguel dos filmes.

SELECT AVG(preco_aluguel) FROM filmes;

-- CASE 2.descobrir qual é o preço médio para cada gênero de filme.

SELECT 
genero,
ROUND(AVG(preco_aluguel),2) AS preco_medio,
COUNT(*) AS qtd_filmes
FROM filmes
GROUP BY genero;


-- CASE 3: Fazer a mesma análise, mas considerando apenas os filmes com ANO_LANCAMENTO igual a 2011.

SELECT
genero,
ROUND(AVG(preco_aluguel),2) AS preco_medio,
COUNT(*) AS qtd_filmes
FROM filmes
WHERE ano_lancamento = 2011
GROUP BY genero;

-- CASE 4. fazer uma análise de desempenho dos alugueis, identificar quais aluguéis tiveram nota acima da média. 

SELECT AVG(nota) FROM alugueis;

SELECT * FROM alugueis 
WHERE nota >= (SELECT AVG(nota) FROM alugueis);

-- CASE 5. Crie uma view para guardar o resultado do SELECT abaixo.

CREATE VIEW resultado AS
SELECT
	genero,
	ROUND(AVG(preco_aluguel), 2) AS media_preco,
    COUNT(*) AS qtd_filmes
FROM filmes
GROUP BY genero;

SELECT * FROM resultado;

-- CASE 6. Descobrir quantos filmes foram alugados em cada mês, agrupando por ano e mês.

SELECT 
    YEAR(data_aluguel) AS ano,
    MONTH(data_aluguel) AS mes,
    COUNT(*) AS total_alugueis
FROM alugueis
GROUP BY YEAR(data_aluguel), MONTH(data_aluguel)
ORDER BY ano, mes;

-- CASE 7. Identificar o cliente que mais alugou filmes.

SELECT 
    id_cliente,
    COUNT(*) AS total_alugueis
FROM alugueis
GROUP BY id_cliente
ORDER BY total_alugueis DESC
LIMIT 1;


-- CASE 8. Identificar filmes mais populares

SELECT 
    f.titulo,
    COUNT(a.id_filme) AS total_alugueis
FROM alugueis a
JOIN filmes f ON a.id_filme = f.id_filme
GROUP BY f.titulo
ORDER BY total_alugueis DESC;

-- CASE 9. Descobrir a média de idade dos clientes que alugam filmes
SELECT 
    ROUND(AVG(YEAR(CURDATE()) - YEAR(data_nascimento)), 2) AS media_idade
FROM clientes;

-- CASE 10. Encontrar o filme mais alugado em um determinado ano
SELECT 
    f.titulo,
    COUNT(a.id_filme) AS total_alugueis
FROM alugueis a
JOIN filmes f ON a.id_filme = f.id_filme
WHERE YEAR(a.data_aluguel) = 2020 -- Alterar para o ano desejado
GROUP BY f.id_filme
ORDER BY total_alugueis DESC
LIMIT 1;