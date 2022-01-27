-- tHE TABLE BELOW WILL HAVE THE EXTRACTED VALUES FOR THE COLUMNS AND WILL BE USED TO POPULATE THE BEERNOW TABLE

declare @resulttable taBLE (
comment VARCHAR(MAX),
	look float ,
	smelL floaT,
	taste floaT,
	feel float,
	overall VARCHAR (MAX),
	ORIGINAL VARCHAR(MAX))

-- THE TABLE BELOW NEEDS TO BE CREATED FOR THE FIRST TIME AND USED TO STORE BAD RECORDS
--create table ##ignoretable  (
--comment VARCHAR(MAX),
--	look varchar ,
--	smelL varchar,
--	taste varchar,
--	feel varchar,
--	overall VARCHAR (MAX),
--	ORIGINAL VARCHAR(MAX))

--THE LOOP BELOW IS USED FOR INSERT OF RECORDS FROM RESULT TABLE TO BEERNOW TABLE
Declare @loopCounter int
set @loopCounter=3

While(@loopCounter>0)
BEGIN

	Declare @stringVal varchar(max)
	Declare @oRIGINALVal varchar(max)
	Declare @startofOverall int
	Declare @endofOverall int
	Declare @overall varchar(max)
	Declare @VAR int
	Declare @overall1 varchar(max)
	Declare @num1 int
	Declare @finov varchar(max)
	Declare @finov1 int
	Declare @startoflook int
	Declare @look varchar(max)
	Declare @VARlook int
	Declare @finlook varchar (max)
	Declare @num2 int
	declare @startofsmell int
	Declare @smell varchar(max)
	Declare @VARsmell int
	Declare @finsmell varchar (max)
	Declare @num3 int
	declare @startoftaste int
	Declare @taste varchar(max)
	Declare @VARtaste int
	Declare @fintaste varchar (max)
	Declare @num4 int
	declare @startoffeel int
	Declare @feel varchar(max)
	Declare @VARfeel int
	Declare @finfeel varchar (max)
	Declare @num5 int
	Declare main_cursor13 cursor for
	--SELECTING ONLY THE RECORDS WHICH ARE NOT YET UPDATED
	select top 1500 comment from msbateam10..BEERNOW 
	WHERE OVERALL IS NULL
	and convert(varchar,comment)  not in (select ORIGINAL from ##ignoretable)
	for update of BEERNOW.comment,
	BEERNOW.look,
	BEERNOW.smell,
	BEERNOW.taste,
	BEERNOW.feel,
	BEERNOW.overall
--CURSOR TO EXTRACT RECORDS
	Open main_cursor13
	Fetch Next From main_cursor13 into @stringVal
	WHILE @@FETCH_STATUS=0
	BEGIN
	SET @oRIGINALVal=@stringVal
	Declare @fincomment varchar (max)
	Declare @i int = 1
	--EXTRACTED THE RECORDS BASED ON INDEX OR POSITION IN THE COMMENT STRING
	set @startofOverall= CHARINDEX('Overall:', @stringVal) +9
	set @endofOverall = CHARINDEX(' ', @stringVal, CHARINDEX('Overall:', @stringVal))
	set @overall = SUBSTRING(@stringVal, @startofOverall, LEN(@stringVal))
	SET @VAR = PATINDEX('%[a-zA-Z-_@#$%&!~*()^,/?\|~]%', SUBSTRING(@stringVal, @startofOverall, len(@stringVal)))-1
	set @overall1 = SUBSTRING(@stringVal, @startofOverall, @var)
	set @num1 = patindex ('%[.]%', SUBSTRING(@stringVal, @startofOverall,@VAR ))
	--CHECKING IF THE OVERALL HAS VALUE AGAINST IT OR IT IS JUST PART OF A STRING
	if @startofOverall > 9
	begin
	IF @VAR = 0
	BEGIN
	SET @FINOV = null
	END
	ELSE
	BEGIN
	if @num1 = 2
	begin
	-- IF OVERALL HAS VALUE AGAINST IT
	set @finov = substring(@overall1,1,@num1+2)
	end
	else
	begin
	set @finov = substring(@overall1,1,1)
	end
	END
	end
	else
	begin
	SET @FINOV = null
	end

	set @finov1 = len(@finov)
	set @startoflook = CHARINDEX('look:', @stringVal)+6
	set @look = SUBSTRING(@stringVal, @startoflook, LEN(@stringVal))
	SET @VARlook = PATINDEX('%[a-zA-Z]%', @look)-1
	set @num2 = patindex ('%[.]%', SUBSTRING(@stringVal, @startoflook,@VARlook ))
	if @startoflook > 6
	begin
	IF @VARlook = 0
	BEGIN
	SET @FINlook = null
	END
	ELSE
	BEGIN
	set @finlook = substring(substring(@stringVal, @startoflook, @varlook ),1,@num2+2)
	END
	end
	else
	begin
	SET @FINlook = null
	end
	set @startofsmell = CHARINDEX('smell:', @stringVal)+7
	set @smell = SUBSTRING(@stringVal, @startofsmell, LEN(@stringVal))
	SET @VARsmell = PATINDEX('%[a-z][A-Z]%', @smell)-1
	set @num3 = patindex ('%[.]%', SUBSTRING(@stringVal, @startofsmell,@VARsmell))
	if @startofsmell > 7
	begin
	IF @VARsmell = 0
	BEGIN
	SET @FINsmell = null
	END
	ELSE
	BEGIN
	set @finsmell = substring(substring(@stringVal, @startofsmell, @varsmell),1,@num3+2)
	END
	end
	else
	begin
	SET @finsmell = null
	end
	set @startoftaste = CHARINDEX('taste:', @stringVal)+7
	set @taste = SUBSTRING(@stringVal, @startoftaste, LEN(@stringVal))
	SET @VARtaste = PATINDEX('%[a-z][A-Z]%', @taste)-1
	set @num4 = patindex ('%[.]%', SUBSTRING(@stringVal, @startoftaste,@VARtaste))
	if @startoftaste > 7
	begin
	IF @VARtaste = 0
	BEGIN
	SET @FINtaste = null
	END
	ELSE
	BEGIN
	set @fintaste = substring(substring(@stringVal, @startoftaste, @vartaste),1,@num4+2)
	END
	end
	else
	begin
	SET @FINtaste = null
	end
	set @startoffeel = CHARINDEX('feel:', @stringVal)+6
	set @feel = SUBSTRING(@stringVal, @startoffeel, LEN(@stringVal))
	SET @VARfeel = PATINDEX('%[a-z][A-Z]%', @look)-1
	set @num5 = patindex ('%[.]%', SUBSTRING(@stringVal, @startoffeel,@VARlook ))
	if @startoffeel > 6
	begin
	IF @VARfeel = 0
	BEGIN
	SET @FINfeel = null
	END
	ELSE
	BEGIN
	set @finfeel = substring(substring(@stringVal, @startoffeel, @varlook),1,@num5+2)
	END
	end
	else
	begin
	SET @FINfeel = null
	end
	set @fincomment = substring(@overall,@finov1+1,len(@stringVal))
	--ONLY RETRIEVING VALIF RECORDS FOR INSERT ELSE PLACING A DUMMY VALUE FOR FURTHER ANALYSIS OF DATA
	if((@FINLOOK is null or ISNUMERIC(@FINLOOK)=1) and (@FINSMELL is null or ISNUMERIC(@FINSMELL)=1) and (@FINTASTE is null or ISNUMERIC(@FINTASTE)=1) and (@FINFEEL is null or ISNUMERIC(@FINFEEL)=1))
	BEGIN
		if(@FINOV is null)
			set @finov='Abhi'
		INSERT INTO @resulttable VALUES(@fincomment,
		@FINLOOK,@FINSMELL, @FINTASTE, @FINFEEL, @FINOV, @oRIGINALVal)
	END
	else
		INSERT INTO ##ignoretable VALUES(@fincomment,
		@FINLOOK,@FINSMELL, @FINTASTE, @FINFEEL, @FINOV, @oRIGINALVal)
	set @i = @i+1
	if @i  = 500
	begin
	 commit
	 set @i = 0
	end
	Fetch Next from main_cursor13
	into @stringVal
	END
	CLOSE main_cursor13
	DEALLOCATE main_cursor13
	--UPDATE FROM TEMPORARY(RESULT) TABLE TO BEERNOW TABLE
update B
	set B.comment = R.COMMENT
	, B.LOOK = R.LOOK
	,B.SMELL = R.SMELL
	,B.TASTE = R.TASTE
	,B.FEEL = R.feel
	,B.Overall = R.OVERALL
	FROM msbateam10..BEERNOW B INNER JOIN @resulttable R
	ON B.comment like R.ORIGINAL
	
Delete from @resulttable
set @loopCounter=@loopCounter-1
Select @loopCounter
END 

select * from ##ignoretable
