-- ARQUIVO: consultas.sql
-- Consultas do projeto SIN220 — Base dos Dados

-- 1. Escolas por município
SELECT 
    e.id_municipio,
    m.nome AS municipio,
    m.sigla_uf,
    COUNT(DISTINCT e.id_escola) AS total_escolas
FROM escola e
LEFT JOIN municipio m ON e.id_municipio = m.id_municipio
GROUP BY 
    e.id_municipio, 
    m.nome, 
    m.sigla_uf
ORDER BY total_escolas DESC;

-- 1.2 Escolas por estado
SELECT 
    CASE FLOOR(e.id_municipio / 100000)
        WHEN 11 THEN 'RO'
        WHEN 12 THEN 'AC'
        WHEN 13 THEN 'AM'
        WHEN 14 THEN 'RR'
        WHEN 15 THEN 'PA'
        WHEN 16 THEN 'AP'
        WHEN 17 THEN 'TO'
        WHEN 21 THEN 'MA'
        WHEN 22 THEN 'PI'
        WHEN 23 THEN 'CE'
        WHEN 24 THEN 'RN'
        WHEN 25 THEN 'PB'
        WHEN 26 THEN 'PE'
        WHEN 27 THEN 'AL'
        WHEN 28 THEN 'SE'
        WHEN 29 THEN 'BA'
        WHEN 31 THEN 'MG'
        WHEN 32 THEN 'ES'
        WHEN 33 THEN 'RJ'
        WHEN 35 THEN 'SP'
        WHEN 41 THEN 'PR'
        WHEN 42 THEN 'SC'
        WHEN 43 THEN 'RS'
        WHEN 50 THEN 'MS'
        WHEN 51 THEN 'MT'
        WHEN 52 THEN 'GO'
        WHEN 53 THEN 'DF'
        ELSE 'UF_DESCONHECIDA'
    END AS sigla_uf,
    COUNT(*) AS total_escolas
FROM escola e
GROUP BY sigla_uf
ORDER BY sigla_uf;

-- 2. Total de matrículas por etapa e região
SELECT 
    m.nome_regiao AS regiao,
    mat.etapa_ensino,
    COUNT(*) AS total_matriculas
FROM matricula mat
LEFT JOIN municipio m ON mat.id_municipio = m.id_municipio
GROUP BY 
    m.nome_regiao, 
    mat.etapa_ensino
ORDER BY 
    m.nome_regiao, 
    mat.etapa_ensino;

-- 3. Municípios com mais docentes
SELECT 
    d.id_municipio,
    m.nome AS municipio,
    COUNT(DISTINCT d.id_docente) AS total_docentes
FROM docente d
LEFT JOIN municipio m ON d.id_municipio = m.id_municipio
GROUP BY 
    d.id_municipio, 
    m.nome
ORDER BY total_docentes DESC
LIMIT 50;

-- 4. Média de matrículas por escola por UF
SELECT 
    CASE FLOOR(e.id_municipio / 100000)
        WHEN 11 THEN 'RO' WHEN 12 THEN 'AC' WHEN 13 THEN 'AM'
        WHEN 14 THEN 'RR' WHEN 15 THEN 'PA' WHEN 16 THEN 'AP'
        WHEN 17 THEN 'TO' WHEN 21 THEN 'MA' WHEN 22 THEN 'PI'
        WHEN 23 THEN 'CE' WHEN 24 THEN 'RN' WHEN 25 THEN 'PB'
        WHEN 26 THEN 'PE' WHEN 27 THEN 'AL' WHEN 28 THEN 'SE'
        WHEN 29 THEN 'BA' WHEN 31 THEN 'MG' WHEN 32 THEN 'ES'
        WHEN 33 THEN 'RJ' WHEN 35 THEN 'SP' WHEN 41 THEN 'PR'
        WHEN 42 THEN 'SC' WHEN 43 THEN 'RS' WHEN 50 THEN 'MS'
        WHEN 51 THEN 'MT' WHEN 52 THEN 'GO' WHEN 53 THEN 'DF'
        ELSE 'UF_DESCONHECIDA'
    END AS sigla_uf,
    AVG(e.quantidade_matricula_educacao_basica) AS media_matriculas
FROM escola e
GROUP BY sigla_uf
ORDER BY sigla_uf;

-- 5. Escolas com maior número de matrículas
SELECT 
    mat.id_escola,
    COUNT(*) AS total_matriculas
