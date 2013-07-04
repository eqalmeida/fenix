package fenix

import java.math.*

class ParcelaService {

    static transactional = true

    void calculaAcrescimos(Parcela parcela){

        def diasAtraso = (parcela.dataPagamento - parcela.vencimento);
        
        if (diasAtraso > parcela.emprestimo.diasTolerancia){

            //
            // Calcula juros diário.
            //
            parcela.acrescimos = (parcela.taxaJurosAtraso * diasAtraso * parcela.valor / 100.0)
            
            //
            // Acrescenta multa por atraso.
            //
            parcela.acrescimos += parcela.multaAtraso

            //
            // Acrescenta multa percentual
            //
            parcela.acrescimos += (parcela.multaAtrasoPercent * parcela.valor / 100.0)

            //
            // Arredonda na escala da moeda.
            //
            parcela.acrescimos = parcela.acrescimos.setScale(2, RoundingMode.DOWN);
        } 
        else {
            parcela.acrescimos = 0.0    
        }
        
    }


}
