/* ON DELETE CASCADE = UM PREDIO TEM QUARTOS, SE ELIMINARES UM PREDIO, OS QUARTOS DO PREDIO TAMBEM SE ELIMINAM*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS clinica
DROP TABLE IF EXISTS clTemHo
DROP TABLE IF EXISTS horario
DROP TABLE IF EXISTS CLTemSa
DROP TABLE IF EXISTS SaTemCa
DROP TABLE IF EXISTS exame
DROP TABLE IF EXISTS salainternamento
DROP TABLE IF EXISTS salaexame
DROP TABLE IF EXISTS fatura
DROP TABLE IF EXISTS internamento
DROP TABLE IF EXISTS relatorio
DROP TABLE IF EXISTS tecnico
DROP TABLE IF EXISTS medico
DROP TABLE IF EXISTS especialidade
DROP TABLE IF EXISTS diretorclinico
DROP TABLE IF EXISTS reResponsaveis
DROP TABLE IF EXISTS meReportaDC
SET FOREIGN_KEY_CHECKS=1;


CREATE TABLE clinica (
    
    nome   VARCHAR(40) UNIQUE,
    data_inaug DATE NOT NULL,
    email VARCHAR(40),
    duracao DATE,
    nipc INTEGER(9),
    phonum INTEGER(12),
    morada VARCHAR(40),

    PRIMARY KEY (nipc)

);


/*Unsure*/
/*Clinica - Horario*/
CREATE TABLE clTemHo(
    
    tipo VARCHAR(1) NOT NULL,
    nipc INTEGER(9),

    PRIMARY KEY (nipc),
    FOREIGN KEY (tipo) REFERENCES horario(tipo),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc)

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
    FOREIGN KEY (nipc) REFERENCES clinica(nipc),
    FOREIGN KEY (numerosala) REFERENCES sala(numerosala)

);

/*IS A salaexame/salainternamento*/
CREATE TABLE sala (
    numerosala INTEGER(4),
    piso INTEGER(2),
    numeroExamesSimultaneo INTEGER(3),
    tipo_geral VARCHAR(13),

    PRIMARY KEY (numerosala)

);

CREATE TABLE salaexame (
    numerosala INTEGER(4),

    PRIMARY KEY (numerosala),
    FOREIGN KEY (numerosala) REFERENCES sala(numerosala) ON DELETE CASCADE

);


CREATE TABLE salainternamento (
    tipo VARCHAR(20),
    nmaxcamas INTEGER(3),
    nmaxvisitas INTEGER(3),
    numerosala INTEGER(4),

    PRIMARY KEY (numerosala),
    FOREIGN KEY (numerosala) REFERENCES sala(numerosala) ON DELETE CASCADE

);

/*Salainternamento - Cama*/
CREATE TABLE SaTemCa(
    numerosala INTEGER(4),
    numerocama INTEGER(5),

    PRIMARY KEY (numerosala,numerocama),
    FOREIGN KEY (numerosala) REFERENCES salainternamento(numerosala),
    FOREIGN KEY (numerocama) REFERENCES cama(numerocama)
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
    FOREIGN KEY (nipc) REFERENCES clinica(nipc),
    FOREIGN KEY (nif) REFERENCES supervisor(nif)
);

/*Unsure*/
CREATE TABLE supervisor(
    nif INTEGER(9)

    PRIMARY KEY(NIF),
    FOREIGN KEY(NIF) REFERENCES pessoas(nif) ON DELETE NO ACTION

);



/* -----------------------------------------------------------------------------*/


/*exame - clinica*/
CREATE TABLE exTemCl(
    codigo NUMERIC(10),
    nipc INTEGER(9),

    PRIMARY KEY (codigo,nipc),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc) ON DELETE CASCADE,
    FOREIGN KEY (codigo) REFERENCES exame(codigo) ON DELETE CASCADE
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
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_sequencial) ON DELETE CASCADE
);

/*fatura - internamento */
CREATE TABLE faEfetuaIn(
    n_squencial NUMERIC(10),

    PRIMARY KEY (n_squencial),
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_sequencial)
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




