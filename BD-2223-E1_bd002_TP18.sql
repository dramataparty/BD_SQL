SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS clinica;
DROP TABLE IF EXISTS clTemHo;
DROP TABLE IF EXISTS horario;
DROP TABLE IF EXISTS CLTemSa;
DROP TABLE IF EXISTS SaTemCa;
DROP TABLE IF EXISTS exame;
DROP TABLE IF EXISTS salainternamento;
DROP TABLE IF EXISTS salaexame;
DROP TABLE IF EXISTS fatura;
DROP TABLE IF EXISTS internamento;
DROP TABLE IF EXISTS relatorio;
DROP TABLE IF EXISTS tecnico;
DROP TABLE IF EXISTS medico;
DROP TABLE IF EXISTS especialidade;
DROP TABLE IF EXISTS diretorclinico;
DROP TABLE IF EXISTS reResponsaveis;
DROP TABLE IF EXISTS meReportaDC;
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

CREATE TABLE horario(
   tipo VARCHAR(1),
   horainicio TIME,
   horafim TIME
   
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




CREATE TABLE cama (
    numerocama INTEGER(5)

    PRIMARY KEY (numerocama)

);


CREATE TABLE supervisor(
    nif INTEGER(9)

    PRIMARY KEY(nif),
    FOREIGN KEY(nif) REFERENCES pessoas(nif) ON DELETE NO ACTION

);




/* -----------------------------------------------------------------------------*/



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
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_squencial) ON DELETE CASCADE
);



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


/*IS A cliente*/
CREATE TABLE utente (

    nif INTEGER(9),

    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES cliente(nif) ON DELETE CASCADE

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




CREATE TABLE especialidade(
    nome VARCHAR(10),
    sigla VARCHAR(10),
    parecer VARCHAR(122),
    numseq NUMERIC(3),
    resdec VARCHAR(122),
    
    PRIMARY KEY (nome)
);




CREATE TABLE relatorio(
    dat DATE,
    tipoexame VARCHAR(20),
    parecerMedico VARCHAR(100),
    descricaoresultados VARCHAR(200),
    nsquencial INTEGER(10),
    medicoresponsavel INTEGER(9),    /*Unsure*/

    PRIMARY KEY(nsquencial),
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






/*Associaões---------------------------------------------*/



/*naovoluntario - utente*/
CREATE TABLE nvRelacaocomUt(
    
    nvnif INTEGER(9),
    utnif INTEGER(9),

    PRIMARY KEY(nvnif,utnif),
    FOREIGN KEY (nvnif) REFERENCES naovoluntario(nif),
    FOREIGN KEY (utnif) REFERENCES utente(nif)
);


/*Clinica - Horario*/
CREATE TABLE clTemHo(
    
    tipo VARCHAR(1) NOT NULL,
    nipc INTEGER(9),

    PRIMARY KEY (nipc),
    FOREIGN KEY (tipo) REFERENCES horario(tipo),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc)

);



/*Salainternamento - Cama*/
CREATE TABLE SaTemCa(
    numerosala INTEGER(4),
    numerocama INTEGER(5),

    PRIMARY KEY (numerosala,numerocama),
    FOREIGN KEY (numerosala) REFERENCES salainternamento(numerosala),
    FOREIGN KEY (numerocama) REFERENCES cama(numerocama)
);

/*Clinica - Supervisor*/
CREATE TABLE ClTrabalhaSu(
    nipc INTEGER(9),
    nif INTEGER(9),

    PRIMARY KEY (nipc,nif),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc),
    FOREIGN KEY (nif) REFERENCES supervisor(nif)
);
/*Utente - medico*/
CREATE TABLE utTemMedico(

    utnif INTEGER(9),
    mednif INTEGER(9) NOT NULL,

    PRIMARY KEY(utnif),
    FOREIGN KEY (utnif) REFERENCES utente(nif),
    FOREIGN KEY (mednif) REFERENCES medico(nif)

);
/*exame - clinica*/
CREATE TABLE exTemCl(
    codigo NUMERIC(10),
    nipc INTEGER(9),

    PRIMARY KEY (codigo,nipc),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc) ON DELETE CASCADE,
    FOREIGN KEY (codigo) REFERENCES exame(codigo) ON DELETE CASCADE
);

/*fatura - internamento */
CREATE TABLE faEfetuaIn(
    n_squencial NUMERIC(10),

    PRIMARY KEY (n_squencial),
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_squencial)
);





/*medico - diretorclinico*/
CREATE TABLE meReportaDC(
    nifmed INTEGER(9),
    nifdc INTEGER(9),

    PRIMARY KEY (nifmed,nifdc),
    FOREIGN KEY (nifmed) REFERENCES medico(nif),
    FOREIGN KEY (nifdc) REFERENCES diretorclinico(nif)
);



