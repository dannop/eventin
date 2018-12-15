PagSeguro.configure do |config|
  config.token       = "783D697EA7E1481E831A8B5BA76FE096"
  config.email       = "daniellsf@id.uff.br"
  config.environment = :sandbox # ou :sandbox. O padrão é production.
  config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end