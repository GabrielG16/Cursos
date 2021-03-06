/* Modelagem básica 
ENTIDADE = TABELA
*/

/* CAMPOS = Atributos */
CLIENTE

NOME - CARACTER(30)
CPF - NUMERICO(11)
EMAIL - CARACTER(30)
TELEFONE - CARACTER(30)
ENDERECO - CARACTER(30)
SEXO - CARACTER (1)

/* PROCESSOS DE MODELAGEM */

/* FAse 01 e fase 02 - AD - ADM DE DADOS */
modelagem conceitual - rascunho 
modelagem lógica - Qualquer programa de modelagem

/* FASE 03 - DBA / AD */
modelagem física - SCripts de Banco

/*INICIANDO A MODELAGEM FÍSICA */

/* CRIANDO O BANCO DE DADOS*/

CREATE DATABSE PROJETO;

/* CONECTANDO AO BANCO DE DADOS */

USE PROJETO;

/* CRIANDO A TABELA DE CLIENTES */

CREATE TABLE CLIENTE(
	NOME VARCHAR(30),
	SEXO CHAR(1),
	EMAIL VARCHAR(30),
	CPF INT(11),
	TELEFONE VARCHAR(30),
	ENDERECO VARCHAR(100)
);

/* VERIFICAR AS TABELAS DO BANCO */

USE EXEMPLO;
SHOW TABLES;

/* DESCOBRINDO A ESTRUTURA DA TABELA */

DESC CLIENTE;

/* ENUM -> VALORES DE UM CAMPO ESPECIFICO DENTRO DE UMA DETERMINADA ESPECIFICACAO */

/*SINTAXE BÀSICA DE INSERÇÃO - INSERT INTO TABELA... */----------------------------------------------------------------------------------------------------------------------

/* FORMA 01 - OMITINDO COLUNAS */

INSERT INTO CLIENTE VALUES ('JOAO', 'M', 'JOAO@GMAIL.COM', 988638273, '22923110', 'MAIA LACERDA 0 ESTACIO - RIO DE JANEIRO - RJ');

/* FORMA 02 - COLOCANDO AS COLUNAS */
  
INSERT INTO CLIENTE(NOME, SEXO, ENDERECO, TELEFONE, CPF) VALUES('LILIAN','F','SENADOR SOARES - TIJUCA - RIO DE JANEIRO - RJ', '947785696', 887774856)

/* FORMA 03 - INSERT COMPACTO - SOMENTE NO MYSQL */

INSERT INTO CLIENTE VALUES('ANA', 'F', 'ANA@GLOBO.COM', 8558962, '54556985', 'PRES ANTIO CARLOS - CENTRO - SAO PAULO - SP'), 
('PEDRO', 'M', 'PEDRO@GLOBO.COM', 8538562, '54436985', 'PRES ANTONIO CARLOS - CENTRO - SAO PAULO - SP');


/* COMANDO SELECT - PROJECAO
Selecao, projecao e juncao

PROJECAO -> É TUDO QUE VOCE QUER VER NA TELA (SEJA POR CONSULTA DE TABELA, SEJA PROGRAMADO)
SELECAO -> É UM SUBJCONJUNTO DO CONJUNTO TOTAL DE REGISTROS DE UMA TABELA (A CLAUSULA DE SELECAO É O WHERE)

 
 --------------------------------------------------------------------------------------------------------------*/
 
 SELECT NOME AS CLIENTE, SEXO, EMAIL FROM CLIENTE;
 /* NAO USE O 'SELECT *' NA EMPRESA - RETORNA INFORMAÇÃO DESNECESSARIA AO QUE O CLIENTE PEDE*/
 
 /* FILTROS (WHERE) ----------------------------------------------------------------------------------------------------------------------------------------------------
 Selecao - WHERE 
 */
 SELECT NOME, SEXO FROM CLIENTE
 WHERE SEXO = 'M';
 
 /* UTILIZANDO O LIKE  (SUBSTITUI A IGUALDADE (=)*/
 
 SELECT NOME, SEXO FROM CLIENTE 
 WHERE ENDERECO LIKE 'RJ';
 
 /* CARACTER CORINGA % -> QUALQUER COISA */
 
 SELECT NOME, SEXO FROM CLIENTE
 WHERE ENDERECO LIKE '%RJ';
 
  SELECT NOME, SEXO FROM CLIENTE
 WHERE ENDERECO LIKE '%_____RJ____%';
 
 /* TECNOLOGIA DE  MOSTRAR OS RESULTADOS DA QUERY ENQUANTO VOCE DIGITA OS FILTROS - AJAX */
 
 /* is ou is not null para verificar valores nulos numa tabela */
 
 /* UTILIZAÇÃO DO UPDATE PARA ATUALIZAR VALORES */
 
 UPDATE TABELA
 SET EMAIL = 'LILIAN@GMAIL.COM'
 WHERE NOME = 'LILIAN';
 
  /* delete apaga um registro do banco da tabela - DEVE TB SEMPRE VIR ACOMPANHADO DO WHERE*/
  /*------------------ É recomendado, antes do delete ou update, fazer um select para garantir que serão modificados somente os dados esperados ---------------------------*/
  
  delete from tabela
  WHERE nome = 'fulano';
  
  drop table tabela;
  
