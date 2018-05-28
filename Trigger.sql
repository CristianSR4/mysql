/************************************************************************************************************
	MAKE BY: Cristian Lérida Sánchez
	
	DATE: 22/MAYO/2018
	TITLE: USE AND EXAMPLES OF THE TRIGGER
*************************************************************************************************************/

/**************************************TRIGGER***************************************/

DROP DATABASE IF EXISTS _trigger;
CREATE DATABASE _trigger;

USE _trigger;

CREATE TABLE account (
	acct_num INT,
	amount DECIMAL(10,2)
);

CREATE TRIGGER ins_sum BEFORE INSERT ON account FOR EACH ROW SET @sum = @sum + NEW.amount;
SET @sum = 0;

INSERT INTO account VALUES
	(137,14.98),
	(141,1937.50),
	(97,-100.00);

SELECT @sum AS 'Total amount inserted';




CREATE TABLE ejemplo (
	PrecioProducto DECIMAL(10,2),
	PrecioVenta DECIMAL(10,2)
);

delimiter //
CREATE TRIGGER producto BEFORE INSERT ON ejemplo FOR EACH ROW IF NEW.PrecioProducto < 0 THEN SET NEW.PrecioProducto = 1;
END IF;
//
delimiter ;

delimiter //
CREATE TRIGGER venta BEFORE INSERT ON ejemplo FOR EACH ROW IF NEW.PrecioVenta < 0 THEN SET NEW.PrecioVenta = 2*NEW.PrecioProducto; 
END IF;
//
delimiter ;

CREATE TRIGGER beneficio BEFORE INSERT ON ejemplo FOR EACH ROW SET @be = @be + (NEW.PrecioVenta - NEW.PrecioProducto);

SET @be = 0;

INSERT INTO ejemplo VALUES 
	(-5,10),
	(15,-30),
	(-1,-3);

SELECT @be AS BeneficioNeto;
SELECT * FROM ejemplo;

/****************************************************************************************************************/

CREATE TABLE Bote (
    ID INT(3),
    Cantidad INT(4),
    Saldo INT(4)
);

/*This shit does not work*/

delimiter //

CREATE TRIGGER BoteTrigger AFTER INSERT ON Bote
  FOR EACH ROW
    BEGIN
        SET @bote = @bote + NEW.Cantidad;
        IF NEW.ID = 3 THEN
            SET NEW.Saldo = @bote;
             @bote = 0;
        END IF;
    END; //
delimiter ;

SET @bote = 0;

INSERT INTO Bote (ID, Cantidad) VALUES 
   (1,200),
   (2,50),
   (3,2);

SELECT @Bote;


/*SHOW TRIGGERS*/


/**************************************PROCEDURE***************************************/



delimiter //

CREATE PROCEDURE dorepeat(p1 INT)
  BEGIN
    SET @x = 0;
    REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
    END
  //

delimiter ;

CALL dorepeat(1024);
SELECT @x;

/**************************************FUNCTION***************************************/

CREATE FUNCTION hello (s CHAR(20))

RETURNS CHAR(50) DETERMINISTIC
  RETURN CONCAT('Hello, ',s,'!');

SELECT hello('world');

CREATE TABLE Meses (
	Num INT(2),
	Mes CHAR(30)
);
	
INSERT INTO Meses VALUES 
	(1, "ENERO"),
	(2, "FEBRERO"),
	(3, "MARZO"),
	(4, "ABRIL"),
	(5, "MAYO"),
	(6, "JUNIO"),
	(7, "JULIO"),
	(8, "AGOSTO"),
	(9, "SEPTIEMBRE"),
	(10, "OCTUBRE"),
	(11, "NOVIEMBRE"),
	(12, "DICIEMBRE");
			
CREATE FUNCTION dameMes (n INT)
RETURNS VARCHAR(20) DETERMINISTIC
RETURN (SELECT Mes FROM Meses WHERE Num=n);

/* Nos muestra el mes que corresponda al número */
SELECT dameMes(1);
SELECT dameMes(2);

delimiter //

CREATE PROCEDURE imprimeMeses ()
BEGIN
DECLARE i INT DEFAULT 1;

  SELECT * FROM Meses;
 
END //
	
delimiter ;

CALL imprimeMeses;
