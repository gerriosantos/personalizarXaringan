

library(tidyverse)
library(extrafont)


dados <- haven::read_dta('data-raw/DadosISS_bimestral.dta') %>%
  mutate(Bimestre = case_when(
    Bimestre == 1 ~ '1˚ Bimestre',
    Bimestre == 2 ~ '2˚ Bimestre',
    Bimestre == 3 ~ '3˚ Bimestre',
    Bimestre == 4 ~ '4˚ Bimestre',
    Bimestre == 5 ~ '5˚ Bimestre',
    Bimestre == 6 ~ '6˚ Bimestre'
  ),
  iss19 = round(ISS19/pop19, 2),
  iss20 = round(ISS20/pop19, 2)) %>%
  select(Municipio, Bimestre, 'ISS por Habitante 2019' = iss19, 'ISS por Habitante 2020' = iss20) %>%
  pivot_longer(cols = !Municipio:Bimestre, names_to = 'iss', values_to = 'iss_pop') %>%
  filter(Municipio %in% c('CE-Coreaú', 'CE-Sobral'))


for(mun in unique(dados$Municipio)){

  df_mun <- dados %>% dplyr::filter(Municipio == mun)
  nome_html <- paste0('apresentacao_', mun, '.html')

  # adiciona o nome_municipio ao titulo do slide com title = `r nome_municipio`
  nome_municipio = dados$Municipio[1]

  rmarkdown::render('data-raw/mod_1.Rmd',
                    output_file = nome_html,
                    'xaringan::moon_reader')
  # Transformar em pdf ou png (default é pdf)
  # pagedown::chrome_print(paste0('data-raw/', nome_html), format = 'pdf',
  #                        browser = 'C:/Users/gerri/AppData/Local/Google/Chrome/Application/chrome.exe')
}