/* METODOS DE MODELAGEM DE BANCO DE DADOS */

/*PRIMEIRA FORMA NORMAL */

/*
1 - TODO CAMPO VETORIZADO SE TORNARÁ OUTRA TABELA
[AMARELO, AZUL, LARANJA, VERDAE ] -> CORES
[KA, FIESTA, UNO, CIVIC -> CARROS

2 - TODO CAMPO MULTVALORADO* SE TORNARA OUTRA TABELA. - *DIFERENTES ELEMENTOS Q COMPLEMENTAM UMA UNICA INFO
QUANDO O CAMPO FOR DIVSÍVEL

3 - TODA TABELA NECESSITA DE PELO MENOS UM CAMPO QUE IDENTIFIQUE
TODO O REGISTRO COMO SENDO ÚNICO.
ISSO É O QUE CAMAMOS DE CHAVE PRIMÁRIA

NÃO SE DEVE MODELAR VOLTADO A PROCEDIMENTO DE NEGÓCIO

CARDINALIDADE -> (1,1) ou ou (1,N) (1 para 1 ou 1 para vários)
(0,1)  
(0,n) 			(obrigatoriedade, cardinalidade)
(1,1)
(1,n)
*/

/* AUTO_INCREMENT PARA O BANCO GERENCIAR O CAMPO E NAO DAR CONFLITO ENTRE USUÁRIOS */
/* NOT NULL IMPEDE QUE A COLUNA SEJA DEIXADA EM BRANCO */
/* 
SÓ EXISTE NO MYSQL 
SEXO ENUM('M','F') NOT NULL -> SÓ EXISTE NO MYSQL (PARA LIMITAR AS OPCOES DE ENTRADA)

EMAIL VARCHAR(50) UNIQUE -> NÃO ADMITE VALORES IGUAIS
*/

/* CHAVE ESTRANGEIRA-> É A CHAVE PRIMARIA DE UMA TABELA 
QUE VAI ATÉ A OUTRA TABELA PARA FAZER A REFERENCIA ENTRE REGISTROS */

/* EM RELACIONAMENTOS 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS "FRACA" (DEFINIDO PELA REGRA DE NEGOCIO) EM RELACIONAMENTOS 1 X N 
 A CHAVE ESTRANTEIRA FUCARA SEMPRE NA CARDINALIDADE N A CHAVE ESTRANGEIRA É NOMEADA POR CONVENÇÃO MAS DEVE SEGUIR UM PADRAO. PODE LEVAR O MESMO NOME DA CHAVE PRIMARIA DA CHAVE REFERENCIA
  DICA: 'ID_CLIENTE' O 'ID_' ANUNCIA QUE SE TRATA DE UMA CHAVE ESTRANGEIRA */
  
  /* ---CONSTRAINTS ---- */
  
  CREATE TABLE TELEFONE(
  IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
  TIPO ENUM('RES','COM','CEL') NOT NULL,
  NUMERO VARCHAR(10) NOT NULL,
  ID_CLIENTE INT UNIQUE, # UNIQUE INDICA A RELACAO 1:1, OU SEJA, CADA VALOR ID_CLIENTE DEVE SER ÚNICO POIS CORRESPONDE A UM ÚNICO VALOR DA TABELA PRIMARIA
  FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE)
);
SHOW DATABASES;

/* -=-------------------------JUNCOES -> JOINS --------------------------------------*/

/*  É POSSIVEL USAR O WHERE COMO COMANDO DE JUNCAO MAS NAO É RECOMENDADO 
EX:
*/
SELECT NOME, SEXO, RUA, BAIRRO 
FROM CLIENTE, ENDERECO
WHERE IDCLIENTE = ID_CLIENTE;

/*
NA VERDADE O CORRETO SERIA (JUNCAO DE DUAS TABELAS)
*/
SELECT NOME, SEXO, RUA, BAIRRO
FROM CLIENTE 
INNER JOIN ENDERECO 
ON IDCLIENTE = ID_CLIENTE;

