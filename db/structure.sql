CREATE TABLE "Materia" 
( 
 "id" SERIAL PRIMARY KEY,  
 "nome" VARCHAR,  
 "codigo" VARCHAR,  
 "semestre" VARCHAR,  
 "id_departamento" INT
); 

CREATE TABLE "Questao" 
( 
 "id" SERIAL PRIMARY KEY,  
 "enunciado" VARCHAR,  
 "versao" VARCHAR,  
 "atualizado_em" TIMESTAMP,  
 "status" VARCHAR,  
 "criado_em" TIMESTAMP  
); 

CREATE TABLE "Modelo" 
( 
 "id" SERIAL PRIMARY KEY,  
 "id_usuario" INT,  
 "nome" VARCHAR,  
 "descricao" VARCHAR,  
 "criado_em" TIMESTAMP,  
 "atualizado_em" TIMESTAMP,  
 "versao" VARCHAR,  
 "status" VARCHAR 
); 

CREATE TABLE "Formulario" 
( 
 "id" SERIAL PRIMARY KEY,  
 "id_modelo" INT,  
 "status" VARCHAR,  
 "data_inicio" DATE,  
 "data_fim" DATE,  
 "criado_em" TIMESTAMP,  
 "titulo" VARCHAR,  
 "instrucoes" VARCHAR,  
 "destinatario" VARCHAR,  
 "id_usuario" INT,
"id_turma" INT
); 

CREATE TABLE "Resposta" 
( 
 "id" SERIAL PRIMARY KEY,  
 "id_aluno" INT,  
 "id_formulario" INT,  
 "conteudo" VARCHAR,  
 "respondido_em" TIMESTAMP,
 "id_questao" INT
); 

CREATE TABLE "Usuario" 
( 
 "id" SERIAL PRIMARY KEY,  
 "nome" VARCHAR,  
 "email" VARCHAR,  
 "senha" VARCHAR,  
 "status" VARCHAR,  
 "id_departamento" INT  
); 

CREATE TABLE "Aluno" 
( 
 "id_usuario" INT PRIMARY KEY,  
 "matricula" VARCHAR,  
 "tipo_graduacao" VARCHAR,  
 "semestre" VARCHAR
); 

CREATE TABLE "Admin" 
( 
 "id_usuario" INT PRIMARY KEY,  
 "nivel_acesso" VARCHAR
); 

CREATE TABLE "Turma" 
( 
 "id" SERIAL PRIMARY KEY,  
 "id_materia" INT,  
 "turno" VARCHAR,  
 "horario" VARCHAR,  
 "codigo" INT  
); 

CREATE TABLE "Professor" 
( 
 "id_usuario" INT PRIMARY KEY,  
 "data_contratacao" DATE  
); 

CREATE TABLE "Modelo_Questao" 
( 
 "id_questao" INT,  
 "id_modelo" INT,
PRIMARY KEY ("id_questao", "id_modelo")  
); 

CREATE TABLE "Aluno_Turma" 
( 
 "id_turma" INTEGER,  
 "id_aluno" INTEGER,
PRIMARY KEY ("id_turma", "id_aluno")  
); 

CREATE TABLE "Professor_Turma" 
( 
 "id_professor" INTEGER,  
 "id_turma" INTEGER,
PRIMARY KEY ("id_professor", "id_turma")  
); 

CREATE TABLE "Admin_Turma" 
( 
 "id_turma" INTEGER,  
 "id_admin" INTEGER,
PRIMARY KEY ("id_turma", "id_admin")  
); 

CREATE TABLE "Departamento" 
( 
 "codigo" SERIAL PRIMARY KEY,  
 "nome" VARCHAR  
); 

