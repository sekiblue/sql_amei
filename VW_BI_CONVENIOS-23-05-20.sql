
CREATE OR REPLACE VIEW VW_BI_CONVENIOS
BEQUEATH DEFINER AS
SELECT A."id" ID,
       T.min_unidade_id ID_UNIDADE,
       A."nome" NOME_CONVENIO,
       'Ativo' STATUS
FROM   CONVENIOS A
LEFT JOIN (SELECT "convenio_id", MIN("unidade_id") AS min_unidade_id  FROM CONTRATOS group by "convenio_id") T
 ON T."convenio_id" = A."id"
WHERE UPPER(A."nome") NOT LIKE '%DE TODOS'
GO


--SELECT * FROM VW_BI_CONVENIOS