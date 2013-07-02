ALTER TABLE `fenix`.`emprestimo` MODIFY COLUMN `valor_parcela` DECIMAL(19,2)  DEFAULT NULL;

alter table emprestimo add dias_tolerancia INT;
update emprestimo set dias_tolerancia = 5;
ALTER TABLE emprestimo CHANGE dias_tolerancia dias_tolerancia INT NOT NULL;
