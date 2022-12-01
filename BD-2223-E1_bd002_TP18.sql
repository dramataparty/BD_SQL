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


CREATE TABLE horario(
   tipo VARCHAR(1),
   horainicio TIME,
   horafim TIME
   
);

/*IS A is already done i think*/
CREATE TABLE sala (
    numero NUMERIC(3),
    piso INTEGER(2),
    numeroExamesSimultaneo INTEGER(3),
    tipo_geral VARCHAR(13)

    PRIMARY KEY (numero)

);

CREATE TABLE salaexame (
    numero NUMERIC(3),

    PRIMARY KEY (numero),
    FOREIGN KEY (numero) REFERENCES sala ON DELETE CASCADE

);


CREATE TABLE salainternamento (
    tipo VARCHAR(20),
    nmaxcamas INTEGER(3),
    nmaxvisitas INTEGER(3),
    numero NUMERIC(3)

    PRIMARY KEY (numero),
    FOREIGN KEY (numero) REFERENCES sala ON DELETE CASCADE

);

CREATE TABLE cama (
    num INTEGER(3)

    PRIMARY KEY (num)

);


/*Unsure*/
CREATE TABLE supervisor(
    NIF INTEGER(9)

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


CREATE TABLE exame (
  sigla VARCHAR(10)
  tipo VARCHAR(40)
  prec_normal NUMERIC(6,2)
  codigo NUMERIC(10)
  prec_hora_urg NUMERIC(6,2)
  periodo_tempo DATE

  PRIMARY KEY (codigo)
CREATE TABLE fatura (
    cus_total NUMERIC(999),
    cus_ex NUMERIC(999),
    cus_d_i_e NUMERIC(999),
    dat_pag DATE
    n_squencial NUMERIC(10)

    PRIMARY KEY (n_squencial)
CREATE TABLE internamento(
    periodoInternamento DATE,
    maxVisitantes NUMERIC(2),
    n_camas NUMERIC(2)
    especialidade WARCHAR(40)
    medico_respon WARCHAR(40)


/* -----------------------------------------------------------------------------*/



/* comandos para inserir dados */ 
