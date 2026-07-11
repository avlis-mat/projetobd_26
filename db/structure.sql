SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: atualizar_status_resposta(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.atualizar_status_resposta() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.respondido_em = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: atualizar_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.atualizar_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: encerrar_formularios_vencidos(); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.encerrar_formularios_vencidos()
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE public.formulario
  SET status = 'encerrado'
  WHERE data_fim < CURRENT_DATE AND status != 'encerrado';
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    idusuario integer NOT NULL,
    nv_acesso character varying
);


--
-- Name: admin_turma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_turma (
    idturma integer NOT NULL,
    idadmin integer NOT NULL
);


--
-- Name: aluno; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aluno (
    idusuario integer NOT NULL,
    matricula character varying,
    tipo_graduacao character varying,
    semestre character varying
);


--
-- Name: aluno_turma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aluno_turma (
    idturma integer NOT NULL,
    idaluno integer NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: departamento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departamento (
    codigo integer NOT NULL,
    nome character varying
);


--
-- Name: departamento_codigo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.departamento_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departamento_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.departamento_codigo_seq OWNED BY public.departamento.codigo;


--
-- Name: formulario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.formulario (
    id integer NOT NULL,
    idmodelo integer,
    status character varying,
    data_inicio date,
    data_fim date,
    criado_em timestamp without time zone,
    titulo character varying,
    instrucoes character varying,
    destinatario character varying,
    idusuario integer,
    idturma integer,
    anexo_binario bytea,
    anexo_binario_nome character varying,
    anexo_binario_tipo character varying
);


--
-- Name: formulario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.formulario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: formulario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.formulario_id_seq OWNED BY public.formulario.id;


--
-- Name: materia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.materia (
    id integer NOT NULL,
    nome character varying,
    codigo character varying,
    semestre character varying,
    iddepartamento integer
);


--
-- Name: materia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.materia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: materia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.materia_id_seq OWNED BY public.materia.id;


--
-- Name: modelo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modelo (
    id integer NOT NULL,
    idusuario integer,
    nome character varying,
    descricao character varying,
    criado_em timestamp without time zone,
    atualizado_em timestamp without time zone,
    versao character varying,
    status character varying
);


--
-- Name: modelo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.modelo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modelo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.modelo_id_seq OWNED BY public.modelo.id;


--
-- Name: modelo_questao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modelo_questao (
    idquestao integer NOT NULL,
    idmodelo integer NOT NULL
);


--
-- Name: professor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professor (
    idusuario integer NOT NULL,
    dt_contratacao date
);


--
-- Name: professor_turma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.professor_turma (
    idprofessor integer NOT NULL,
    idturma integer NOT NULL
);


--
-- Name: questao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questao (
    id integer NOT NULL,
    enunciado character varying,
    versao character varying,
    atualizado_em timestamp without time zone,
    status character varying,
    criado_em timestamp without time zone,
    idusuario integer
);


--
-- Name: questao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questao_id_seq OWNED BY public.questao.id;


--
-- Name: resposta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resposta (
    id integer NOT NULL,
    idaluno integer,
    idformulario integer,
    conteudo character varying,
    respondido_em timestamp without time zone,
    idquestao integer
);


--
-- Name: resposta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.resposta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resposta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.resposta_id_seq OWNED BY public.resposta.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: turma; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.turma (
    id integer NOT NULL,
    idmateria integer,
    turno character varying,
    horario character varying,
    codigo integer
);


--
-- Name: turma_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.turma_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: turma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.turma_id_seq OWNED BY public.turma.id;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome character varying,
    email character varying,
    senha character varying,
    status character varying,
    iddepartamento integer
);


--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- Name: vw_formularios_turma; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_formularios_turma AS
 SELECT t.id AS turma_id,
    t.turno,
    m.nome AS materia,
    count(f.id) AS total_formularios,
    avg(
        CASE
            WHEN ((f.status)::text = 'encerrado'::text) THEN 1
            ELSE 0
        END) AS taxa_encerramento
   FROM ((public.turma t
     JOIN public.materia m ON ((m.id = t.idmateria)))
     LEFT JOIN public.formulario f ON ((f.idturma = t.id)))
  GROUP BY t.id, t.turno, m.nome;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: departamento codigo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departamento ALTER COLUMN codigo SET DEFAULT nextval('public.departamento_codigo_seq'::regclass);


--
-- Name: formulario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulario ALTER COLUMN id SET DEFAULT nextval('public.formulario_id_seq'::regclass);


--
-- Name: materia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materia ALTER COLUMN id SET DEFAULT nextval('public.materia_id_seq'::regclass);


--
-- Name: modelo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modelo ALTER COLUMN id SET DEFAULT nextval('public.modelo_id_seq'::regclass);


--
-- Name: questao id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questao ALTER COLUMN id SET DEFAULT nextval('public.questao_id_seq'::regclass);


--
-- Name: resposta id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta ALTER COLUMN id SET DEFAULT nextval('public.resposta_id_seq'::regclass);


--
-- Name: turma id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turma ALTER COLUMN id SET DEFAULT nextval('public.turma_id_seq'::regclass);


--
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (idusuario);


--
-- Name: admin_turma admin_turma_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_turma
    ADD CONSTRAINT admin_turma_pkey PRIMARY KEY (idturma, idadmin);


--
-- Name: aluno aluno_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aluno
    ADD CONSTRAINT aluno_pkey PRIMARY KEY (idusuario);


--
-- Name: aluno_turma aluno_turma_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT aluno_turma_pkey PRIMARY KEY (idturma, idaluno);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (codigo);


