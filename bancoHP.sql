-- ATIVIDADE AVALIATIVA DE BANCO DE DADOS - Fazendo o MR da HELP PET
-- Projeto: Clinica Veterinaria Help Pet
-- Integrantes do Grupo:
--   - Caina Francisco
--   - Conrado Paranhos de Camargo
--   - Nata Miguel Faria

-- Universo da HelpPet
CREATE DATABASE HelpPet;
GO

USE HelpPet;
GO

CREATE TABLE PEDIDO (
    Numero_Pedido INT IDENTITY(1,1) PRIMARY KEY,
    Data_Pedido   DATE NOT NULL,
    Valor_Total   DECIMAL(10,2) NULL,
    ID_Cliente    INT NULL
);
GO

INSERT INTO PEDIDO (Data_Pedido, Valor_Total, ID_Cliente) VALUES
    ('2026-08-10', 180.00, 1),
    ('2026-08-22', 345.50, 2),
    ('2026-09-05',  95.00, 1),
    ('2026-09-18', 620.75, 3),
    ('2026-10-02', 250.00, 4),
    ('2026-10-15', 489.90, 2),
    ('2026-11-01',   NULL, 5),  
    ('2026-11-10', 135.25, NULL); 
GO

SELECT * FROM PEDIDO;
GO


-- CONSULTA 1: (WHERE) e (ORDER BY)
-- Descricao: Listar todos os pedidos com valor total maior que R$ 150,00,
-- ordenados do maior para o menor valor, para identificar os atendimentos
SELECT Numero_Pedido, Data_Pedido, Valor_Total, ID_Cliente
FROM PEDIDO
WHERE Valor_Total > 150.00
ORDER BY Valor_Total DESC;
GO

-- CONSULTA 2: (IN, LIKE e IS NULL)
-- Descricao: Consultando os clientes 1, 2 ou 5 (IN)
-- realizados no mês de agosto de 2026 (LIKE), ou ainda pedidos que estejam
-- com o valor em aberto (IS NULL).
SELECT Numero_Pedido, Data_Pedido, Valor_Total, ID_Cliente
FROM PEDIDO
WHERE (ID_Cliente IN (1, 2, 5) AND CONVERT(VARCHAR(10), Data_Pedido, 120) LIKE '2026-08-%')
   OR Valor_Total IS NULL;
GO

-- CONSULTA 3: (YEAR, DATENAME, DATEDIFF, GETDATE) e (CONCAT, UPPER)
-- Descricao: Exibir um codigo para cada pedido, o ano, o nome do mês
-- por extenso em letras maiúsculas e a quantidade de dias desde a
-- data do pedido até a data atual.
SELECT 
    CONCAT('PED-00', Numero_Pedido) AS Codigo_Pedido,
    Data_Pedido,
    YEAR(Data_Pedido) AS Ano_Pedido,
    UPPER(DATENAME(MONTH, Data_Pedido)) AS Mes_Extenso,
    DATEDIFF(DAY, Data_Pedido, GETDATE()) AS Dias_Decorridos,
    Valor_Total
FROM PEDIDO
WHERE Valor_Total IS NOT NULL;
GO

-- CONSULTA 4: (COUNT, SUM, AVG, MIN, MAX) e (ROUND)
-- Descricao: Calcular os "médios valores" tipo a média os valores minimo e maximo de cada pedido / da tabela PEDIDO:
-- total de pedidos registrados, pedidos computadoss, faturamento total,
-- ticket médio arredondado para duas casas decimais, menor e maior valor.
SELECT 
    COUNT(Numero_Pedido) AS Total_Pedidos,
    COUNT(Valor_Total) AS Pedidos_Faturados,
    SUM(Valor_Total) AS Faturamento_Total,
    ROUND(AVG(Valor_Total), 2) AS Ticket_Medio,
    MIN(Valor_Total) AS Menor_Valor,
    MAX(Valor_Total) AS Maior_Valor
FROM PEDIDO;
GO

-- CONSULTA 5: (ORDER BY) e (ROUND)
-- Descricao: Fazer um Top 3 de pedidos da clínica
-- dá pra simular um desconto também de 10%
SELECT TOP 3
    Numero_Pedido,
    Data_Pedido,
    ID_Cliente,
    Valor_Total AS Valor_Original,
    ROUND(Valor_Total * 0.90, 2) AS Valor_Com_Desconto_10Pct
FROM PEDIDO
WHERE Valor_Total IS NOT NULL
ORDER BY Valor_Total DESC;
GO