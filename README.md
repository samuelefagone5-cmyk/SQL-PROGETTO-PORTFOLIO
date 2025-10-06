SQL-PROGETTO PORTFOLIO 

DESCRIZIONE:  
Questo progetto è un’analisi del dataset Olist e-commerce tramite SQL, con l’obiettivo di esplorare i dati, generare insight utili e realizzare visualizzazioni a supporto delle decisioni di business.  

Il repository contiene query SQL, documentazione ed esempi di visualizzazione realizzati con Power BI per mostrare le principali dinamiche del mercato e-commerce: ordini, clienti, prodotti, vendite, consegne e recensioni.  

STRUTTURA DEL RESPONSITY:
- `DATA/` → dataset utilizzato (file CSV originali da Kaggle)  
- `SQL_QUERY/` → script SQL con le principali analisi  
- `VISUAL/` → grafici, report e screenshot delle dashboard in Power BI  
- `DOCS/` → documentazione di supporto  

PROGRAMMI UTILIZZATI:  
- SQL (Sqlite, Dbeaver)  
- Power BI per le visualizzazioni  

DATASET:
- Fonte: Dataset Olist su Kaggle — “Brazilian E-Commerce Public Dataset by Olist”  
- Link: [Kaggle Olist e-commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce#olist_products_dataset.csv)  
- Licenza del dataset: CC BY-NC-SA 4.0  
- Descrizione:  
  - Circa 100.000 ordini (2017-2018) registrati su vari marketplace in Brasile  
  - Organizzato in più CSV che coprono: ordini, clienti, prodotti, pagamenti, consegne, recensioni, geolocalizzazione e traduzione categorie  
- Principali file:  
  1. `olist_orders_dataset.csv` — dati sugli ordini  
  2. `olist_order_items_dataset.csv` — articoli inclusi negli ordini  
  3. `olist_order_payments_dataset.csv` — modalità di pagamento  
  4. `olist_order_reviews_dataset.csv` — recensioni clienti  
  5. `olist_products_dataset.csv` — dati sui prodotti  
  6. `olist_customers_dataset.csv` — dati clienti  
  7. `olist_sellers_dataset.csv` — venditori  
  8. `olist_geolocation_dataset.csv` — dati geografici  
  9. `product_category_name_translation.csv` — traduzione nomi categorie  

Nota: il dataset è rilasciato sotto licenza CC BY-NC-SA 4.0. È consentito usarlo solo per fini non commerciali attribuendo la fonte originale.

ISTALLAZIONE ED ESECUZIONE:

1. Clona il repository

'''bash
git clone https://github.com/samuelefagone5-cmyk/SQL-PROGETTO-PORTFOLIO.git

2. Scarica il dataset da Kaggle e posiziona i file CSV nella cartella DATA/

3. Importa i CSV nel tuo database SQL (MySQL, PostgreSQL, SQLite, ecc.)

4. Esegui gli script SQL nella cartella SQL_QUERY/
     
- Inizia con quelli di pulizia / preparazione dati
- Successivamente quelli di esplorazione / analisi
  
5. Utilizzare DBeaver CE (o qualsiasi altro client SQL) per connetterti al database, eseguire le query e visualizzare i risultati

7. OPZIONALE: Consulta la cartella VISUAL/ per aprire i report e le dashboard create in Power BI

8. OPZIONALE: Apri i file nella cartella VISUAL/ con Power BI per consultare i report

ESEMPI DI ANALISI:

- Totale ordini per stato o regione

- Vendite totali per categoria prodotto

- Tempi medi di consegna stimati vs reali

- Metodo di pagamento più usato

- Analisi delle recensioni (punteggio medio, distribuzione)

- Top 10 prodotti e venditori

RISULTATI PRINCIPALI:

- Trend delle vendite su base temporale

- Relazioni tra prezzo, categoria e recensioni

- Distribuzione geografica di clienti e venditori

- Analisi tempi di consegna e ritardi

- Impatto delle modalità di pagamento sulle vendite

STATO DEL PROGETTO: 
- Il progetto è realizzato come portfolio didattico.

Possibili sviluppi futuri:

Ampliamento delle query SQL

Nuove visualizzazioni in Power BI

Dashboard interattive più complete

Contributi
Questo repository è pubblico e liberamente consultabile. Le eventuali modifiche proposte saranno valutate tramite pull request, ma l’originale rimane di proprietà dell’autore.

Licenza
Tutti i diritti riservati (All Rights Reserved) per il codice SQL.
Il dataset utilizzato è rilasciato sotto licenza CC BY-NC-SA 4.0 (Kaggle).