/*
PARA DUAS TABELAS OU MAIS É SEMELHANTE
*/
SELECT NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO
FROM CLIENTE
INNER JOIN ENDERECO 
ON IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE
ON IDCLIENTE = ID_CLIENTE;
/*
OBS: ESSA QUERY RETORNARIA UM PROBLEMA DE AMBIGUIDADE JA QUE A CHAVE ID_CLIENTE EXISTEM EM MAIS DE UMA DAS TABELAS DE JOIN. 
PARA EVITAR ESSE PROBLEMA, É POSSIVEL REFERENCIAR A QUAL TABELA O CAMPO SE REFERE, OU SEJA:
*/

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO 
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

/*
OU AINDA, ADICIONAR APELIDOS PARA OS PONTEIROS DAS TABELAS:
*/

SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

##### SEGURAR CTRL NO SUBLIME PRA FAZER UMA SELECAO MÚLTIPLA.

/* 
DML - DATA MANIPULATION LANGUAGE (TUDO Q FOI VISTO ATE AGORA)
DDL - DATA DEFINITION LANGUAGE
DCL - DATA CONTROL LANGUAGE
TCL - TRANSACTION CONTROL LANGUAGE
*/

/*
----------------------------------------------------DDL ---------------------------------------------------------------
*/
CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
    NOME_PRODUTO VARCHAR(30) NOT NULL,
    PRECO INT,
    FRETE FLOAT(10,2) NOT NULL
);
/*
####### ALTER TABLE

--- ALTERANDO O NOME DE UMA COLUNA - CHANGE/MODIFY
*/

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL; #(COMO É -> COMO VAI FICAR) (MELHOR P MUDAR NOME)

ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;#(MELHOR P MUDAR TIPO);

/*
ADICIONAR COLUNAS
*/

ALTER TABLE PRODUTO
ADD PESO FLOAT NOT NULL;

/*
APAGANDO COLUNAS
*/

ALTER TABLE PRODUTO
DROP COLUMN PESO;

/*
ADICIONANDO COLUNAS NUMA ORDEM ESPECIFICA
*/
ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT NOT NULL
AFTER NOME_PRODUTO;

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT NOT NULL
FIRST;
/*-----------------------------exercicio 2 --------------------------------*/
CREATE DATABASE COMERCIO;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
    );
    
    CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT, 
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT, 
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

INSERT INTO CLIENTE VALUES(NULL,'FLAVIO','M','FLAVIO@IG.COM','4657765');
INSERT INTO CLIENTE VALUES(NULL,'ANDRE','M','ANDRE@GLOBO.COM','7687567');
INSERT INTO CLIENTE VALUES(NULL,'GIOVANA','F',NULL,'0876655');
INSERT INTO CLIENTE VALUES(NULL,'KARLA','M','KARLA@GMAIL.COM','545676778');
INSERT INTO CLIENTE VALUES(NULL,'DANIELE','M','DANIELE@GMAIL.COM','43536789');
INSERT INTO CLIENTE VALUES(NULL,'LORENA','M',NULL,'774557887');
INSERT INTO CLIENTE VALUES(NULL,'EDUARDO','M',NULL,'54376457');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','F','ANTONIO@IG.COM','12436767');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M','ANTONIO@UOL.COM','3423565');
INSERT INTO CLIENTE VALUES(NULL,'ELAINE','M','ELAINE@GLOBO.COM','32567763');
INSERT INTO CLIENTE VALUES(NULL,'CARMEM','M','CARMEM@IG.COM','787832213');
INSERT INTO CLIENTE VALUES(NULL,'ADRIANA','F','ADRIANA@GMAIL.COM','88556942');
INSERT INTO CLIENTE VALUES(NULL,'JOICE','F','JOICE@GMAIL.COM','55412256');
INSERT INTO CLIENTE VALUES(NULL,'MARCELO','M','MARCELO@IG.COM','2553648');
INSERT INTO CLIENTE VALUES(NULL,'JOANA','F','JOANA@IG.COM','48933414');


