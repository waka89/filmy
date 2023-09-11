CREATE OR ALTER  PROCEDURE DodajFilm
  @Tytul nvarchar(100),
  @KrajID int,
  @CzasTrwania time,
  @Opis nvarchar(max),
  @GatunekID int,
  @Premiera date,
  @RezyseriaID int
AS
BEGIN
	
	SET NOCOUNT ON

	-- walidacja
	IF NOT EXISTS(SELECT * FROM Rezyser WHERE RezyserID = @RezyseriaID )
	BEGIN
	  RAISERROR('Brak rezysera w bazie!', 11, 1)
	  RETURN -1
	END

	IF NOT EXISTS(SELECT * FROM Gatunek WHERE GatunekID = @GatunekID )
	BEGIN
	  RAISERROR('Brak gatunku w bazie!', 11, 1)
	  RETURN -1
	END

	IF NOT EXISTS(SELECT * FROM Kraj WHERE KrajID = @KrajID )
	BEGIN
	  RAISERROR('Brak kraju w bazie!', 11, 1)
	  RETURN -1
	END

	IF EXISTS(SELECT * FROM Film WHERE Tytul = @Tytul )
	BEGIN
	  RAISERROR('Jest ju¿ taki film!', 11, 1);
	  RETURN -1;
	END

	BEGIN TRY
	BEGIN TRAN

		INSERT INTO Film (Tytul, KrajID, CzasTrwania, Opis, GatunekID, Premiera, RezyseriaID)
		VALUES (@Tytul, @KrajID, @CzasTrwania, @Opis, @GatunekID, @Premiera, @RezyseriaID)

	COMMIT
	END TRY
	BEGIN CATCH

		ROLLBACK;
		THROW;

	END CATCH

	SELECT SCOPE_IDENTITY() AS FilmID



END
GO