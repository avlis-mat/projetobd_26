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