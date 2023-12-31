SELECT * FROM VW_BI_TABELAS_PARCERIAS

CREATE OR REPLACE VIEW VW_BI_TABELAS_PARCERIAS
BEQUEATH DEFINER AS
SELECT T.ID, T.PRECIFICACAO AS NOME_TABELA, 
T.CREATE_AT	AS DATA_CADASTRO,
T.UPDATE_AT AS DATA_ULTIMA_ATUALIZACAO,
DECODE(T.FLG_ATIVO,1,'Ativo',0,'Inativo') STATUS_CADASTRO,
T.CREATE_BY AS USUARIO_CRIACAO
FROM PRECIFICACAO T
GO

/*----ORIGINAL
CREATE OR REPLACE VIEW VW_BI_TABELAS_PARCERIAS ( ID, NOME_TABELA, DATA_CADASTRO, DATA_ULTIMA_ATUALIZACAO, STATUS_CADASTRO, USUARIO_CRIACAO )
BEQUEATH DEFINER AS
SELECT T.ID, T.TABELA_PADRAO AS NOME_TABELA, 
T.CREATE_AT	AS DATA_CADASTRO,
T.UPDATE_AT AS DATA_ULTIMA_ATUALIZACAO,
DECODE(T.FLG_ATIVO,1,'Ativo',0,'Inativo') STATUS_CADASTRO,
T.CREATE_BY AS USUARIO_CRIACAO
FROM TABELA_PADRAO T
GO
*/