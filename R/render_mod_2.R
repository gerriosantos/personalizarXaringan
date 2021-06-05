


# Gerar apenas um relatório por muicípio ----

rmarkdown::render(
  input = here::here('exemplo_params', 'mod_2.Rmd'),
  params = list(mun = 'Municipio'),
  output_file = glue::glue('relatorio_', '.html')
)



# Gerar relatórios HTML para cada uma das opçoes de parametros

  # mun <- dplyr::pull(unique(dados['Municipio']))

mun <- c("Coreaú-CE", "Sobral-CE")

purrr::map(
  .x = mun,
  .f = ~ rmarkdown::render(
    here::here('exemplo_params', 'mod_2.Rmd'),
    params = list(mun = .x),
    output_file = paste0(.x, '.html')
  )
)

# Salvar os htmls em pdf (usando pagedown)
purrr::map(
  .x = mun,
  .f = ~ pagedown::chrome_print(
    input = here::here('exemplo_params', paste0(.x, '.html')),
    browser = 'C:/Users/gerri/AppData/Local/Google/Chrome/Application/chrome.exe'
  )
)











