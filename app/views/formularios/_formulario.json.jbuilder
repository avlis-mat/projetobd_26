json.extract! formulario, :id, :titulo, :status, :data_inicio, :data_fim, :criado_em, :instrucoes, :destinatario, :idUsuario, :idTurma, :idModelo, :created_at, :updated_at
json.url formulario_url(formulario, format: :json)
