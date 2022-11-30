CREATE TABLE clinica (
  nome   VARCHAR(40)  NOT NULL,
  data_inaug DATE NOT NULL,
  nipc NUMERIC (9),

);

CREATE TABLE pessoas(
    nome VARCHAR(40),
    morada VARCHAR(100),
    telefone NUMERIC(12),
    nif NUMERIC(9),
    género VARCHAR(1),
    dataNascimento DATE,
    correioEletronico VARCHAR(40),

#tipo empregados(tecnico, medico) (add dat de inicio) utentes visitantes,  

    CONSTRAINT ck_genero 
        CHECK(genero=="M" or genero=="F" or genero==NULL)


);

CREATE TABLE salas (
    numero NUMERIC(3),
    piso NUMERIC (2),
    tipoEquipamento VARCHAR(100),
    numeroExamesSimultaneo NUMERIC(3),

#tipo sala de exame e internamento
):

CREATE TABLE relatorios(
    numeroSequencial NUMERIC(15),
    dataa DATE,
    parecerMedico VARCHAR(9999),
    descricaoResultados VARCHAR(500)

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


#fatura, horario, supervisor, diretor clinico, camas,