/*Utente - medico*/
CREATE TABLE utTemMedico(

    utnif INTEGER(9),
    mednif INTEGER(9) NOT NULL,

    PRIMARY KEY(utnif),
    FOREIGN KEY (utnif) REFERENCES utente(nif),
    FOREIGN KEY (mednif) REFERENCES medico(nif)

);


/*naovoluntario - utente*/
CREATE TABLE nvRelacaocomUt(
    
    nvnif INTEGER(9),
    utnif INTEGER(9),

    PRIMARY KEY(nvnif,utnif),
    FOREIGN KEY (nvnif) REFERENCES naovoluntario(nif),
    FOREIGN KEY (utnif) REFERENCES utente(nif)
);


/*exame - clinica*/
CREATE TABLE exTemCl(
    codigo NUMERIC(10),
    nipc INTEGER(9),

    PRIMARY KEY (codigo,nipc),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc) ON DELETE CASCADE,
    FOREIGN KEY (codigo) REFERENCES exame(codigo) ON DELETE CASCADE
);




/*Clinica - Sala*/
CREATE TABLE ClTemSa(
    
    nipc INTEGER(9),
    numerosala INTEGER(4),

    PRIMARY KEY (nipc,numero),
    FOREIGN KEY (nipc) REFERENCES clinica(nipc),
    FOREIGN KEY (numerosala) REFERENCES sala(numerosala)

);

/*salainternamento - internamento*/
CREATE TABLE siOcorreIn(

    numerosala INTEGER(4),
    n_squencial NUMERIC(10),

    PRIMARY KEY (numerosala,n_squencial),
    FOREIGN KEY (numerosala) REFERENCES salainternamento(numerosala),
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_squencial)

);


/*visitante - internamento*/
CREATE TABLE viVisitaIn(
    
    periodo_tempo TIME,
    carater_visita VARCHAR(50),
    n_squencial NUMERIC(10),
    nif INTEGER(9),

    PRIMARY KEY (n_squencial,nif),
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_squencial),
    FOREIGN KEY (nif) REFERENCES visitante(nif)
);


/*utente - internamento*/
CREATE TABLE utInternadoIn(
    
    n_squencial NUMERIC(10),
    nif INTEGER(9),

    PRIMARY KEY (n_squencial,nif),
    FOREIGN KEY (n_squencial) REFERENCES internamento(n_squencial),
    FOREIGN KEY (nif) REFERENCES utente(nif)
);


/*medico - supervisor*/
CREATE TABLE meReportaSu(
    nifsu INTEGER(9),
    nifmed INTEGER(9),

    PRIMARY KEY (nifsu,nifmed),
    FOREIGN KEY (nifsu) REFERENCES supervisor(nif),
    FOREIGN KEY (nifmed) REFERENCES medico(nif)
);

/*medico - especialidade*/

CREATE TABLE meTemEs(

    Data_inicio DATE,
    nome VARCHAR(10),
    nifmed INTEGER(9),

    PRIMARY KEY (nome,nifmed),
    FOREIGN KEY (nome) REFERENCES especialidade(nome),
    FOREIGN KEY (nifmed) REFERENCES medico(nif)
);

/*relatorio - especialidade*/
CREATE TABLE reResponsaveisEs(
    nsequencial INTEGER(10),
    nome VARCHAR(10),

    PRIMARY KEY (nsequencial,nome),
    FOREIGN KEY (nome) REFERENCES especialidade(nome),
    FOREIGN Key (nsequencial) REFERENCES relatorio(nsequencial)
);

/*relatorio - exame*/
CREATE TABLE reRealizacaoEx(
    nsequencial INTEGER(10),
    codigo INTEGER(10),

    PRIMARY KEY (nsequencial,codigo),
    FOREIGN KEY (codigo) REFERENCES exame(codigo),
    FOREIGN Key (nsequencial) REFERENCES relatorio(nsequencial)
);

/*medico - exame*/
CREATE TABLE mePrescreveEx(
    nif INTEGER(9),
    codigo INTEGER(10),

    PRIMARY KEY (nif,codigo),
    FOREIGN KEY (nif) REFERENCES medico(nif),
    FOREIGN KEY (codigo) REFERENCES exame(codigo)
);

/*tecnico - exame*/
CREATE TABLE teFazEx(
    codigo INTEGER(10),
    nif INTEGER(9),

    PRIMARY KEY (nif,codigo),
    FOREIGN KEY (nif) REFERENCES tecnico(nif),
    FOREIGN KEY (codigo) REFERENCES exame(codigo)
);