--
-- Name: formulario formulario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulario
    ADD CONSTRAINT formulario_pkey PRIMARY KEY (id);


--
-- Name: materia materia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materia
    ADD CONSTRAINT materia_pkey PRIMARY KEY (id);


--
-- Name: modelo modelo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modelo
    ADD CONSTRAINT modelo_pkey PRIMARY KEY (id);


--
-- Name: modelo_questao modelo_questao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modelo_questao
    ADD CONSTRAINT modelo_questao_pkey PRIMARY KEY (idquestao, idmodelo);


--
-- Name: professor professor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (idusuario);


--
-- Name: professor_turma professor_turma_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_turma
    ADD CONSTRAINT professor_turma_pkey PRIMARY KEY (idprofessor, idturma);


--
-- Name: questao questao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questao
    ADD CONSTRAINT questao_pkey PRIMARY KEY (id);


--
-- Name: resposta resposta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta
    ADD CONSTRAINT resposta_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: turma turma_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turma
    ADD CONSTRAINT turma_pkey PRIMARY KEY (id);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: modelo trg_modelo_atualizado_em; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_modelo_atualizado_em BEFORE UPDATE ON public.modelo FOR EACH ROW EXECUTE FUNCTION public.atualizar_timestamp();


--
-- Name: questao trg_questao_atualizado_em; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_questao_atualizado_em BEFORE UPDATE ON public.questao FOR EACH ROW EXECUTE FUNCTION public.atualizar_timestamp();


--
-- Name: resposta trg_respondido_em; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_respondido_em BEFORE INSERT ON public.resposta FOR EACH ROW EXECUTE FUNCTION public.atualizar_status_resposta();


--
-- Name: admin admin_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES public.usuario(id);


--
-- Name: admin_turma admin_turma_idadmin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_turma
    ADD CONSTRAINT admin_turma_idadmin_fkey FOREIGN KEY (idadmin) REFERENCES public.admin(idusuario);


--
-- Name: admin_turma admin_turma_idturma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_turma
    ADD CONSTRAINT admin_turma_idturma_fkey FOREIGN KEY (idturma) REFERENCES public.turma(id);


--
-- Name: aluno aluno_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aluno
    ADD CONSTRAINT aluno_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES public.usuario(id);


--
-- Name: aluno_turma aluno_turma_idaluno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT aluno_turma_idaluno_fkey FOREIGN KEY (idaluno) REFERENCES public.aluno(idusuario);


--
-- Name: aluno_turma aluno_turma_idturma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT aluno_turma_idturma_fkey FOREIGN KEY (idturma) REFERENCES public.turma(id);


--
-- Name: questao fk_rails_38e894f928; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questao
    ADD CONSTRAINT fk_rails_38e894f928 FOREIGN KEY (idusuario) REFERENCES public.usuario(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: formulario formulario_idmodelo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulario
    ADD CONSTRAINT formulario_idmodelo_fkey FOREIGN KEY (idmodelo) REFERENCES public.modelo(id);


--
-- Name: formulario formulario_idturma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulario
    ADD CONSTRAINT formulario_idturma_fkey FOREIGN KEY (idturma) REFERENCES public.turma(id);


--
-- Name: formulario formulario_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formulario
    ADD CONSTRAINT formulario_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES public.usuario(id);


--
-- Name: materia materia_iddepartamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materia
    ADD CONSTRAINT materia_iddepartamento_fkey FOREIGN KEY (iddepartamento) REFERENCES public.departamento(codigo);


--
-- Name: modelo modelo_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modelo
    ADD CONSTRAINT modelo_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES public.usuario(id);


--
-- Name: modelo_questao modelo_questao_idmodelo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modelo_questao
    ADD CONSTRAINT modelo_questao_idmodelo_fkey FOREIGN KEY (idmodelo) REFERENCES public.modelo(id);


--
-- Name: modelo_questao modelo_questao_idquestao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modelo_questao
    ADD CONSTRAINT modelo_questao_idquestao_fkey FOREIGN KEY (idquestao) REFERENCES public.questao(id);


--
-- Name: professor professor_idusuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_idusuario_fkey FOREIGN KEY (idusuario) REFERENCES public.usuario(id);


--
-- Name: professor_turma professor_turma_idprofessor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_turma
    ADD CONSTRAINT professor_turma_idprofessor_fkey FOREIGN KEY (idprofessor) REFERENCES public.professor(idusuario);


--
-- Name: professor_turma professor_turma_idturma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.professor_turma
    ADD CONSTRAINT professor_turma_idturma_fkey FOREIGN KEY (idturma) REFERENCES public.turma(id);


--
-- Name: resposta resposta_idaluno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta
    ADD CONSTRAINT resposta_idaluno_fkey FOREIGN KEY (idaluno) REFERENCES public.aluno(idusuario);


--
-- Name: resposta resposta_idformulario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta
    ADD CONSTRAINT resposta_idformulario_fkey FOREIGN KEY (idformulario) REFERENCES public.formulario(id);


--
-- Name: resposta resposta_idquestao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resposta
    ADD CONSTRAINT resposta_idquestao_fkey FOREIGN KEY (idquestao) REFERENCES public.questao(id);


--
-- Name: turma turma_idmateria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turma
    ADD CONSTRAINT turma_idmateria_fkey FOREIGN KEY (idmateria) REFERENCES public.materia(id);


--
-- Name: usuario usuario_iddepartamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_iddepartamento_fkey FOREIGN KEY (iddepartamento) REFERENCES public.departamento(codigo);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260709004533'),
('20260706234910'),
('20260704234942');

