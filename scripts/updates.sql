ALTER TABLE `fenix`.`emprestimo` MODIFY COLUMN `valor_parcela` DECIMAL(19,2)  DEFAULT NULL;

alter table emprestimo add dias_tolerancia INT;
update emprestimo set dias_tolerancia = 5;
ALTER TABLE emprestimo CHANGE dias_tolerancia dias_tolerancia INT NOT NULL;


ALTER TABLE TIPO_EMPRESTIMO ADD multa_atraso_percent DECIMAL(19,4);
UPDATE TIPO_EMPRESTIMO SET MULTA_ATRASO_PERCENT = 0.0;
ALTER TABLE TIPO_EMPRESTIMO MODIFY COLUMN multa_atraso_percent DECIMAL(19,4) NOT NULL;

ALTER TABLE PARCELA ADD multa_atraso_percent DECIMAL(19,4);
UPDATE PARCELA SET MULTA_ATRASO_PERCENT = 0.0;
ALTER TABLE PARCELA MODIFY COLUMN multa_atraso_percent DECIMAL(19,4) NOT NULL;

ALTER TABLE observacao ADD ativo BIT(1);
UPDATE observacao SET ativo = 1;
ALTER TABLE observacao MODIFY COLUMN ativo BIT(1) NOT NULL;

ALTER TABLE PARCELA DROP COLUMN PARCELA_ANT_ID;

