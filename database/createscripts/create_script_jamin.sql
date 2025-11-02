-- Step: 01
-- Goal: Create a new database laravel
-- **********************************************************************************
-- Version       Date:           Author:                     Description:
-- *******       **********      ****************            ******************
-- 01            12-09-2025      Arjan de Ruijter            New Database
-- **********************************************************************************/

-- Check if the database exists
DROP DATABASE IF EXISTS laravel;

-- Create a new Database
CREATE DATABASE laravel;

-- Use database laravel
Use laravel;


-- Step: 02
-- Goal: Create a new table Allergeen
-- **********************************************************************************
-- Version       Date:           Author:                     Description:
-- *******       **********      ****************            ******************
-- 01            12-09-2025      Arjan de Ruijter            New table
-- **********************************************************************************/

-- Drop table Instructeur
DROP TABLE IF EXISTS Allergeen;

CREATE TABLE IF NOT EXISTS Allergeen
(
    Id              SMALLINT         UNSIGNED       NOT NULL    AUTO_INCREMENT
   ,Naam            VARCHAR(30)                     NOT NULL
   ,Omschrijving    VARCHAR(60)                     NOT NULL
   ,IsActief        BIT                             NOT NULL    DEFAULT 1
   ,Opmerkingen     VARCHAR(250)                        NULL    DEFAULT NULL
   ,DatumAangemaakt DateTime(6)                     NOT NULL    DEFAULT (SYSDATE(6))
   ,DatumGewijzigd  DateTime(6)                     NOT NULL    DEFAULT (SYSDATE(6))
   ,CONSTRAINT      PK_Allergeen_Id   PRIMARY KEY CLUSTERED(Id)
) ENGINE=InnoDB;


-- Step: 03
-- Goal: Fill table Allergeen with data
-- **********************************************************************************

-- Version       Date:           Author:                     Description:
-- *******       **********      ****************            ******************
-- 01            12-09-2025      Arjan de Ruijter            New data
-- **********************************************************************************/

INSERT INTO Allergeen
(
     Naam
    ,Omschrijving
)
VALUES
     ('Gluten', 'Dit product bevat gluten')
    ,('Gelatine', 'Dit product bevat gelatine')
    ,('AZO-kleurstof', 'Dit product bevat AZO-kleurstof')
    ,('Lactose', 'Dit product bevat lactose')
    ,('Soja', 'Dit product bevat soja');


--