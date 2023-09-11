CREATE VIEW Aktorzy
AS
SELECT Aktor.*, Osoba.Imie, Osoba.Nazwisko
FROM Osoba
JOIN Aktor ON Osoba.OsobaID = Aktor.OsobaID
GO