CREATE TABLE clinica (
  nome   VARCHAR(40)  NOT NULL,
  data_inaug DATE NOT NULL,
  nipc INTEGER (9) ,
  phonum INTEGER(9), 
  diretor VARCHAR(40),
  morada VARCHAR(40)


    PRIMARY KEY(nipc)




);


CREATE TYPE empreg as VARCHAR,
create type nempreg as VARCHAR
/* conflcte on what it should be */



CREATE TABLE pessoas(
    nome VARCHAR(40) NOT NULL,
    morada VARCHAR(100),
    telefone INTEGER(12),
    nif INTEGER(9) NOT NULL,
    género VARCHAR(1),
    dataNascimento DATE NOT NULL,
    correioEletronico VARCHAR(40),
    tipo_pess VARCHAR(20) NOT NULL,
    emp  Boolean(1),
    tipo_emp VARCHAR(20) NOT NULL

    PRIMARY key(nif)

/*tipo empregados(tecnico, medico) (add dat de inicio) utentes visitantes,  
*/
    CONSTRAINT ck_genero 
        CHECK(genero="M" or genero="F" or genero=NULL)
    CONSTRAINT pk_pessoas
        PRIMARY KEY (nome)
    

);


CREATE TABLE salas (
    numero INTEGER(3) NOT NULL,
    piso INTEGER (2) NOT NULL,
    numeroExamesSimultaneo INTEGER(3),
    tipo_geral VARCHAR(13)

    PRIMARY KEY(numero)

/*tipo sala de exame e internamento*/
);

CREATE TABLE relatorios(
    numeroSequencial INTEGER(15),
    data DATE,
    descricaoResultados VARCHAR(500),
    parec_med VARCHAR(100),
    tipoex VARCHAR(20),
    PRIMARY KEY (numeroSequencial),
    responsaveis VARCHAR(100),



);

CREATE TABLE especialidades(
    nome VARCHAR(40) NOT NULL,
    sigla VARCHAR(10) NOT NULL,
    precoDiarioInternamento INTEGER(9) NOT NULL,
    PRIMARY KEY(sigla)

);


CREATE TABLE internamento(
    inicioInternamento DATE,
    maxVisitantes INTEGER(2),
    especialidade VARCHAR(20),
    medresp VARCHAR(30),


    REFERENCES fatura,
    REFERENCES medicos



);

CREATE TABLE supervisores(
    FOREIGN 
);









CREATE TABLE exame(
    codigo INTEGER(10),
    sigla VARCHAR(10),
    precoNormal INTEGER(9),
    tipo VARCHAR(30),
    periodoTempo TIME,
    precoUrgencia INTEGER(9), 


);



CREATE TABLE horario(
   horarioA = set(),
   horarioB = set(),/*o que raio é um horario*/
   /* SET ? Talvez?? */
);


/*fatura, supervisor, diretor clinico, camas,*/
CREATE TABLE fatura (
    cus_total int(999),
    cus_ex int(999),
    cus_d_i_e int(999),
    dat_pag DATE


)

create TABLE camas (
    numliv int(999),
    numocc int(999)

)

CREATE TABLE supervisores (
/* ?????  */


)

CREATE TABLE empregados (

)
/* O QUE É O DIRETOR CLINICO?*/ 