/*sala de exame - exame*/
CREATE TABLE sExRealizadosEx(
    numerosala INTEGER(4),
    codigo INTEGER(10),

    PRIMARY KEY (nif,numerosala),
    FOREIGN KEY (numerosala) REFERENCES salaexame(numerosala),
    FOREIGN KEY (codigo) REFERENCES exame(codigo)
);

/*sala de Internamento - exame*/
CREATE TABLE sInRealizadosEx(
    numerosala INTEGER(4),
    codigo INTEGER(10),

    PRIMARY KEY (nif,numerosala),
    FOREIGN KEY (numerosala) REFERENCES salainternamento(numerosala),
    FOREIGN KEY (codigo) REFERENCES exame(codigo)
);




INSERT INTO clinica (nome,data_inaug,email,duracao,nipc,phonum,morada)
VALUES ("Care4u", "2022-01-02", "coisas1","2022-01-02", 999222111, 916234543,"rua do céu nº77")
INSERT INTO clinica (nome,data_inaug,email,duracao,nipc,phonum,morada)
VALUES ("Care3u", "2022-01-03", "coisas2","2022-01-03", 333222111, 916234544,"rua do céu nº66")
INSERT INTO clinica (nome,data_inaug,email,duracao,nipc,phonum,morada)
VALUES ("Care2u", "2022-01-04", "coisas3","2022-01-04", 111222333, 916234545,"rua do céu nº55")


INSERT INTO cama (numerocama)
VALUES (34)
INSERT INTO cama (numerocama)
VALUES (43)
INSERT INTO cama (numerocama)
VALUES (12)

INSERT INTO horario(tipo, horainicio,horafim)
VALUES ("E",14,16)
INSERT INTO horario(tipo, horainicio,horafim)
VALUES ("I",16,14)
INSERT INTO horario(tipo, horainicio,horafim)
VALUES ("E",1,2)

INSERT INTO empregado (NIF,datainicio)
VALUES (443229004,"2022-01-02")
INSERT INTO empregado (NIF,datainicio)
VALUES (123456789,"2022-01-03")
INSERT INTO empregado (NIF,datainicio)
VALUES (987654321,"2022-01-04")

INSERT INTO medico(nif)
VALUE(443229004)
INSERT INTO medico(nif)
VALUE(123456789)
INSERT INTO medico(nif)
VALUE(987654321)

INSERT INTO Supervisor(NIF)
VALUES (443229004)
INSERT INTO Supervisor(NIF)
VALUES (567890123)
INSERT INTO Supervisor(NIF)
VALUES (123456789)

INSERT INTO internamento(periodoInternamento,maxVisitantes,n_camas,especialidade,medico_respon,num_seq)
VALUES ("2022-01-02",2,2,2,1234321)
INSERT INTO internamento(periodoInternamento,maxVisitantes,n_camas,especialidade,medico_respon,num_seq)
VALUES ("2022-01-02",2,2,2,2345432)
INSERT INTO internamento(periodoInternamento,maxVisitantes,n_camas,especialidade,medico_respon,num_seq)
VALUES ("2022-01-02",2,2,2,3456543)

INSERT INTO relatorio(dat,tipoexame,parecerMedico,descricaoresultados,nsequencial,medicoresponsavel)
VALUES ("2022-01-02","Otorrino","uhhhh nariz com macacos lol","macacos removidos",7664335793,"Doutor Obama Care")
INSERT INTO relatorio(dat,tipoexame,parecerMedico,descricaoresultados,nsequencial,medicoresponsavel)
VALUES ("2022-01-03","Colonoscopia","gelado preso","gelado removido",456789123,"Doutor Joe Biden")
INSERT INTO relatorio(dat,tipoexame,parecerMedico,descricaoresultados,nsequencial,medicoresponsavel)
VALUES ("2022-01-01","Urinologia","infeccção renal","rim removido",123456789,"Doutor Oh Klaoma")

INSERT INTO sala(numerosala,piso,numeroExamesSimultaneo,tipo_geral)
VALUES (29,2,3,"Internamento")
INSERT INTO sala(numerosala,piso,numeroExamesSimultaneo,tipo_geral)
VALUES (92,3,2,"Exame")
INSERT INTO sala(numerosala,piso,numeroExamesSimultaneo,tipo_geral)
VALUES (34,1,2,"Internamento")

INSERT INTO salaexame(numerosala)
VALUES (31)
INSERT INTO salaexame(numerosala)
VALUES (92)
INSERT INTO salaexame(numerosala)
VALUES (13)

INSERT INTO salainternamento(numerosala)
VALUES ("Quarto",1,2,29)
INSERT INTO salainternamento(numerosala)
VALUES ("Quarto",3,1,2)
INSERT INTO salainternamento(numerosala)
VALUES ("Quarto",2,3,34)


