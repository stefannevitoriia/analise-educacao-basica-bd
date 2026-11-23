# 📚 Análise da Educação Básica no Brasil (Censo Escolar)

Projeto de banco de dados da disciplina **SIN 220** (UFV, Campus Rio Paranaíba, 2025). Modelagem relacional, criação do banco em MySQL e consultas SQL sobre dados públicos do **Censo Escolar (INEP)**, obtidos pela plataforma [Base dos Dados](https://basedosdados.org/).

## 🎯 Objetivo

Responder perguntas analíticas sobre a Educação Básica no país (distribuição de escolas, matrículas, docentes e turmas por município, estado e região) usando contagens, agregações, rankings e junções entre tabelas.

## 🗂️ Modelo de dados

Cinco tabelas relacionadas:

| Tabela | Descrição |
|--------|-----------|
| `MUNICIPIO` | Municípios e suas regiões (UF, região, DDD, capital, Amazônia Legal etc.) |
| `ESCOLA` | Escolas por município e ano (2020 a 2023), rede e localização |
| `DOCENTE` | Docentes das escolas |
| `TURMA` | Turmas por escola |
| `MATRICULA` | Matrículas por etapa de ensino |

O diagrama entidade-relacionamento e a descrição do modelo físico estão no [relatório](docs/relatorio.pdf).

## 📁 Estrutura

```
├── sql/
│   ├── criacaoBD.sql    # criação do banco, das tabelas e carga de dados
│   └── consultas.sql    # consultas analíticas (11 grupos)
└── docs/
    └── relatorio.pdf    # relatório completo do projeto
```

## 🔎 Consultas incluídas

1. Escolas por município e por estado
2. Total de matrículas por etapa e região
3. Municípios com mais docentes
4. Média de matrículas por escola por UF
5. Escolas com maior número de matrículas
6. Proporção de escolas públicas e privadas por UF
7. Distribuição de escolas urbanas e rurais
8. Docentes com formação superior por região
9. Escolas com maior número de turmas
10. Matrículas nas capitais
11. Evolução das matrículas

## ▶️ Como executar

Pré-requisito: MySQL 8 (ou compatível) instalado.

```bash
# 1. Criar o banco, as tabelas e carregar os dados
mysql -u SEU_USUARIO -p < sql/criacaoBD.sql

# 2. Rodar as consultas (ou abrir sql/consultas.sql no MySQL Workbench)
mysql -u SEU_USUARIO -p sistema_educacional < sql/consultas.sql
```

## 🛠️ Tecnologias

MySQL · SQL · Modelagem relacional (DER) · Base dos Dados / INEP

## 👩‍💻 Autoria

Projeto desenvolvido em grupo por:

- **Anne Teixeira Silva**
- **Stefanne Vitória Pereira Dias** — [@stefannevitoriia](https://github.com/stefannevitoriia)
- **Tainá Aparecida de Souza Abreu**
- **Lívia Borges Silva** — [@liviabs](https://github.com/liviabs)
- **Rafaella Blom dos Santos** — [@rafaellablom](https://github.com/rafaellablom)

## 📄 Fonte dos dados

Dados públicos do Censo Escolar (INEP) e da tabela de municípios (IBGE), disponibilizados pela [Base dos Dados](https://basedosdados.org/).