INSERT INTO ENDERECO VALUES(NULL,'RUA GUEDES','CASCADURA','B. HORIZONTE','MG',9);
INSERT INTO ENDERECO VALUES(NULL,'RUA MAIA LACERDA','ESTACIO','RIO DE JANEIRO','RJ',10);
INSERT INTO ENDERECO VALUES(NULL,'RUA VISCONDESSA','CENTRO','RIO DE JANEIRO','RJ',11);
INSERT INTO ENDERECO VALUES(NULL,'RUA NELSON MANDELA','COPACABANA','RIO DE JANEIRO','RJ',12);
INSERT INTO ENDERECO VALUES(NULL,'RUA ARAUJO LIMA','CENTRO','VITORIA','ES',13);
INSERT INTO ENDERECO VALUES(NULL,'RUA CASTRO ALVES','LEBLON','RIO DE JANEIRO','RJ',15);
INSERT INTO ENDERECO VALUES(NULL,'AV CAPITAO ANTUNES','CENTRO','CURITIBA','PR',15);
INSERT INTO ENDERECO VALUES(NULL,'AV CARLOS BARROSO','JARDINS','SAO PAULO','SP',16);
INSERT INTO ENDERECO VALUES(NULL,'ALAMEDA SAMPAIO','BOM RETIRO','CURITIBA','PR',17);
INSERT INTO ENDERECO VALUES(NULL,'RUA DA LAPA','LAPA','SAO PAULO','SP',18);
INSERT INTO ENDERECO VALUES(NULL,'RUA GERONIMO','CENTRO','RIO DE JANEIRO','RJ',19);
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',20);
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',21);

INSERT INTO TELEFONE VALUES(NULL,'RES','68976565',9);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99656675',9);
INSERT INTO TELEFONE VALUES(NULL,'CEL','33567765',11);
INSERT INTO TELEFONE VALUES(NULL,'CEL','88668786',11);
INSERT INTO TELEFONE VALUES(NULL,'COM','55689654',11);
INSERT INTO TELEFONE VALUES(NULL,'COM','88687979',12);
INSERT INTO TELEFONE VALUES(NULL,'COM','88965676',13);
INSERT INTO TELEFONE VALUES(NULL,'CEL','89966809',15);
INSERT INTO TELEFONE VALUES(NULL,'COM','88679978',16);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99655768',17);
INSERT INTO TELEFONE VALUES(NULL,'RES','89955665',18);
INSERT INTO TELEFONE VALUES(NULL,'RES','77455786',19);
INSERT INTO TELEFONE VALUES(NULL,'RES','89766554',19);
INSERT INTO TELEFONE VALUES(NULL,'RES','77755785',20);
INSERT INTO TELEFONE VALUES(NULL,'COM','44522578',20);

select C.NOME, C.SEXO, C.EMAIL, C.CPF, E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO, T.TIPO, T.NUMERO FROM 
CLIENTE C
INNER JOIN ENDERECO E
ON IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

SELECT * FROM CLIENTE
WHERE SEXO = 'M';

SELECT * FROM CLIENTE
WHERE SEXO = 'F';

SELECT SEXO, COUNT(*) AS 'QUANT.'
FROM CLIENTE
GROUP BY SEXO;

SELECT C.IDCLIENTE, C.NOME, C.EMAIL
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
WHERE (E.BAIRRO = 'CENTRO' and E.CIDADE = 'RIO DE JANEIRO') and C.EMAIL IS NULL;

DESC ENDERECO;

SELECT * FROM CLIENTE 
WHERE NOME = 'ANTONIO';

UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 12;

SELECT * FROM CLIENTE
WHERE IDCLIENTE IN (12,13,18,19);
/*----------------------------------------------------------------------------------------------------------------------
FUNCOES - IFNULL
-----------------------------------------------------------------------------------------------------------------------*/

select C.NOME, C.SEXO, IFNULL(C.EMAIL, 'EMAIL AUSENTE'), C.CPF, E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO, T.TIPO, T.NUMERO FROM 
CLIENTE C
INNER JOIN ENDERECO E
ON IDCLIENTE = ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

/*------------------------------------------------------------------------------------------------------------------------
VIEWS
-------------------------------------------------------------------------------------------------------------------------*/
CREATE VIEW RELATORIO AS
SELECT C.NOME, 
	   C.SEXO, 
       IFNULL(C.EMAIL, 'EMAIL AUSENTE'), 
       C.CPF, E.RUA, 
       E.BAIRRO, 
       E.CIDADE, 
       E.ESTADO, 
       T.TIPO, 
       T.NUMERO 
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

SELECT * FROM RELATORIO;

# A view entra no campo de tabelas, apesar disso nao é uma tabela nova

DROP VIEW V_RELATORIO; # PREFIXO PARA FACILITAR IDENTIFICAÇÃO

CREATE VIEW V_RELATORIO AS
SELECT C.NOME, 
	   C.SEXO, 
       IFNULL(C.EMAIL, 'EMAIL AUSENTE'), 
       C.CPF, E.RUA, 
       E.BAIRRO, 
       E.CIDADE, 
       E.ESTADO, 
       T.TIPO, 
       T.NUMERO 
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

