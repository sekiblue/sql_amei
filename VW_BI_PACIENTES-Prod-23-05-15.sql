/*Solicito que na view “VW_BI_PACIENTES” sejam inseridas as colunas listadas a seguir, por favor. Seguem:
 
ID_TABELAS_PARCERIAS
ID_CONVENIO
MATRICULA_CDT


SELECT * FROM VW_BI_PACIENTES WHERE ID_TABELAS_PARCERIAS IS NOT NULL
SELECT * FROM PACIENTES WHERE "parceria_id" IS NOT NULL
--OBS: O Campo ID_TABELAS_PARCERIAS estou pegando da propria tabela PACIENTES, no campo parceria_id. Está errado? Consegue me informar o campo correto?


SELECT * FROM VW_BI_PACIENTES WHERE ID_CONVENIO IS NOT NULL
--OBS: estou pegando da PACIENTE_CONVENIOS, porém possui apenas 1 registro. Está errado? Consegue me informar o campo correto?


SELECT * FROM VW_BI_PACIENTES WHERE MATRICULA_CDT IS NOT NULL
SELECT * FROM PROPOSTAS WHERE CDT_MATRICULA IS NOT NULL
--OBS: estou pegando da PROPOSTAS, mas não tem registros. Está errado? Consegue me informar o campo correto?
*/
GO

CREATE OR REPLACE VIEW VW_BI_PACIENTES
BEQUEATH DEFINER AS
SELECT A."id" ID,
       A."sexo_id" ID_SEXO,
       A."nome" || ' ' || A."sobrenome" NOME_PACIENTE,
       A."cpf" CPF,
       A."data_nascimento" NASCIMENTO,
       CONVENIOS."nome" AS CONVENIO, 
       PACIENTE_CONVENIOS."carteirinha" AS MATRICULA,
       COALESCE(A."telefone",A."celular") CONTATO,
       A."email" EMAIL,
       A."estado" ESTADO,
       A."cidade" CIDADE,
       A."bairro" BAIRRO,
       A."endereco" LOGRADOURO,
       A."numero" NUMERO,
       A."complemento" COMPLEMENTO,
       A."cep" CEP,
       DECODE(A."ativo",1,'Ativo',0,'Inativo') STATUS_CADASTRO,
       A."parceria_id" AS ID_TABELAS_PARCERIAS,
       CONVENIOS."id" AS ID_CONVENIO,
       TAB.MATRICULA_CDT AS MATRICULA_CDT	
FROM   PACIENTES A
LEFT JOIN  PACIENTE_CONVENIOS ON PACIENTE_CONVENIOS."paciente_id" = A."id"
LEFT JOIN (SELECT MIN(PC."paciente_id") AS MIN_PACIENTE_ID, PC."id" FROM PACIENTE_CONVENIOS PC GROUP BY PC."id") PC 
        ON PC.MIN_PACIENTE_ID = PACIENTE_CONVENIOS."paciente_id" AND PC."id" =  PACIENTE_CONVENIOS."id"
LEFT JOIN CONVENIOS ON CONVENIOS."id" = PACIENTE_CONVENIOS."convenio_id" AND UPPER(CONVENIOS."nome") NOT LIKE '%DE TODOS'
LEFT JOIN (SELECT A.FK_PACIENTE, MIN(A.CDT_MATRICULA) AS MATRICULA_CDT
        FROM   PROPOSTAS A GROUP BY A.FK_PACIENTE) TAB ON TAB.FK_PACIENTE = A."id"
GO


/*---ORIGINAL
CREATE OR REPLACE VIEW AMEI_APP_PROD.VW_BI_PACIENTES ( ID, ID_SEXO, NOME_PACIENTE, CPF, NASCIMENTO, CONVENIO, MATRICULA, CONTATO, EMAIL, ESTADO, CIDADE, BAIRRO, LOGRADOURO, NUMERO, COMPLEMENTO, CEP, STATUS_CADASTRO )
BEQUEATH DEFINER AS
SELECT A."id" ID,
       A."sexo_id" ID_SEXO,
       A."nome" || ' ' || A."sobrenome" NOME_PACIENTE,
       A."cpf" CPF,
       A."data_nascimento" NASCIMENTO,
       CONVENIOS."nome" AS CONVENIO, 
       PACIENTE_CONVENIOS."carteirinha" AS MATRICULA,
       COALESCE(A."telefone",A."celular") CONTATO,
       A."email" EMAIL,
       A."estado" ESTADO,
       A."cidade" CIDADE,
       A."bairro" BAIRRO,
       A."endereco" LOGRADOURO,
       A."numero" NUMERO,
       A."complemento" COMPLEMENTO,
       A."cep" CEP,
       DECODE(A."ativo",1,'Ativo',0,'Inativo') STATUS_CADASTRO 
FROM   PACIENTES A
LEFT JOIN  PACIENTE_CONVENIOS ON PACIENTE_CONVENIOS."paciente_id" = A."id"
LEFT JOIN (SELECT MIN(PC."paciente_id") AS MIN_PACIENTE_ID, PC."id" FROM PACIENTE_CONVENIOS PC GROUP BY PC."id") PC 
        ON PC.MIN_PACIENTE_ID = PACIENTE_CONVENIOS."paciente_id" AND PC."id" =  PACIENTE_CONVENIOS."id"
LEFT JOIN CONVENIOS ON CONVENIOS."id" = PACIENTE_CONVENIOS."convenio_id"
GO
*/