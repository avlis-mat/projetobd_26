json.extract! modelo, :id, :Nome, :Descricao, :Versao, :Status, :Criado_em, :Atualizado_em, :idUsuario, :created_at, :updated_at
json.url modelo_url(modelo, format: :json)
