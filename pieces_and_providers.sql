CREATE TABLE Pieces (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL
);

CREATE TABLE Providers (
 Code TEXT PRIMARY KEY NOT NULL,
 Name TEXT NOT NULL
);

CREATE TABLE Provides (
  Piece INTEGER
    CONSTRAINT fk_Pieces_Code REFERENCES Pieces(Code),
  Provider TEXT
    CONSTRAINT fk_Providers_Code REFERENCES Providers(Code),
  Price INTEGER NOT NULL,
  PRIMARY KEY(Piece, Provider)
);

INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

-- 1. Select the name of all the pieces. (Seleccione el nombre de todas las piezas).

select name from pieces;

-- 2. Select all the providers' data. (Seleccione todos los datos de los proveedores (providers)).

select * from providers;

-- 3. Obtain the average price of each piece (show only the piece code and the average price).

select piece, avg(price)
from provides
group by piece;

-- 4. Obtain the names of all providers who supply piece 1.

select providers.name
from providers
inner join provides on providers.code = provides.provider
  and provides.piece = 1;

-- 5. Select the name of pieces provided by provider with code "HAL".

select pieces.names
from Pieces
inner join provides on pieces.code = provides.piece
  and provides.provider = 'HAL';

select names
from Pieces
where code in (
  select piece from provides where provider = 'HAL'
);

-- 6. For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).

select piece.name piece_name, provider.name provider_name, provides.price
from provides
inner join pieces on provides.piece = pieces.code
inner join provider on provides.provider = providers.code;
where provides.price = (
  select max(price) from provides
  where piece = pieces.code
);

-- 7. Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.

insert into provides
  values(1, 'TNBC', 7);

-- 8. Increase all prices by one cent.

update provides
  set price = price + 1;

-- 9. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).

delete from Provides
  where provider = 'RBT' and piece = 4;

-- 10. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should still remain in the database).

delete from Provides
  where provider = 'RBT';
