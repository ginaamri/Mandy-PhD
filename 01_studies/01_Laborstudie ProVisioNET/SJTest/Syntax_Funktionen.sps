* Encoding: UTF-8.
DATASET ACTIVATE DataSet1.

* Nettoeinkommen / Monat: di01a.
* Arbeitsstunden / Wochen: dw15. 
* 1 Monat = 4,35 Wochen. 

* 1. Schritt: Wie berechne ich meine Variablen?
    
COMPUTE h_wage = di01a  / ( dw15 * 4.35 ).
*immer EXECUTEN = ausführen.
EXECUTE.

* Umbenennung der Einkommensvriable in 1; 2; 3.
RECODE di01a ( LOWEST THRU 450 = 1)
                       ( LOWEST THRU 1000 = 2)
                       ( ELSE = 3) INTO di01a_rec.
EXECUTE.

* Fallunterscheidungen mit IF. 
IF dw15 <= 15
    di01a_rec = 0.

EXECUTE.


