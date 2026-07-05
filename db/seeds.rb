# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
puts "Limpando banco..."
AdminTurma.delete_all
ProfessorTurma.delete_all
AlunoTurma.delete_all
ModeloQuestao.delete_all
Respostum.delete_all
Formulario.delete_all
Modelo.delete_all
Questao.delete_all
Turma.delete_all
Materium.delete_all
Admin.delete_all
Professor.delete_all
Aluno.delete_all
Usuario.delete_all
Departamento.delete_all

puts "Criando Departamentos..."
dep1 = Departamento.create!(nome: "Ciência da Computação")
dep2 = Departamento.create!(nome: "Matemática")
dep3 = Departamento.create!(nome: "Letras")
dep4 = Departamento.create!(nome: "Engenharia")
dep5 = Departamento.create!(nome: "Pedagogia")

puts "Criando Usuários..."
u1 = Usuario.create!(nome: "Alice Admin",    email: "alice@unb.br",   senha: "123456", status: "ativo", iddepartamento: dep1.codigo)
u2 = Usuario.create!(nome: "Bruno Admin",    email: "bruno@unb.br",   senha: "123456", status: "ativo", iddepartamento: dep2.codigo)
u3 = Usuario.create!(nome: "Carlos Prof",    email: "carlos@unb.br",  senha: "123456", status: "ativo", iddepartamento: dep1.codigo)
u4 = Usuario.create!(nome: "Diana Prof",     email: "diana@unb.br",   senha: "123456", status: "ativo", iddepartamento: dep3.codigo)
u5 = Usuario.create!(nome: "Eduardo Prof",   email: "eduardo@unb.br", senha: "123456", status: "ativo", iddepartamento: dep4.codigo)
u6 = Usuario.create!(nome: "Fernanda Aluna", email: "fernanda@unb.br",senha: "123456", status: "ativo", iddepartamento: dep1.codigo)
u7 = Usuario.create!(nome: "Gabriel Aluno",  email: "gabriel@unb.br", senha: "123456", status: "ativo", iddepartamento: dep2.codigo)
u8 = Usuario.create!(nome: "Helena Aluna",   email: "helena@unb.br",  senha: "123456", status: "ativo", iddepartamento: dep3.codigo)
u9 = Usuario.create!(nome: "Igor Aluno",     email: "igor@unb.br",    senha: "123456", status: "ativo", iddepartamento: dep4.codigo)
u10 = Usuario.create!(nome: "Julia Aluna",   email: "julia@unb.br",   senha: "123456", status: "ativo", iddepartamento: dep5.codigo)

puts "Criando Admins..."
Admin.create!(idusuario: u1.id, nv_acesso: "total")
Admin.create!(idusuario: u2.id, nv_acesso: "parcial")

puts "Criando Professores..."
Professor.create!(idusuario: u3.id, dt_contratacao: "2018-03-01")
Professor.create!(idusuario: u4.id, dt_contratacao: "2019-07-15")
Professor.create!(idusuario: u5.id, dt_contratacao: "2021-01-10")

puts "Criando Alunos..."
Aluno.create!(idusuario: u6.id,  matricula: "190001", tipo_graduacao: "Licenciatura", semestre: "2026/1")
Aluno.create!(idusuario: u7.id,  matricula: "190002", tipo_graduacao: "Bacharelado",  semestre: "2026/1")
Aluno.create!(idusuario: u8.id,  matricula: "190003", tipo_graduacao: "Licenciatura", semestre: "2025/2")
Aluno.create!(idusuario: u9.id,  matricula: "190004", tipo_graduacao: "Bacharelado",  semestre: "2025/2")
Aluno.create!(idusuario: u10.id, matricula: "190005", tipo_graduacao: "Licenciatura", semestre: "2026/1")

