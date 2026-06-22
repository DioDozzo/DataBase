Si vuole progettare una base di dati per la gestione dei dipartimenti di una data università.
Innanzitutto, si vuole mantenere traccia della composizione di ogni dipartimento. 
Ogni dipartimento ha uno e un solo direttore e uno o più altri afferenti (escludiamo dipartimenti che annoverino un solo afferente). 
Gli afferenti vengono suddivisi in professori e ricercatori. I professori sono caratterizzati da codice fiscale, nome, cognome, data e luogo di nascita, fascia (professore di prima fascia o professore di seconda fascia). 
Il direttore è scelto fra i professori di prima fascia che afferiscono al dipartimento (si assuma che in ogni dipartimento vi sia almeno un professore di prima fascia). 
I ricercatori sono identificati da codice fiscale, nome, cognome, data e luogo di nascita, status (confermato o non confermato). 
Ogni afferente afferisce ad un unico dipartimento. Tutti i membri di un dipartimento hanno come recapito (via, numero civico) il recapito del dipartimento. 
Ne segue che gli afferenti di un dato dipartimento hanno tutti lo stesso recapito. 
Dipartimenti diversi possono condividere lo stesso recapito. Di ogni afferente si vuole memorizzare il titolo di studio di più alto grado posseduto (laurea o dottorato di ricerca). 
Dei laureati si il vuole tener traccia dell'università presso la quale si sono laureati e del punteggio conseguito. Dei dottori di ricerca si vuole conoscere l'università presso la quale hanno conseguito il titolo e il relatore della loro tesi di dottorato. 
Gli afferenti di un dipartimento si suddividono vidon ini affferenti a tempo pieno (afferenti che non svolgono attività extra-universitaria) e afferenti a tempo parziale (afferenti che svolgono attività extra-universitaria). 
Infine, vogliamo mantenere informazioni sui corsi tenuti dagli afferenti. Si tenga presente che ogni afferente tiene almeno un corso e, in generale, può tenere più corsi. Vi possono inoltre essere dei corsi tenuti congiuntamente da più docenti.
Si definisca uno schema Entità-Relazioni che descriva il contenuto informativo del sistema, illustrando con chiarezza le eventuali assunzioni fatte. Lo schema dovrà essere completato con attributi ragionevoli per ciascuna entità (identificando le possibili chiavi) e relazione. 
Vanno specificati accuratamente i vincoli di cardinalità e partecipazione di ciascuna relazione