#É possível então fazer uma query na query

############### ORDER BY ######################

SELECT * FROM ALUNOS
ORDER BY 1, 2; #ORDEM DE ACORDO COM O QUE É PEDIDO NA PROJECAO

SELECT * FROM ALUNOS
ORDER BY NUMERO, NOME;

SELECT * FROM ALUNOS
ORDER BY NUMERO ASC, NOME DESC;

## MUDAR O DELIMITADOR 

## AO REINICIAR A SESSÃO NO SERVIDOR DO SQL, O DELIMITER VOLTA AO PADRÃO
/* STORAGED FUNCTIONS */

# É utilizada para gerar um valor que pode ser usado em uma expressão. O valor geralmente é baeado em um ou mais parâmetros da função.

CREATE FUNCTION minha_func(parametros)
RETURNS tipo_dado
codigo

CREATE FUNCTION fn_teste(a DECIMAL(10,2), b INT)
RETURNS INT
ReTURN a*b;

SELECT minha_func(parametros)/

#As variáveis parametros das funções podem vir precedidas de IN OUT E INOUT que indica o uso que será feito da variável. 'IN' é a característica padrão. a variável é utilizada no procedure mas não é alterada para fora dele. 'OUT' A variável é setada para NULL dentro da procedure e será retornada ao fim do procedure. Altera o valor da variável de entrada

DELIMITER //
CREATE PROCEDURE teste_out(IN id INT, OUT livro VARCHAR(50))
BEGIN
	SELECT nome_livro
	INTO livro
	FROM tbl_Livro
	WHERE ID_Livro = id;
END//
DELIMITER ;

CALL teste_out(3, @livro);
SELECT @livro;
/* STORAGED PROCEDURES */

# OS PROCEDIMENTOS NOMEADOS FICAM ARMAZENADOS NO BANCO DE DADOS

# MUDANCA NO DELIMITER É NECESSÁRIA


# É NECESSÁRIO ALTERAR O DELIMITER PARA QUE O BANCO NÃO PARE NO MEIO DA LEITURA DE UM PROCEDURE (QUE É DELIMITADO POR ';')
DELIMITER $
CREATE PROCEDURE INSERIR(P_NOME VARCHAR(30),
						 P_SEXO CHAR(1),
                         P_EMAIL VARCHAR(50),
                         P_CPF CHAR(11))
BEGIN
		INSERT into CLIENTE VALUES(NULL, P_NOME, P_SEXO, P_EMAIL, P_CPF);
END$


DELIMITER $
CREATE PROCEDURE S_BAIRRO(P_BAIRRO VARCHAR(30))
BEGIN
	SELECT C.NOME, E.BAIRRO, E.ESTADO
        FROM CLIENTE C
        INNER JOIN ENDERECO E
        ON C.IDCLIENTE = E.ID_CLIENTE
        WHERE E.BAIRRO = P_BAIRRO;
END$
DELIMITER ;


SELECT NOME FROM CLIENTE;
DELIMITER ;

CALL NOME_EMPRESA();

TRUNCATE(VALOR, CASAS DECIMAIS);


/* ALTERANDO A ESTRUTURA DE UMA TABELA */

ALTER TABLE TABELA
ADD PRIMARY KEY (COLUNA1);

ALTER TABLE TABELA
ADD COLUNA VARCHAR(30);
AFTER COLUNA2 # OU FIRST

-- AO ADICIONAR, VAI SEMPRE PARA A ÚLTIMA POSIÇÃO

ALTER TABLE TABELA
ADD FOREIGN KEY (COLUNA1) REFERENCES TABELA2(COLUNA_X)

/* ORGANIZAÇÃO DE CHAVES - CONSTRAINTS (REGRAS) - INTEGRIDADE REFERENCIAL*/ 

 # É MELHOR CRIAR AS CONSTRAINS FORA DA TABELA DO QUE NA CRIAÇÃO POR CAUSA DO CONTROLE DOS NOMES DE CONSTRAINTS
 
 # ALÉM DISSO PERMITE QUE VOCE CRIE AS TABELAS INICIALMENTE SEM SE PREOCUPAR COM AS CONEXÕES, PROBLEMAS DE ORDEM NA 
 # CRIAÇÃO PARA PROMOVER INTEGRIDADE REFERENCIAL, ETC
 
 # PRIMEIRO OS CREATE TABLES E DEPOIS ALTER TABLES COM AS CONSTRAINTS
