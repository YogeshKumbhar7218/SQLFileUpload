CREATE DATABASE Archive 
ON
PRIMARY ( NAME = Arch1,
    FILENAME = 'Y:\data\archdat1.mdf'),
FILEGROUP FileStreamGroup1 CONTAINS FILESTREAM ( NAME = Arch3,
    FILENAME = 'Y:\data\filestream1')
LOG ON  ( NAME = Archlog1,
    FILENAME = 'Y:\data\archlog1.ldf')
GO

CREATE TABLE Document
(
    [Id] INT IDENTITY(1,1) PRIMARY KEY,
    [DocumentID] INT NOT NULL,
    [DocumentType] NVARCHAR(50) NOT NULL,
    [FileContent] VARBINARY(MAX) FILESTREAM NOT NULL,
    [DateInserted] DATETIME NOT NULL
)
GO

ALTER DATABASE Archive
  SET FILESTREAM ( NON_TRANSACTED_ACCESS = FULL, DIRECTORY_NAME = N'data' );







--temp--
CREATE TABLE Archive.dbo.Records
(
    [Id] [uniqueidentifier] ROWGUIDCOL NOT NULL UNIQUE, 
    [SerialNumber] INTEGER UNIQUE,
    [Chart] VARBINARY(MAX) FILESTREAM NULL
);
GO

INSERT INTO Archive.dbo.Records
    VALUES (NEWID(), 1, NULL);
GO

INSERT INTO Archive.dbo.Records
    VALUES (NEWID(), 2, 
      CAST ('' AS VARBINARY(MAX)));
GO

INSERT INTO Archive.dbo.Records
    VALUES (NEWID(), 3, 
      CAST ('Seismic Data' AS VARBINARY(MAX)));
GO

UPDATE Archive.dbo.Records
SET [Chart] = CAST('Xray 1' AS VARBINARY(MAX))
WHERE [SerialNumber] = 2;

GO

DELETE Archive.dbo.Records
WHERE SerialNumber = 1;
GO

SELECT Chart FROM Archive.dbo.Records

--temp--




--SELECT DB_NAME(database_id), non_transacted_access, non_transacted_access_desc
--    FROM sys.database_filestream_options;
--GO


--_optionsApplicationConfiguration.Value.ServerUploadFolder, fileName));
--                    }



--var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
--                        contentTypes.Add(file.ContentType);
--                        names.Add(fileName);

--var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);


--fileTable--

SELECT DB_NAME(database_id),
non_transacted_access,
non_transacted_access_desc
FROM sys.database_filestream_options;
GO

CREATE TABLE WebApiUploads AS FileTable
WITH
(FileTable_Directory = 'WebApiUploads_Dir');
GO

select * from WebApiUploads

Go

INSERT INTO [WebApiUploads]
([name],[file_stream])
SELECT
'NewFile2.txt', * FROM OPENROWSET(BULK N'C:\Users\hp\Downloads\clinical.png', SINGLE_BLOB) AS FileData
GO


CREATE TABLE [dbo].[FileDescriptions](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FileName] [nvarchar](max) NULL,
    [Description] [nvarchar](max) NULL,
    [CreatedTimestamp] [datetime] NOT NULL,
    [UpdatedTimestamp] [datetime] NOT NULL,
    [ContentType] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.FileDescription] PRIMARY KEY CLUSTERED 
(
    [Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--fileTable--