ALTER TABLE "Materia" ADD FOREIGN KEY("id_departamento") REFERENCES "Departamento" ("codigo");
ALTER TABLE "Modelo" ADD FOREIGN KEY("id_usuario") REFERENCES "Usuario" ("id");
ALTER TABLE "Formulario" ADD FOREIGN KEY("id_modelo") REFERENCES "Modelo" ("id");
ALTER TABLE "Formulario" ADD FOREIGN KEY("id_usuario") REFERENCES "Usuario" ("id");
ALTER TABLE "Formulario" ADD FOREIGN KEY("id_turma") REFERENCES "Turma" ("id");
ALTER TABLE "Resposta" ADD FOREIGN KEY("id_aluno") REFERENCES "Aluno" ("id_usuario");
ALTER TABLE "Resposta" ADD FOREIGN KEY("id_formulario") REFERENCES "Formulario" ("id");
ALTER TABLE "Usuario" ADD FOREIGN KEY("id_departamento") REFERENCES "Departamento" ("codigo");
ALTER TABLE "Aluno" ADD FOREIGN KEY("id_usuario") REFERENCES "Usuario" ("id");
ALTER TABLE "Admin" ADD FOREIGN KEY("id_usuario") REFERENCES "Usuario" ("id");
ALTER TABLE "Turma" ADD FOREIGN KEY("id_materia") REFERENCES "Materia" ("id");
ALTER TABLE "Professor" ADD FOREIGN KEY("id_usuario") REFERENCES "Usuario" ("id");
ALTER TABLE "Modelo_Questao" ADD FOREIGN KEY("id_questao") REFERENCES "Questao" ("id");
ALTER TABLE "Modelo_Questao" ADD FOREIGN KEY("id_modelo") REFERENCES "Modelo" ("id");
ALTER TABLE "Resposta" ADD FOREIGN KEY("id_questao") REFERENCES "Questao" ("id");
ALTER TABLE "Aluno_Turma" ADD FOREIGN KEY("id_turma") REFERENCES "Turma" ("id");
ALTER TABLE "Aluno_Turma" ADD FOREIGN KEY("id_aluno") REFERENCES "Aluno" ("id_usuario");
ALTER TABLE "Professor_Turma" ADD FOREIGN KEY("id_professor") REFERENCES "Professor" ("id_usuario");
ALTER TABLE "Professor_Turma" ADD FOREIGN KEY("id_turma") REFERENCES "Turma" ("id");
ALTER TABLE "Admin_Turma" ADD FOREIGN KEY("id_turma") REFERENCES "Turma" ("id");
ALTER TABLE "Admin_Turma" ADD FOREIGN KEY("id_admin") REFERENCES "Admin" ("id_usuario");

/*Registros*/

INSERT INTO Departamento (Codigo, Nome) VALUES
(1, 'Ciência da Computação'),
(2, 'Engenharia Civil'),
(3, 'Administração'),
(4, 'Design Gráfico'),
(5, 'Matemática Aplicada');

INSERT INTO Usuario (ID, Nome, Email, Senha, Status, idDepartamento) VALUES
(1, 'João Silva', 'joao.silva@email.com', 'senha123', 'Ativo', 1),
(2, 'Maria Santos', 'maria.santos@email.com', 'senha456', 'Ativo', 2),
(3, 'Carlos Lima', 'carlos.lima@email.com', 'senha789', 'Ativo', 3),
(4, 'Ana Pereira', 'ana.pereira@email.com', 'senhaabc', 'Inativo', 4),
(5, 'Pedro Costa', 'pedro.costa@email.com', 'senhaxyz', 'Ativo', 5);

INSERT INTO Admin (idUsuario, nv_acesso) VALUES
(1, 'Super'),
(2, 'Moderador'),
(3, 'Super'),
(4, 'Moderador'),
(5, 'Básico');

INSERT INTO Professor (idUsuario, dt_contratação) VALUES
(1, '2020-01-15'),
(2, '2019-03-20'),
(3, '2021-06-10'),
(4, '2018-11-05'),
(5, '2022-02-28');

INSERT INTO Aluno (idUsuario, Matricula, tipo_graduacao, semestre) VALUES
(1, '20210001', 'Bacharelado', '8'),
(2, '20210002', 'Licenciatura', '6'),
(3, '20210003', 'Bacharelado', '4'),
(4, '20210004', 'Tecnólogo', '2'),
(5, '20210005', 'Bacharelado', '10');

INSERT INTO Materia (ID, Nome, Codigo, semestre, idDepartamento) VALUES
(1, 'Algoritmos', 'ALG-101', '1', 1),
(2, 'Estruturas de Dados', 'EST-201', '2', 1),
(3, 'Cálculo I', 'CAL-101', '1', 5),
(4, 'Física I', 'FIS-101', '2', 2),
(5, 'Marketing Digital', 'MKT-201', '3', 3);

INSERT INTO Turma (ID, idMateria, Turno, Horario, codigo) VALUES
(1, 1, 'Manhã', '08:00-10:00', 101),
(2, 2, 'Tarde', '14:00-16:00', 102),
(3, 3, 'Manhã', '10:00-12:00', 103),
(4, 4, 'Noite', '19:00-21:00', 104),
(5, 5, 'Tarde', '16:00-18:00', 105);

