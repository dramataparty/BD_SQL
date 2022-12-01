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
    tipo_pess VARCHAR(20),
    emp  Boolean(1),
    tipo_emp VARCHAR(20)

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

Select P.tipo_emp
FROM pessoas P
WHERE NOT EXISTS (
      from pessoas.tipo_emp
      where pessoas.tipo_emp = "Médico"

)

Select P.tipo_pess
FROM pessoas P
WHERE NOT EXISTS (
      from pessoas.tipo_pess
      where pessoas.tipo_pess = "Utente"

)

Select P.tipo_pess
FROM pessoas P
WHERE NOT EXISTS (
      from pessoas.tipo_pess
      where pessoas.tipo_pess = "Visitante"

)

Select P.tipo_emp
FROM pessoas P
WHERE NOT EXISTS (
      from pessoas.tipo_emp
      where pessoas.tipo_emp = "Técnico"

)





CREATE TABLE horario(
   horarioA =,
   horarioB = ,/*o que raio é um horario*/
   /* SET ? Talvez?? */
);





/*fatura, supervisor, diretor clinico, camas,*/
CREATE TABLE fatura (

)

create TABLE camas (

)

CREATE TABLE supervisores (

)

CREATE TABLE  medicos(

)
CREATE TABLE utentes (

)

CREATE TABLE visitantes (

)

CREATE TABLE empregados (

)
/* O QUE É O DIRETOR CLINICO?*/ 