INSERT INTO cama(numerocama)
VALUES (20)
INSERT INTO cama(numerocama)
VALUES (12)
INSERT INTO cama(numerocama)
VALUES (30)

INSERT INTO supervisor(NIF)
VALUE (245687324)
INSERT INTO supervisor(NIF)
VALUE (123456789)
INSERT INTO supervisor(NIF)
VALUE (987654321)


INSERT INTO pessoa(nome,data_nasc,nif,phonenumber,morada,genero,nic)
VALUE ("Tó","1999-09-09",019283746,980230450,"Rua T","M",456123789)
INSERT INTO pessoa(nome,data_nasc,nif,phonenumber,morada,genero,nic)
VALUE ("Zé","1999-09-10",657483829,980230451,"Rua Z","M",456123790)
INSERT INTO pessoa(nome,data_nasc,nif,phonenumber,morada,genero,nic)
VALUE ("Armindo","1999-09-11",925678923,980230452,"Rua A","M",456123791)


INSERT INTO utente(NIF)
VALUE(019283746)
INSERT INTO utente(NIF)
VALUE(657483829)
INSERT INTO utente(NIF)
VALUE(925678923)

INSERT INTO clTemHo (tipo,nipc)
VALUES ("E",892553228)

INSERT INTO clTemHo (tipo,nipc)
VALUES ("N",892553228)

INSERT INTO clTemHo (tipo,nipc)
VALUES ("U",892553228)

INSERT INTO ClTemSa (nipc,numsala)
VALUES (443229004,2020)
INSERT INTO ClTemSa (nipc,numsala)
VALUES (32178945,2021)
INSERT INTO ClTemSa (nipc,numsala)
VALUES (23456789,2022)

INSERT INTO SaTemCa (numerosala,numerocama)
VALUES(20,34)
INSERT INTO SaTemCa (numerosala,numerocama)
VALUES(12,43)
INSERT INTO SaTemCa (numerosala,numerocama)
VALUES(30,12)

INSERT INTO reResponsaveisEs(nsequencial,nome)
VALUES(5423879,"T")
INSERT INTO reResponsaveisEs(nsequencial,nome)
VALUES(9183452,"E")
INSERT INTO reResponsaveisEs(nsequencial,nome)
VALUES(2456356,"M")

INSERT INTO ClTrabalhaSu(nipc,nif)
VALUES(999222111,443229004)
INSERT INTO ClTrabalhaSu(nipc,nif)
VALUES(333222111,123456789)
INSERT INTO ClTrabalhaSu(nipc,nif)
VALUES(111222333,567890123)


INSERT INTO utTemMedico(utnif,mednif)
VALUES(019283746,443229004)
INSERT INTO utTemMedico(utnif,mednif)
VALUES(657483829,123456789)
INSERT INTO utTemMedico(utnif,mednif)
VALUES(925678923,987654321)


INSERT INTO meReportaSu(nifsu,nifmed)
VALUES(245687324,443229004)
INSERT INTO meReportaSu(nifsu,nifmed)
VALUES(123456789,987654321)

INSERT INTO clTemHo(tipo,nipc)
VALUES("T",999222111)
INSERT INTO clTemHo(tipo,nipc)
VALUES("E",333222111)
INSERT INTO clTemHo(tipo,nipc)
VALUES("M",111222333)


INSERT INTO internamento(periodoInternamento,maxVisitantes,n_camas,especialidade,medico_respon,n_sequencial)
VALUES("8-1-2021", 2,22,"Colonoscopia" , " Dr. Alfronsio",2345267890)
INSERT INTO internamento(periodoInternamento,maxVisitantes,n_camas,especialidade,medico_respon,n_sequencial)
VALUES("8-1-2021", 3,33, "Urologia" , "Dra Trudilda",2345267891)
INSERT INTO internamento(periodoInternamento,maxVisitantes,n_camas,especialidade,medico_respon,n_sequencial)
VALUES("8-1-2021",4,44, "Ortopedia" ,"Dr Estrândifrôndio",2345267892)

INSERT INTO fatura(cus_total,cus_ex,cus_d_i_e,dat_pag,n_sequencial)
VALUES(233.25,130,50,"8-1-2021",2345267890)
INSERT INTO fatura(cus_total,cus_ex,cus_d_i_e,dat_pag,n_sequencial)
VALUES(322.25,310,70,"8-1-2022",2345267891)
INSERT INTO fatura(cus_total,cus_ex,cus_d_i_e,dat_pag,n_sequencial)
VALUES(323.25,140,60,"8-1-2023",2345267892)