INSERT INTO Questao (ID, enunciado, versao, atualizado_em, status, criado_em) VALUES
(1, 'O que é um algoritmo?', '1.0', '2026-01-15 10:30:00', 'Publicada', '2026-01-10 08:00:00'),
(2, 'Explique o conceito de herança em POO', '2.1', '2026-01-16 14:20:00', 'Rascunho', '2026-01-12 09:30:00'),
(3, 'Calcule o limite de f(x) quando x tende a 0', '1.2', '2026-01-14 11:15:00', 'Publicada', '2026-01-11 10:00:00'),
(4, 'Descreva o que é a primeira lei de Newton', '1.0', '2026-01-13 16:45:00', 'Publicada', '2026-01-13 10:00:00'),
(5, 'Como funciona o marketing de conteúdo?', '1.1', '2026-01-17 09:00:00', 'Rascunho', '2026-01-15 13:30:00');

INSERT INTO Modelo (ID, idAdmin, Nome, descricao, criado_em, atualizado_em, versao, status) VALUES
(1, 1, 'Avaliação Básica', 'Modelo para avaliações iniciais', '2026-01-10 08:00:00', '2026-01-10 08:00:00', '1.0', 'Ativo'),
(2, 2, 'Prova Intermediária', 'Modelo para provas do meio do semestre', '2026-01-12 10:00:00', '2026-01-15 14:00:00', '1.1', 'Ativo'),
(3, 1, 'Trabalho Final', 'Modelo para trabalhos de conclusão', '2026-01-14 09:30:00', '2026-01-16 16:20:00', '2.0', 'Rascunho'),
(4, 3, 'Questionário Rápido', 'Questionários de 5 perguntas', '2026-01-15 11:00:00', '2026-01-15 11:00:00', '1.0', 'Ativo'),
(5, 4, 'Prova de Recuperação', 'Modelo para provas de recuperação', '2026-01-16 13:00:00', '2026-01-17 15:30:00', '1.0', 'Ativo');

INSERT INTO Formulario (ID, idModelo, status, data_inicio, data_fim, criado_em, titulo, instrucoes, destinatario, idProfessor, idTurma) VALUES
(1, 1, 'Aberto', '2026-01-20', '2026-01-27', '2026-01-19 10:00:00', 'Avaliação de Algoritmos', 'Leia atentamente cada questão', 'Alunos do 1º ano', 1, 1),
(2, 2, 'Fechado', '2026-01-15', '2026-01-22', '2026-01-14 09:00:00', 'Prova de Estruturas de Dados', 'Respostas devem ser justificadas', 'Alunos do 2º ano', 2, 2),
(3, 3, 'Rascunho', '2026-01-25', '2026-02-01', '2026-01-24 14:30:00', 'Trabalho de Cálculo', 'Entregar em formato digital', 'Alunos do 1º ano', 3, 3),
(4, 4, 'Aberto', '2026-01-18', '2026-01-25', '2026-01-17 11:15:00', 'Questionário de Física', 'Verdadeiro ou Falso', 'Alunos do 2º ano', 4, 4),
(5, 5, 'Agendado', '2026-02-01', '2026-02-08', '2026-01-20 16:00:00', 'Prova de Marketing', 'Estudar capítulos 1-5', 'Alunos do 3º ano', 5, 5);

INSERT INTO Resposta (ID, idAluno, idFormulario, conteudo, respondido_em, idQuestao) VALUES
(1, 1, 1, 'Um algoritmo é uma sequência finita de passos para resolver um problema.', '2026-01-20 08:15:00', 1),
(2, 2, 2, 'Herança é um mecanismo onde uma classe herda atributos de outra.', '2026-01-16 09:30:00', 2),
(3, 3, 3, 'lim x→0 f(x) = 1 usando regra de LHopital', '2026-01-25 10:20:00', 3),
(4, 4, 4, 'A primeira lei de Newton é a lei da inércia.', '2026-01-18 14:45:00', 4),
(5, 5, 5, 'Marketing de conteúdo cria valor através de informações relevantes.', '2026-02-01 08:00:00', 5);

INSERT INTO Aluno_Turma (idTurma, idAluno) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Professor_Turma (idProfessor, idTurma) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Admin_Turma (idTurma, idAdmin) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 4);

INSERT INTO Modelo_Questao (idQuestao, idModelo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
