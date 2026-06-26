json.extract! usuario, :id, :Nome, :Email, :Senha, :Status, :idDepartamento, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
