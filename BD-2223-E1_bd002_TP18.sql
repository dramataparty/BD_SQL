CREATE TABLE clinica (
  nome   VARCHAR(40)  NOT NULL,
  data_inaug DATE NOT NULL,
  nipc NUMERIC (9),
  phonum NUMERIC(9)


);

CREATE TABLE pessoas(
    nome VARCHAR(40),
    morada VARCHAR(100),
    telefone NUMERIC(12),
    nif NUMERIC(9),
    género VARCHAR(1),
    dataNascimento DATE,
    correioEletronico VARCHAR(40),

/*tipo empregados(tecnico, medico) (add dat de inicio) utentes visitantes,  
*/
    CONSTRAINT ck_genero 
        CHECK(genero="M" or genero="F" or genero=NULL)


);

CREATE TABLE salas (
    numero NUMERIC(3),
    piso NUMERIC (2),
    numeroExamesSimultaneo NUMERIC(3),
    tipo_geral VARCHAR(13)

/*tipo sala de exame e internamento*/
);

CREATE TABLE relatorios(
    numeroSequencial NUMERIC(15),
    data DATE,
    parecerMedico VARCHAR(999),
    descricaoResultados VARCHAR(500),
    parec_med VARCHAR(100),
    tipoex VARCHAR(20),
);

CREATE TABLE especialidades(
    nome VARCHAR(40),
    sigla VARCHAR(10),
    precoDiarioInternamento NUMERIC(9),

);


CREATE TABLE internamento(
    inicioInternamento DATE,
    maxVisitantes NUMERIC(2),


);


CREATE TABLE exameDiagnostico(
    codigo NUMERIC(10),
    sigla VARCHAR(10),
    precoNormal NUMERIC(9),
    tipo VARCHAR(30),
    periodoTempo TIME,
    precoUrgencia NUMERIC(9), 


);

CREATE TABLE horario(
   horarioA = SET (4) ,
   horarioB = SET (4) /*o que raio é um horario*/
   /* SET ? Talvez?? */
);
CREATE TABLE fatsup (
/*fatura, supervisor, diretor clinico, camas,*/
);