# EX:

CREATE TABLE CLIENTE(
	IDCLIENT INT,
    VARCHAR(30) NOT NULL
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT,
    TIPO CHAR(3) NOT NULL,
    NUMERO VARCHAR(10) NOT NULL,
    ID_CLIENTE INT
);

 ALTER TABLE CLIENTE 
 ADD CONSTRAINT PK_CLIENTE 
 PRIMARY KEY(IDCLIENTE);
 
  ALTER TABLE CLIENTE 
 ADD CONSTRAINT PK_TELEFONE
 PRIMARY KEY(IDTELEFONE);
 
 ALTER TABLE TELEFONE
 ADD CONSTRAINT FK_CLIENTE_TELEFONE 
 FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE);
 
 SHOW CREATE TABLE TELEFONE; # DESCRICAO DOS DETALHES DA TABELA
 
 ############### DICIONARIO DE DADOS ######################
 
 SHOW DATABASES; #VERIFICAR AS TABELAS JA FORNECIDAS NO BANCO
 #TABELAS DO MYSQL
 #information_schema
 #mysql
 #performance_schema
 USE information_schema
 STATUS;
 SHOW TABLES #(PROCURAR TABELA QUE PODE TER AS INFOS QUE VC QUER)

/* APAGANDO CONSTRAINTS */

ALTER TABLE TELEFONE
DROP FOREIGN KEY FK_CLIENTE_TELEFONE; # BOM PRA ADICIONAR MUITOS ITENS NA TABELA PARA NAO PRECISAR CHECAR A INTEGRIDADE REFERENCIAL 1 A 1.

################## ACOES DE CONSTRAINTS #########################################

show databases;

###RELACIONAMENTO N X N -> ENTIDADE ASSOCIATIVA


/* A 39 ENTENDENDO TRIGGERS - Triggers são como blocos de comandos (funções) que são disparadas diante da ocorrência de um outro evento no banco de dados*/

/* ESTRUTURA DE UMA TRIGGER */
#MUDA DELIMITADOR, IGUAL PROCEDURES
DELIMITER #

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON TABELA 
FOR EACH ROW #(PARA CADA LINHA)  Sempre tem
BEGIN -> INICIO

		QUALQUER COMANDO SQL

END -> FIM

CREATE TABLE USUARIO(
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)
);

CREATE TABLE BKP_USUARIO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)
);

/* CRIANDO A TRIGGER */

DELIMITER $
CREATE TRIGGER BACKUP_USER
BEFORE DELETE ON USUARIO 
FOR EACH ROW 
BEGIN
		
	INSERT INTO BKP_USUARIO VALUES	
	(NULL,OLD.IDUSUARIO,OLD.NOME,OLD.LOGIN); # NOTACAO OLD. SE REFERE AO VALOR ANTES DO EVENTO QUE O DISPARA
END											 # (NO CASO DO BEFORE) E O VALOR .NEW É O VALOR APÓS O EVENTO QUE O DISPARA
$

## ESSA TRIGGER DEVE REGISTRAR NUMA TABELA BKP_USUARIO OS DADOS DO QUE SERÁ DELETADO.

INSERT INTO USUARIO 
VALUES(NULL,'ANDRADE','ANDRADE2009','HEXACAMPEAO');

SELECT * FROM USUARIO;

DELETE FROM USUARIO 
WHERE IDUSUARIO = 1;

/* 41 - COMUNICACAO ENTRE BANCOS -> é possível referenciar tabelas de outro banco usando o prefixo BANCO2.TABELA_BANCO2*/

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT
);

STATUS

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBKP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR FLOAT
);

USE LOJA;

STATUS

INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,1000,'TESTE',0.0);

SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUT
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,NEW.IDPRODUTO,
	NEW.NOME,NEW.VALOR);

END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO BI',80.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO ORACLE',70.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO SQL SERVER',100.00);

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,
	OLD.NOME,OLD.VALOR);

END
$

DELIMITER ;

DELETE FROM PRODUTO WHERE IDPRODUTO = 2;

DROP TRIGGER BACKUP_PRODUT;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,NEW.IDPRODUTO,
	NEW.NOME,NEW.VALOR);

END
$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO C#',100.00);


SELECT * FROM PRODUTO;
SELECT * FROM BACKUP.BKP_PRODUTO;

ALTER TABLE BACKUP.BKP_PRODUTO
ADD EVENTO CHAR(1);

DROP TRIGGER BACKUP_PRODUTO_DEL;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	
	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,
	OLD.NOME,OLD.VALOR,'D');

