
# Aqui, é preciso dar library no `keyring` -- apos gerar esse code
# vai sair uma caixinha para colocar um nome, coloca um diferente do `id`.

library(keyring)

blastula::create_smtp_creds_key(
  id = 'gmail',
  provider = 'gmail',
  user =  'gerriosantos@gmail.com',
  host = 'smtp.gmail.com',
  port = 465,
  use_ssl = TRUE
)

