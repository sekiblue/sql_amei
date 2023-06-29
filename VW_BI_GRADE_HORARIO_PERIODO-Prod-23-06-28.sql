SELECT * FROM VW_BI_GRADE_HORARIO_PERIODO


CREATE OR REPLACE VIEW VW_BI_GRADE_HORARIO_PERIODO 
BEQUEATH DEFINER AS
SELECT A."id" ID,
       A."clinica_id" ID_UNIDADE,
       B."eSPECIALIDADESId" ID_ESPECIALIDADE,
       A."profissional_id" ID_PROFISSIONAL,
       A."dia_inicio" DATA_INICIO,
       A."dia_termino" DATA_TERMINO,
A."tempo" TEMPO_ATENDIMENTO,
A."dia" DIA_SEMANA,
CONCAT(CASE
              WHEN LENGTH(TO_CHAR(A."hora_inicio")) <= 2 THEN
                 TO_CHAR(A."hora_inicio") || ':00'
              WHEN LENGTH(SUBSTR(TO_CHAR(A."hora_inicio"),(INSTR(TO_CHAR(A."hora_inicio"),',')+1))) = 1 THEN
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':') || '0'
              WHEN MOD(A."hora_inicio", 1) >= 0.60 THEN 
                 TO_CHAR((A."hora_inicio"-MOD(A."hora_inicio", 1)) ) || ':59'
              ELSE
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':')
            END,':00') HORA_INICIO,
CONCAT(CASE
              WHEN LENGTH(TO_CHAR(A."hora_termino")) <= 2 THEN
                 TO_CHAR(A."hora_termino") || ':00'
              WHEN LENGTH(SUBSTR(TO_CHAR(A."hora_termino"),(INSTR(TO_CHAR(A."hora_termino"),',')+1))) = 1 THEN
                 REPLACE(TO_CHAR(A."hora_termino"),',',':') || '0'
              WHEN MOD(A."hora_termino", 1) >= 0.60 THEN 
                 TO_CHAR((A."hora_termino"-MOD(A."hora_termino", 1)) ) || ':59'
              ELSE
                 REPLACE(TO_CHAR(A."hora_termino"),',',':')
            END,':00') HORA_FINAL,
            
       A.CREATE_AT, A.UPDATE_AT 
FROM   HORARIOS A
LEFT   OUTER JOIN HORARIOS_X_ESPECIALIDADES B ON B."hORARIOSId" = A."id"
WHERE  A."deletado" = 0
AND    A."dia" = 0


/*----ORIGINAL
CREATE OR REPLACE VIEW VW_BI_GRADE_HORARIO_PERIODO ( ID, ID_UNIDADE, ID_ESPECIALIDADE, ID_PROFISSIONAL, DATA_INICIO, DATA_TERMINO, CREATE_AT, UPDATE_AT )
BEQUEATH DEFINER AS
SELECT A."id" ID,
       A."clinica_id" ID_UNIDADE,
       B."eSPECIALIDADESId" ID_ESPECIALIDADE,
       A."profissional_id" ID_PROFISSIONAL,
       A."dia_inicio" DATA_INICIO,
       A."dia_termino" DATA_TERMINO,
       A.CREATE_AT, A.UPDATE_AT
FROM   HORARIOS A
LEFT   OUTER JOIN HORARIOS_X_ESPECIALIDADES B ON B."hORARIOSId" = A."id"
WHERE  A."deletado" = 0
AND    A."dia" = 0
GO
*/