END
$

DELIMITER ;

DELETE FROM PRODUTO WHERE IDPRODUTO = 4;

SELECT * FROM BACKUP.BKP_PRODUTO;

/* A 43 - TRIGGER DE AUDITORIA */

DELIMITER ;

DROP DATABASE LOJA;

DROP DATABASE BACKUP;

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

INSERT INTO PRODUTO VALUES(NULL,'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO BI',80.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO ORACLE',70.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO SQL SERVER',100.00);

/*QUANDO*/
SELECT NOW();
/*QUEM*/
SELECT CURRENT_USER();

CREATE DATABASE BACKUP;

USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR_ORIGINAL FLOAT(10,2),
	VALOR_ALTERADO FLOAT(10,2),
	DATA DATETIME,
	USUARIO VARCHAR(30),
	EVENTO CHAR(1) #FLAG DE EVENTO QUE CAUSOU O REGISTRO NO LOG
	
);

USE LOJA;

SELECT * FROM PRODUTO;

DELIMITER $

CREATE TRIGGER AUDIT_PROD
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN

	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,OLD.NOME,
	OLD.VALOR,NEW.VALOR,NOW(),CURRENT_USER(),'U');
	 
END
$

DELIMITER ;

UPDATE PRODUTO SET VALOR = 110.00
WHERE IDPRODUTO = 4;

SELECT * FROM PRODUTO;

SELECT * FROM BACKUP.BKP_PRODUTO;

/* AUTORRELACIONAMENTO */



CREATE TABLE CURSOS(
	IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	HORAS INT,
	VALOR FLOAT(10,2),
	ID_PREREQ INT
);

ALTER TABLE CURSOS ADD CONSTRAINT FK_PREREQ
FOREIGN KEY(ID_PREREQ) REFERENCES CURSOS(IDCURSO); # Referencia a própria tabela como foreign key

INSERT INTO CURSOS VALUES(NULL,'BD RELACIONAL',20,400.00,NULL);
INSERT INTO CURSOS VALUES(NULL,'BUSINESS INTELLIGENCE',40,800.00,1);
INSERT INTO CURSOS VALUES(NULL,'RELATORIOS AVANCADOS',20,600.00,2);
INSERT INTO CURSOS VALUES(NULL,'LOGICA PROGRAM',20,400.00,NULL);
INSERT INTO CURSOS VALUES(NULL,'RUBY',30,500.00,4);

SELECT * FROM CURSOS;

SELECT NOME, VALOR, HORAS, IFNULL(ID_PREREQ,"SEM REQ") REQUISITO
FROM CURSOS;

/* NOME, VALOR, HORAS E O NOME DO PRE REQUISITO DO CURSO */

SELECT 
C.NOME AS CURSO, 
C.VALOR AS VALOR, 
C.HORAS AS CARGA, 
IFNULL(P.NOME, "---") AS PREREQ # Trazer o nome
FROM CURSOS C LEFT JOIN CURSOS P # Fazendo join com a própria tabela sob um alias diferente
ON P.IDCURSO = C.ID_PREREQ; # Assim, os nomes que irão aparecer são relativos ao que está disposto na coluna de prerequisitos

/* CURSORES */

CREATE DATABASE CURSORES;
USE CURSORES;

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(50),
    JAN INT,
    FEV INT,
    MAR INT
);

INSERT INTO VENDEDORES VALUES(NULL, 'MAFRA', 32432, 24234, 54716);
INSERT INTO VENDEDORES VALUES(NULL, 'MARCELO', 56241, 242345, 84561);
INSERT INTO VENDEDORES VALUES(NULL, 'JOAO', 14754, 98632, 254556);
INSERT INTO VENDEDORES VALUES(NULL, 'ANDREA', 58547, 21475, 66824);
INSERT INTO VENDEDORES VALUES(NULL, 'VIVIAN', 54263, 51246, 452114);
INSERT INTO VENDEDORES VALUES(NULL, 'WILLIAM', 38741, 63214, 96521);

SELECT * FROM VENDEDORES;

SELECT NOME, (JAN+FEV+MAR) AS TOTAL, (JAN+FEV+MAR)/3 AS MEDIA FROM VENDEDORES;

CREATE TABLE VEND_TOTAL(
    NOME VARCHAR(50),
    JAN INT,
    FEV INT,
    MAR INT,
    TOTAL INT,
    MEDIA INT
);

DELIMITER #

CREATE 