FROM matricula mat
GROUP BY mat.id_escola
ORDER BY total_matriculas DESC
LIMIT 50;

-- 6. Proporção de escolas públicas vs privadas por UF
SELECT
    CASE FLOOR(e.id_municipio / 100000)
        WHEN 11 THEN 'RO' WHEN 12 THEN 'AC' WHEN 13 THEN 'AM'
        WHEN 14 THEN 'RR' WHEN 15 THEN 'PA' WHEN 16 THEN 'AP'
        WHEN 17 THEN 'TO' WHEN 21 THEN 'MA' WHEN 22 THEN 'PI'
        WHEN 23 THEN 'CE' WHEN 24 THEN 'RN' WHEN 25 THEN 'PB'
        WHEN 26 THEN 'PE' WHEN 27 THEN 'AL' WHEN 28 THEN 'SE'
        WHEN 29 THEN 'BA' WHEN 31 THEN 'MG' WHEN 32 THEN 'ES'
        WHEN 33 THEN 'RJ' WHEN 35 THEN 'SP' WHEN 41 THEN 'PR'
        WHEN 42 THEN 'SC' WHEN 43 THEN 'RS' WHEN 50 THEN 'MS'
        WHEN 51 THEN 'MT' WHEN 52 THEN 'GO' WHEN 53 THEN 'DF'
        ELSE 'UF_DESCONHECIDA'
    END AS sigla_uf,
    SUM(CASE WHEN e.rede = 1 THEN 1 ELSE 0 END) AS escolas_publicas,
    SUM(CASE WHEN e.rede = 2 THEN 1 ELSE 0 END) AS escolas_privadas,
    COUNT(*) AS total_escolas,
    ROUND(SUM(CASE WHEN e.rede = 1 THEN 1 END) / COUNT(*), 4) AS proporcao_publicas,
    ROUND(SUM(CASE WHEN e.rede = 2 THEN 1 END) / COUNT(*), 4) AS proporcao_privadas
FROM escola e
GROUP BY sigla_uf
ORDER BY sigla_uf;

-- 7. Distribuição de escolas urbanas e rurais
SELECT 
    e.id_municipio,
    SUM(CASE WHEN e.tipo_localizacao = 1 THEN 1 ELSE 0 END) AS escolas_urbanas,
    SUM(CASE WHEN e.tipo_localizacao = 2 THEN 1 ELSE 0 END) AS escolas_rurais,
    COUNT(*) AS total_escolas
FROM escola e
GROUP BY e.id_municipio
ORDER BY escolas_rurais DESC, escolas_urbanas DESC;

-- 8. Docentes com formação superior por região
SELECT 
    CASE 
        WHEN FLOOR(d.id_municipio / 100000) IN (11,12,13,14,15,16,17) THEN 'NORTE'
        WHEN FLOOR(d.id_municipio / 100000) IN (21,22,23,24,25,26,27,28,29) THEN 'NORDESTE'
        WHEN FLOOR(d.id_municipio / 100000) IN (31,32,33,35) THEN 'SUDESTE'
        WHEN FLOOR(d.id_municipio / 100000) IN (41,42,43) THEN 'SUL'
        WHEN FLOOR(d.id_municipio / 100000) IN (50,51,52,53) THEN 'CENTRO-OESTE'
        ELSE 'NAO_IDENTIFICADO'
    END AS regiao,
    COUNT(*) AS docentes_superior
FROM docente d
WHERE d.escolaridade IN (3,4)
GROUP BY regiao
ORDER BY regiao;

-- 9. Escolas com maior número de turmas
SELECT 
    t.id_escola,
    COUNT(*) AS numero_turmas
FROM turma t
GROUP BY t.id_escola
ORDER BY numero_turmas DESC
LIMIT 50;

-- 10. Matrículas nas capitais
SELECT
    id_municipio,
    SUM(quantidade_matricula_educacao_basica) AS total_matriculas
FROM escola
WHERE id_municipio IN (1501402)
GROUP BY id_municipio
ORDER BY total_matriculas DESC;

-- 11. Evolução das matrículas
SELECT ano, COUNT(*) AS total_matriculas
FROM matricula
GROUP BY ano
ORDER BY ano;

SELECT ano, etapa_ensino, COUNT(*) AS total_matriculas
FROM matricula
GROUP BY ano, etapa_ensino
ORDER BY ano, etapa_ensino;
