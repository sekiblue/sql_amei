SELECT * FROM VW_BI_AGENDAMENTOS 
WHERE ID IN (7240,5499)
ORDER BY ID DESC

CREATE OR REPLACE VIEW VW_BI_AGENDAMENTOS 
BEQUEATH DEFINER AS
SELECT A."id" ID,
       A.CREATE_AT AS DATA_CRIACAO_AGENDAMENTO,
       COALESCE(TO_TIMESTAMP((to_char(A."data", 'dd-mon-yyyy') || ' ' || 
            CONCAT(CASE
              WHEN LENGTH(TO_CHAR(A."hora_inicio")) <= 2 THEN
                 TO_CHAR(A."hora_inicio") || ':00'
              WHEN LENGTH(SUBSTR(TO_CHAR(A."hora_inicio"),(INSTR(TO_CHAR(A."hora_inicio"),',')+1))) = 1 THEN
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':') || '0'
              WHEN MOD(A."hora_inicio", 1) >= 0.60 THEN 
                 TO_CHAR((A."hora_inicio"-MOD(A."hora_inicio", 1)) ) || ':59'
              ELSE
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':')
            END,':00'))
            default null on conversion error, 'dd-mon-yyyy hh24:mi:ss'),
         A."data") AS DATA_DO_AGENDAMENTO,
       to_char(T.DATA_ATENDIMENTO,'HH24:MI:SS') HORA_INICIO_ATENDIMENTO,
       to_char(COALESCE(T.OBJETIVA_DATA_TERMINO,T.AVALIACAO_DATA_TERMINO),'HH24:MI:SS') HORA_TERMINO_ATENDIMENTO,
       A."clinica_id" ID_UNIDADE,
       A."paciente_id" ID_PACIENTE,
       B."sexo_id" ID_SEXO,
       A."precificacao_id" ID_CONVENIO,
       A."especialidade_id" ID_ESPECIALIDADE,
       C."procedimento_id" ID_PROCEDIMENTO,
       A."canal_id" ID_CANAL,
       A."profissional_id" ID_PROFISSIONAL,
/*        
COALESCE(TO_TIMESTAMP((to_char(A."data", 'dd-mon-yyyy') || ' ' || 
            CONCAT(CASE
              WHEN LENGTH(TO_CHAR(A."hora_inicio")) <= 2 THEN
                 TO_CHAR(A."hora_inicio") || ':00'
              WHEN LENGTH(SUBSTR(TO_CHAR(A."hora_inicio"),(INSTR(TO_CHAR(A."hora_inicio"),',')+1))) = 1 THEN
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':') || '0'
              ELSE
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':')
            END,':00'))
            default null on conversion error, 'dd-mon-yyyy hh24:mi:ss'),
         A."data") AS DATA_E_HORA_INICIO,

COALESCE(TO_TIMESTAMP((to_char(A."data", 'dd-mon-yyyy') || ' ' || 
            CONCAT(CASE
              WHEN LENGTH(TO_CHAR(A."hora_termino")) <= 2 THEN
                 TO_CHAR(A."hora_termino") || ':00'
              WHEN LENGTH(SUBSTR(TO_CHAR(A."hora_termino"),(INSTR(TO_CHAR(A."hora_termino"),',')+1))) = 1 THEN
                 REPLACE(TO_CHAR(A."hora_termino"),',',':') || '0'
              ELSE
                 REPLACE(TO_CHAR(A."hora_termino"),',',':')
            END,':00') )
            default null on conversion error, 'dd-mon-yyyy hh24:mi:ss'),
         A."data") AS DATA_E_HORA_FIM,
*/
        A."status_agendamento_id" AS ID_STATUS,
        COALESCE(A."parceria_id",B."parceria_id",C."tabela_precos_id") AS TABELA_PARCERIA_ID,
        TO_CHAR(T.DATA_ATENDIMENTO,'HH24:MI') HORARIO_CHEGADA,
        A.CREATE_AT, A.UPDATE_AT,
        LPAD(CONCAT(CASE
              WHEN LENGTH(TO_CHAR(A."hora_inicio")) <= 2 THEN
                 TO_CHAR(A."hora_inicio") || ':00'
              WHEN LENGTH(SUBSTR(TO_CHAR(A."hora_inicio"),(INSTR(TO_CHAR(A."hora_inicio"),',')+1))) = 1 THEN
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':') || '0'
              WHEN MOD(A."hora_inicio", 1) >= 0.60 THEN 
                 TO_CHAR((A."hora_inicio"-MOD(A."hora_inicio", 1)) ) || ':59'
              ELSE
                 REPLACE(TO_CHAR(A."hora_inicio"),',',':')
            END,':00'), 8, '0') HORA_AGENDAMENTO --SELECT *
FROM   AGENDAMENTOS A
LEFT   OUTER JOIN PACIENTES B ON B."id" = A."paciente_id" AND B."ativo" = 1
LEFT   OUTER JOIN AGENDAMENTOS_PROCEDIMENTOS C ON C."agendamento_id" = A."id"
LEFT   OUTER JOIN ATENDIMENTOS T ON A."id" = T.FK_AGENDAMENTO
GO