puts "Criando Matérias..."
m1 = Materium.create!(nome: "Banco de Dados",         codigo: "CIC0097", semestre: "2026/1", iddepartamento: dep1.codigo)
m2 = Materium.create!(nome: "Cálculo 1",              codigo: "MAT0025", semestre: "2026/1", iddepartamento: dep2.codigo)
m3 = Materium.create!(nome: "Literatura Brasileira",  codigo: "LET0032", semestre: "2026/1", iddepartamento: dep3.codigo)
m4 = Materium.create!(nome: "Estruturas de Dados",    codigo: "CIC0004", semestre: "2026/1", iddepartamento: dep1.codigo)
m5 = Materium.create!(nome: "Didática",               codigo: "PED0015", semestre: "2026/1", iddepartamento: dep5.codigo)

puts "Criando Turmas..."
t1 = Turma.create!(idmateria: m1.id, turno: "Noturno",   horario: "19h-21h", codigo: 1)
t2 = Turma.create!(idmateria: m2.id, turno: "Matutino",  horario: "08h-10h", codigo: 2)
t3 = Turma.create!(idmateria: m3.id, turno: "Vespertino",horario: "14h-16h", codigo: 3)
t4 = Turma.create!(idmateria: m4.id, turno: "Noturno",   horario: "21h-23h", codigo: 4)
t5 = Turma.create!(idmateria: m5.id, turno: "Matutino",  horario: "10h-12h", codigo: 5)

puts "Vinculando Professores às Turmas..."
ProfessorTurma.create!(idprofessor: u3.id, idturma: t1.id)
ProfessorTurma.create!(idprofessor: u4.id, idturma: t2.id)
ProfessorTurma.create!(idprofessor: u5.id, idturma: t3.id)
ProfessorTurma.create!(idprofessor: u3.id, idturma: t4.id)
ProfessorTurma.create!(idprofessor: u4.id, idturma: t5.id)

puts "Vinculando Alunos às Turmas..."
AlunoTurma.create!(idaluno: u6.id,  idturma: t1.id)
AlunoTurma.create!(idaluno: u7.id,  idturma: t1.id)
AlunoTurma.create!(idaluno: u8.id,  idturma: t2.id)
AlunoTurma.create!(idaluno: u9.id,  idturma: t3.id)
AlunoTurma.create!(idaluno: u10.id, idturma: t1.id)

puts "Vinculando Admins às Turmas..."
AdminTurma.create!(idadmin: u1.id, idturma: t1.id)
AdminTurma.create!(idadmin: u1.id, idturma: t2.id)
AdminTurma.create!(idadmin: u2.id, idturma: t3.id)
AdminTurma.create!(idadmin: u2.id, idturma: t4.id)
AdminTurma.create!(idadmin: u1.id, idturma: t5.id)

puts "Criando Questões..."
q1 = Questao.create!(enunciado: "Como avalia a didática do professor?",         versao: "1.0", status: "ativo", criado_em: Time.now)
q2 = Questao.create!(enunciado: "O conteúdo foi bem explicado?",                versao: "1.0", status: "ativo", criado_em: Time.now)
q3 = Questao.create!(enunciado: "O professor foi pontual?",                     versao: "1.0", status: "ativo", criado_em: Time.now)
q4 = Questao.create!(enunciado: "As aulas foram organizadas?",                  versao: "1.0", status: "ativo", criado_em: Time.now)
q5 = Questao.create!(enunciado: "Você recomendaria esta disciplina?",           versao: "1.0", status: "ativo", criado_em: Time.now)
q6 = Questao.create!(enunciado: "O professor estava disponível para dúvidas?",  versao: "1.0", status: "ativo", criado_em: Time.now)

puts "Criando Modelos..."
mod1 = Modelo.create!(idusuario: u1.id, nome: "Avaliação Padrão",  descricao: "Modelo base de avaliação semestral", versao: "1.0", status: "ativo", criado_em: Time.now, atualizado_em: Time.now)
mod2 = Modelo.create!(idusuario: u2.id, nome: "Avaliação Rápida",  descricao: "Modelo curto com 3 questões",        versao: "1.0", status: "ativo", criado_em: Time.now, atualizado_em: Time.now)
mod3 = Modelo.create!(idusuario: u1.id, nome: "Avaliação Completa",descricao: "Modelo completo com 6 questões",     versao: "1.0", status: "ativo", criado_em: Time.now, atualizado_em: Time.now)

