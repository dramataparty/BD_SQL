CREATE TABLE clinica (
    
    nome   VARCHAR(40) UNIQUE,
    data_inaug DATE NOT NULL,
    email VARCHAR(40),
    duracao DATE,
    nipc INTEGER(9),
    phonum INTEGER(12),
    morada VARCHAR(40)

    PRIMARY KEY (nipc)

);


/*Unsure*/
/*Clinica - Horario*/
CREATE TABLE ClTemHo(
    
    tipo VARCHAR(1) NOT NULL,
    nipc INTEGER(9),

    PRIMARY KEY (nipc),
    FOREIGN KEY (tipo) REFERENCES horario,
    FOREIGN KEY (nipc) REFERENCES clinica

);


CREATE TABLE horario(
   tipo VARCHAR(1),
   horainicio TIME,
   horafim TIME
   
);

/*Clinica - Sala*/
CREATE TABLE ClTemSa(
    
    nipc INTEGER(9),
    numerosala INTEGER(4),

    PRIMARY KEY (nipc,numero),
    FOREIGN KEY (nipc) REFERENCES clinica,
    FOREIGN KEY (numerosala) REFERENCES sala

);

/*IS A is already done i think*/
CREATE TABLE sala (
    numerosala INTEGER(4),
    piso INTEGER(2),
    numeroExamesSimultaneo INTEGER(3),
    tipo_geral VARCHAR(13)

    PRIMARY KEY (numerosala)

);

CREATE TABLE salaexame (
    numerosala INTEGER(4),

    PRIMARY KEY (numerosala),
    FOREIGN KEY (numerosala) REFERENCES sala ON DELETE CASCADE

);


CREATE TABLE salainternamento (
    tipo VARCHAR(20),
    nmaxcamas INTEGER(3),
    nmaxvisitas INTEGER(3),
    numerosala INTEGER(4)

    PRIMARY KEY (numerosala),
    FOREIGN KEY (numerosala) REFERENCES sala ON DELETE CASCADE

);

/*Salainternamento - Cama*/
CREATE TABLE SaTemCa(
    numerosala INTEGER(4),
    numerocama INTEGER(5),

    PRIMARY KEY (numerosala,numerocama),
    FOREIGN KEY (numerosala) REFERENCES salainternamento,
    FOREIGN KEY (numerocama) REFERENCES cama
);


CREATE TABLE cama (
    numerocama INTEGER(5)

    PRIMARY KEY (numerocama)

);

/*Clinica - Supervisor*/
CREATE TABLE ClTrabalhaSu(
    nipc INTEGER(9),
    nif INTEGER(9),

    PRIMARY KEY (nipc,nif),
    FOREIGN KEY (nipc) REFERENCES clinica,
    FOREIGN KEY (nif) REFERENCES supervisor
);

/*Unsure*/
CREATE TABLE supervisor(
    nif INTEGER(9)

    PRIMARY KEY(NIF),
    FOREIGN KEY(NIF) REFERENCES pessoas

);


CREATE TABLE relatorio(
    dat DATE,
    tipoexame VARCHAR(20),
    parecerMedico VARCHAR(100),
    descricaoresultados VARCHAR(200),
    nsequencial INTEGER(10),
    medicoresponsavel VARCHAR(30),    /*Unsure*/

    PRIMARY KEY(nsequencial)
);



/* -----------------------------------------------------------------------------*/


/*exame - clinica*/
CREATE TABLE exTemCl(
    codigo NUMERIC(10),
    nipc INTEGER(9),

    PRIMARY KEY (codigo,nipc),
    FOREIGN KEY (nipc) REFERENCES clinica ON DELETE CASCADE,
    FOREIGN KEY (codigo) REFERENCES exame ON DELETE CASCADE
);

CREATE TABLE exame (
  sigla VARCHAR(10),
  tipo VARCHAR(40),
  prec_normal NUMERIC(6,2),
  codigo NUMERIC(10),
  prec_hora_urg NUMERIC(6,2),
  periodo_tempo DATE,

  PRIMARY KEY (codigo)
);

CREATE TABLE fatura (
    cus_total NUMERIC(6,2),
    cus_ex NUMERIC(6,2),
    cus_d_i_e NUMERIC(6,2),
    dat_pag DATE,
    n_squencial NUMERIC(10),

    PRIMARY KEY (n_squencial),
    FOREIGN KEY (n_squencial) REFERENCES internamento ON DELETE CASCADE
);

/*fatura - internamento */
CREATE TABLE faEfetuaIn(
    n_squencial NUMERIC(10),

    PRIMARY KEY (n_squencial),
    FOREIGN KEY (n_squencial) REFERENCES internamento
)

CREATE TABLE internamento(
    periodoInternamento DATE,
    maxVisitantes NUMERIC(2),
    n_camas NUMERIC(2),
    especialidade VARCHAR(40),
    medico_respon VARCHAR(40),
    n_squencial NUMERIC(10),

    PRIMARY KEY (n_squencial)
);



/* -----------------------------------------------------------------------------*/




CREATE TABLE clientes (
    nome   VARCHAR(40) UNIQUE,
    data_nasc DATE NOT NULL,
    email VARCHAR(40),
    nif INTEGER(9),
    phonum INTEGER(12),
    morada VARCHAR(40), 
    genero VARCHAR(1),
    tipo VARCHAR(10),

    PRIMARY KEY (nif),
    PRIMARY KEY (tipo),
    voluntario Boolean(1)

);

CREATE TABLE empregados (
    nome   VARCHAR(40) UNIQUE,
    data_nasc DATE NOT NULL,
    data_inic DATE NOT NULL,
    email VARCHAR(40),
    nif INTEGER(9),
    phonum INTEGER(12),
    morada VARCHAR(40), 
    genero VARCHAR(1),
    tipo VARCHAR(10),

    PRIMARY KEY (nif),
    PRIMARY KEY (tipo)

);


CREATE TABLE medicos (
    nome   VARCHAR(40) UNIQUE,
    data_nasc DATE NOT NULL,
    data_inic DATE NOT NULL,
    email VARCHAR(40),
    nif INTEGER(9),
    phonum INTEGER(12),
    morada VARCHAR(40), 
    genero VARCHAR(1),
    tipo VARCHAR(10),

    PRIMARY KEY (nif),
    FOREIGN KEY (tipo) REFERENCES empregados on DELETE CASCADE

);

CREATE TABLE tecnicos (
    nome   VARCHAR(40) UNIQUE,
    data_nasc DATE NOT NULL,
    data_inic DATE NOT NULL,
    email VARCHAR(40),
    nif INTEGER(9),
    phonum INTEGER(12),
    morada VARCHAR(40), 
    genero VARCHAR(1),
    tipo VARCHAR(10),

    PRIMARY KEY (nif),
    FOREIGN KEY (tipo) REFERENCES empregados on DELETE CASCADE

);

CREATE TABLE especialidades(
    nome VARCHAR(40) NOT NULL,
    sigla VARCHAR(10) NOT NULL,
    precoDiarioInternamento INTEGER(9) NOT NULL,
    PRIMARY KEY(sigla)

);



/* comandos para inserir dados */ 
