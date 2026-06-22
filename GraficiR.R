library(igraph)
library(tibble)

library("RColorBrewer")

library(readr)
library(plyr)
library(dplyr)

library(ggplot2)
library(plotly)

#------------------------------------------------------------------------------
library(readr)
afferente <- read_csv("~/Desktop/basi_di_dati (1).csv")
View(afferente)

#rinomino le colonne con nomi facili per r
afferente <- rename(afferente, CF=CODICE_FISCALE, NASCITA=DATA_NASCITA, LUOGONATO=LUOGO_NASCITA, TITOLO=TITOLO_STUDIO, NOMEDIP=NOME_DIPARTIMENTO)

#------------------------------------------------------------------------------

library(readr)
corso <- read_csv("~/Desktop/basi_di_dati (2).csv")
View(corso)


#suddivisione dei corsi in base alla loro durata e al tipo di laurea
ggplot(corso, aes(x = factor(ORE), fill = LAUREA)) +
  geom_bar(position = "dodge", color = "black") +
  labs(title = "Numero di corsi per durata e tipo di laurea",
       x = "Durata del corso (ore)",
       y = "Numero di corsi",
       fill = "Tipo di laurea") +
  theme_minimal()

#------------------------------------------------------------------------------

library(readr)
dipartimento <- read_csv("~/Desktop/basi_di_dati (3).csv")
View(dipartimento)

#------------------------------------------------------------------------------

library(readr)
richiede <- read_csv("~/Desktop/basi_di_dati (4).csv")
View(richiede)

richiede %>%
  left_join(corso, by = c("ID_CORSO" = "ID")) %>%
  left_join(corso, by = c("ID_CORSO_RICHIESTO" = "ID"), suffix = c("_corso", "_richiesto")) %>%
  select(NOME_corso, LAUREA_corso, NOME_richiesto, LAUREA_richiesto)

#------------------------------------------------------------------------------
library(readr)
tiene <- read_csv("~/Desktop/basi_di_dati (5).csv")
View(tiene)

# Distribuzione del numero di corsi per docente
docente_corsi_freq <- tiene %>%
  count(CODICE_FISCALE) %>%          
  count(n, name = "n_docenti")       

ggplot(docente_corsi_freq, aes(x = n, y = n_docenti)) +
  geom_col(fill = "lightblue") +
  geom_text(aes(label = n_docenti), vjust = -0.5, size = 4) +
  scale_x_continuous(breaks = seq(min(docente_corsi_freq$n), max(docente_corsi_freq$n), by = 1)) +
  labs(
    title = "Distribuzione del numero di corsi per docente",
    x = "Numero di corsi tenuti",
    y = "Numero di docenti"
  ) +
  theme_minimal()

#distribuzione dei corsi per dipartimento
tiene_dip <- tiene %>%
  left_join(afferente %>% select(CF, NOMEDIP), by = c("CODICE_FISCALE" = "CF"))
corsi_dip <- tiene_dip %>%
  left_join(corso, by = "ID")
corsi_per_dip <- corsi_dip %>%
  group_by(NOMEDIP) %>%
  summarise(numero_corsi = n_distinct(ID)) %>%
  arrange(desc(numero_corsi))

#corsi propedeutici per dipartimento e tipo di laurea
corsi_propedeutici_ids <- unique(richiede$ID_CORSO_RICHIESTO)
corsi_prop <- corso %>% 
  filter(ID %in% corsi_propedeutici_ids)
docenti_corsi_prop <- tiene %>%
  filter(ID %in% corsi_propedeutici_ids)
docenti_corsi_prop <- docenti_corsi_prop %>%
  left_join(afferente %>% select(CF, NOMEDIP), by = c("CODICE_FISCALE" = "CF"))
docenti_corsi_prop <- docenti_corsi_prop %>%
  left_join(corsi_prop %>% select(ID, LAUREA), by = "ID")
conteggio <- docenti_corsi_prop %>%
  distinct(ID, NOMEDIP, LAUREA) %>%   # evitiamo doppioni dovuti a più docenti per corso
  group_by(NOMEDIP, LAUREA) %>%
  summarise(n_corsi_prop = n()) %>%
  ungroup()

ggplot(conteggio, aes(x = reorder(NOMEDIP, n_corsi_prop), y = n_corsi_prop, fill = LAUREA)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Numero di corsi propedeutici per dipartimento e tipo di laurea",
       x = "Dipartimento",
       y = "Numero di corsi propedeutici",
       fill = "Tipo di laurea") +
  theme_minimal()

conteggio_pct <- conteggio %>%
  group_by(NOMEDIP) %>%
  mutate(pct = n_corsi_prop / sum(n_corsi_prop) * 100)

ggplot(conteggio_pct, aes(x = NOMEDIP, y = pct, fill = LAUREA)) +
  geom_col(position = "fill") +
  coord_flip() +
  labs(title = "Percentuale di corsi propedeutici per tipo di laurea",
       x = "Dipartimento",
       y = "Percentuale",
       fill = "Tipo di laurea") +
  theme_minimal()

