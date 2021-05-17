

library(tidyverse)
library(extrafont)



dados <- haven::read_dta('data-raw/DadosISS_bimestral.dta') %>%
  mutate(Bimestre = case_when(
    Bimestre == 1 ~ '1˚ Bim',
    Bimestre == 2 ~ '2˚ Bim',
    Bimestre == 3 ~ '3˚ Bim',
    Bimestre == 4 ~ '4˚ Bim',
    Bimestre == 5 ~ '5˚ Bim',
    Bimestre == 6 ~ '6˚ Bim'
  ),
  iss19 = round(ISS19/pop19, 2),
  iss20 = round(ISS20/pop19, 2),
  Municipio = base::paste(substring(Municipio, 4), substr(Municipio,1,2), sep = '-')) %>%
  select(Municipio, Bimestre, 'ISS por Habitante 2019' = iss19, 'ISS por Habitante 2020' = iss20) %>%
  pivot_longer(cols = !Municipio:Bimestre, names_to = 'iss', values_to = 'iss_pop') %>%
  filter(Municipio %in% c('Coreaú-CE', 'Sobral-CE'))

## Uma forma bruta de gerar somente um relatório para cada município.


for(mun in unique(dados$Municipio)){

  df_mun <- dados %>% dplyr::filter(Municipio == mun)
  nome_html <- paste0('apresentacao_', mun, '.html')
  #nome_rmd <- paste0('apresentacao_', mun)

  # adiciona o nome_municipio ao titulo do slide com title = `r nome_municipio`
  nome_municipio = mun

  rmarkdown::render('data-raw/mod_1.Rmd',
                    output_file = nome_html,
                    'xaringan::moon_reader')
  # Transformar em pdf ou png (default é pdf)
  # pagedown::chrome_print(input = here::here('data-raw', nome_html),
  #                        browser = 'C:/Users/gerri/AppData/Local/Google/Chrome/Application/chrome.exe')
}

# Só consegue gerar em pdf uma um. Dentro do loop não gera.
pagedown::chrome_print(input = here::here('data-raw', 'apresentacao_Sobral-CE.html'),
                       browser = 'C:/Users/gerri/AppData/Local/Google/Chrome/Application/chrome.exe')