PROCEDURE INSERE_DADOS()
BEGIN

    DECLARE FIM INT DEFAULT 0;
    DECLARE VAR1, VAR2, VAR3, VTOTAL, VMEDIA INT;
    DECLARE VNOME VARCHAR(50);
    
    DECLARE REG CURSOR FOR(
		SELECT NOME, JAN, FEV, MAR FROM VENDEDORES
        );
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM = 1; 
    
    OPEN REG; 
    
    REPEAT
    
	FETCH REG INTO VNOME,VAR1, VAR2, VAR3;
        IF NOT FIM THEN
        
			SET VTOTAL = VAR1+VAR2+VAR3;
			SET VMEDIA = (VTOTAL)/3;
            
            INSERT INTO VEND_TOTAL VALUES(VNOME, VAR1, VAR2, VAR3, VTOTAL, VMEDIA);
		END IF;
        
	UNTIL FIM END REPEAT;
    
    CLOSE REG;
			
END#

/* SEGUNDA E TERCEIRA FORMA NORMAL

1 FN - 

ATOMICIDADE - UM CAMPO NAO PODE SER DIVISIVEL
UM CAMPO NAO PODE SER VETORIZADO
PK CHAVE PRIMARIA

2 FN - DEPENDENCIA DIRETA - QUALQUER CAMPO NAO-CHAVE DEVE DEPENDER DA TOTALIDADE DAS CHAVES.  O VALOR DO CAMPO É RELATIVO AOS PARAMETROS DADOS PELA CHAVE PRIMÁRIA

3 FN - DEPENDENCIA TRANSITIVA - CAMPOS NÃO CHAVE DEPENDENTES DE OUTROS CAMPOS NÃO-CHAVE DEVEM PERTENCER A OUTRA TABELA

*/

/* IMPORT DE CSV */

/* CRIA A TABELA NO FORMATO PARA RECEBER O CSV */

CREATE TABLE MAQUINAS(
	MAQUINA VARCHAR(20),
    DIA INT,
    QTD FLOAT
);
LOAD DATA INFILE '/home/export_file.csv'
INTO TABLE MAQUINAS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '/n'
IGNORE 1 ROWS;

/* FUNCIONA NO POSTGRES PGADMIN 

COPY MAQUINAS 
FROM 'PATH_DO_CSV/NOME_DO_CSV.CSV'
DELIMITER ','
CSV HEADER;
*/


/* Podemos criar uma tabela com o resultado de ua querie e essa é a forma
de realizar uma modelagem colunar a parter de um modelo relacional. 
*/

CREATE TABLE REL_LOCADORA AS
SELECT F.NOME AS FILME, G.NOME AS GENERO, L.DATA AS DATA, L.DIAS AS DIAS, L.MIDIA AS MIDIA
FROM GENERO G
INNER JOIN FILME F
ON G.IDGENERO = F.ID_GENERO
INNER JOIN LOCACAO L
ON L.ID_FILME = F.IDFILME;

/*  
COPY REL_LOCADORA TO
'PATH_DO_NOVO_CSV'
DELIMITER ';'
CSV HEADER;
*/
#Variáveis locais vem dentro dos blocos BEGIN e END. E deixam de existir fora desses blocos.
PARA ATRIBUIR VALOR A ESSAS VARI[AVEIS, PODE-SE USAR A INSTRUÇÃO SET ou SELECT...INTO

DECLARE var1 INT default 1
DECLARE var 2 FLOAT 

# A instrução DECLARE deve vir antes de qualquer outra instrução no bloco BEGIN

CREATE PROCEDURE acumula(limite INT)
(LABEL: OPCIONAL) BEGIN
	DECLARE contador INT DEFAULT 0;
	DECLARE SOMA INT DEFAULT 0;
	(LABEL: OPCIONAL)loop_teste: LOOP
		SET contador = contador + 1;
		SET soma = soma + contador;
		IF contador >= limite THEN
			LEAVE loop_teste;
		END IF;
	END LOOP loop_teste;
	SELECT soma;
END //

CREATE PROCEDURE acumula(limite INT)
(LABEL: OPCIONAL) BEGIN
	DECLARE contador INT DEFAULT 0;
	DECLARE SOMA INT DEFAULT 0;
	(LABEL: OPCIONAL)repeat_teste: REPEAT
		SET contador = contador + 1;
		SET soma = soma + contador;
		UNTIL contador >= limite

	END REPEAT repeat_test;
	SELECT soma;
END //

WHILE contador < limite DO
	SET contador = contador + 1;
	SET soma = soma + contador;
END WHIILE;

ITERATE aparece apenas dentro de estruturas de LOOP, REPEAT e WHILE.]
O iterate direciona para um novo loop da estruura de 
 