/*IS A cliente/empregado*/
CREATE TABLE pessoa (

    nome VARCHAR(40),
    data_nasc DATE,
    email VARCHAR(40),
    nif INTEGER(9),
    phonenumber INTEGER(12),
    morada VARCHAR(40),
    genero VARCHAR(1),
    nic INTEGER(9),

    PRIMARY KEY (nif)

);


/*IS A pessoa*/
/*IS A visitante/utente*/
CREATE TABLE cliente (

    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES pessoa(nif) ON DELETE CASCADE

);


/*IS A cliente*/
/*IS A voluntario/naovoluntario*/
CREATE TABLE visitante (
    
    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES cliente(nif) ON DELETE CASCADE
);


/*IS A visitante*/
CREATE TABLE voluntario(

    nVisitasSolidarias INTEGER(4),
    nif INTEGER(9),

    PRIMARY KEY(nif),
    FOREIGN KEY (nif) REFERENCES visitante(nif) ON DELETE CASCADE
);


/*IS A visitante*/
CREATE TABLE naovoluntario (

    nif INTEGER(9),

    PRIMARY KEY(nif),
    FOREIGN KEY(nif) REFERENCES visitante(nif) ON DELETE CASCADE
);

/*naovoluntario - utente*/
CREATE TABLE nvRelacaocomUt(
    
    nvnif INTEGER(9),
    utnif INTEGER(9),

    PRIMARY KEY(nvnif,utnif),
    FOREIGN KEY (nvnif) REFERENCES naovoluntario(nif),
    FOREIGN KEY (utnif) REFERENCES utente(nif)
);

/*IS A cliente*/
CREATE TABLE utente (

    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES cliente(nif) ON DELETE CASCADE

);


/*Utente - medico*/
CREATE TABLE utTemMedico(

    utnif INTEGER(9),
    mednif INTEGER(9) NOT NULL,

    PRIMARY KEY(utnif),
    FOREIGN KEY (utnif) REFERENCES utente(nif),
    FOREIGN KEY (mednif) REFERENCES medico(nif)

);

/*IS A pessoa*/
/*IS A medico/empregado*/
CREATE TABLE empregado (
    
    nif INTEGER(9),
    datainicio DATE,

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES pessoa(nif) ON DELETE CASCADE

);


/*IS A empregado*/
CREATE TABLE medico (

    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES empregado(nif) ON DELETE CASCADE

);


/*Unfinished*/
/*medico - diretorclinico*/
CREATE TABLE meReportaDC(
    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES empregado(nif) ON DELETE CASCADE
);


/*Unfinished*/
/*especialidade - medico*/
CREATE TABLE esTemMedico(
    nome VARCHAR(20),

);


/*Unfinished*/
CREATE TABLE especialidade(
    nome VARCHAR(10),
    sigla VARCHAR(10),
    parecer VARCHAR(122),
    numseq NUMERIC(3),
    resdec VARCHAR(122),



);


/*Unfinished*/
/*relatorio - especialidade*/
CREATE TABLE re_Responsaveis_Es(
    nome_espec VARCHAR(40) REFERENCES especialidade(nome),
    num_seq INTEGER(10) REFERENCES relatorio(nsequencial)




);


CREATE TABLE relatorio(
    dat DATE,
    tipoexame VARCHAR(20),
    parecerMedico VARCHAR(100),
    descricaoresultados VARCHAR(200),
    nsequencial INTEGER(10),
    medicoresponsavel INTEGER(9),    /*Unsure*/

    PRIMARY KEY(nsequencial),
    FOREIGN KEY (medicoresponsavel) REFERENCES medico(nif) ON DELETE NO ACTION 
);



/*IS A empregado*/
CREATE TABLE tecnico (
    
    nif INTEGER(9),
    datainiciohab DATE,
    habilitacao VARCHAR(30),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES empregado(nif) ON DELETE CASCADE

);


/*Unsure*/
/*IS A empregado*/
CREATE TABLE diretorclinico (

    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES empregado(nif) ON DELETE CASCADE
);





/* comandos para inserir dados */ 
INSERT INTO clinica (nome,data_inaug,email,duracao,nipc,phonum,morada)
VALUES ("Care4u", "2022-01-02", "coisas","2022-01-02", 999222111, 916234543,"rua do céu nº77");
INSERT INTO clTemHo (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
INSERT INTO ClTemSa (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);