puts "Vinculando Questões aos Modelos..."
ModeloQuestao.create!(idmodelo: mod1.id, idquestao: q1.id)
ModeloQuestao.create!(idmodelo: mod1.id, idquestao: q2.id)
ModeloQuestao.create!(idmodelo: mod1.id, idquestao: q3.id)
ModeloQuestao.create!(idmodelo: mod2.id, idquestao: q1.id)
ModeloQuestao.create!(idmodelo: mod2.id, idquestao: q4.id)
ModeloQuestao.create!(idmodelo: mod2.id, idquestao: q5.id)
ModeloQuestao.create!(idmodelo: mod3.id, idquestao: q1.id)
ModeloQuestao.create!(idmodelo: mod3.id, idquestao: q2.id)
ModeloQuestao.create!(idmodelo: mod3.id, idquestao: q3.id)
ModeloQuestao.create!(idmodelo: mod3.id, idquestao: q4.id)
ModeloQuestao.create!(idmodelo: mod3.id, idquestao: q5.id)
ModeloQuestao.create!(idmodelo: mod3.id, idquestao: q6.id)

puts "Criando Formulários..."
f1 = Formulario.create!(idusuario: u3.id, idturma: t1.id, idmodelo: mod1.id, titulo: "Avaliação BD 2026/1",       status: "aberto",    data_inicio: "2026-06-01", data_fim: "2026-07-10", criado_em: Time.now, instrucoes: "Responda com sinceridade.", destinatario: "alunos")
f2 = Formulario.create!(idusuario: u4.id, idturma: t2.id, idmodelo: mod2.id, titulo: "Avaliação Cálculo 2026/1", status: "aberto",    data_inicio: "2026-06-01", data_fim: "2026-07-10", criado_em: Time.now, instrucoes: "Avalie a disciplina.",    destinatario: "alunos")
f3 = Formulario.create!(idusuario: u5.id, idturma: t3.id, idmodelo: mod3.id, titulo: "Avaliação Letras 2026/1",  status: "encerrado", data_inicio: "2026-05-01", data_fim: "2026-05-31", criado_em: Time.now, instrucoes: "Feedback do semestre.",   destinatario: "alunos")
f4 = Formulario.create!(idusuario: u3.id, idturma: t4.id, idmodelo: mod1.id, titulo: "Avaliação ED 2026/1",      status: "aberto",    data_inicio: "2026-06-15", data_fim: "2026-07-15", criado_em: Time.now, instrucoes: "Avalie o professor.",     destinatario: "alunos")
f5 = Formulario.create!(idusuario: u1.id, idturma: t5.id, idmodelo: mod2.id, titulo: "Avaliação Didática",       status: "aberto",    data_inicio: "2026-06-20", data_fim: "2026-07-20", criado_em: Time.now, instrucoes: "Avaliação institucional.", destinatario: "alunos")

puts "Criando Respostas..."
Respostum.create!(idaluno: u6.id,  idformulario: f1.id, idquestao: q1.id, conteudo: "Excelente didática!")
Respostum.create!(idaluno: u6.id,  idformulario: f1.id, idquestao: q2.id, conteudo: "Conteúdo bem explicado.")
Respostum.create!(idaluno: u7.id,  idformulario: f1.id, idquestao: q1.id, conteudo: "Boa didática, poderia melhorar.")
Respostum.create!(idaluno: u7.id,  idformulario: f1.id, idquestao: q2.id, conteudo: "Sim, foi bem explicado.")
Respostum.create!(idaluno: u10.id, idformulario: f1.id, idquestao: q1.id, conteudo: "Muito bom!")
Respostum.create!(idaluno: u8.id,  idformulario: f2.id, idquestao: q1.id, conteudo: "Professor muito atencioso.")

puts "Seeds concluídos com sucesso!"
puts "Usuário para login: alice@unb.br | senha: 123456"