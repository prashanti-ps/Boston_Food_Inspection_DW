/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Dim_model.DM1
 *
 * Date Created : Thursday, February 24, 2022 12:30:05
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: DimDate 
 */

CREATE TABLE DimDate(
    DateKey      date             NOT NULL,
    Year         char(64)         NULL,
    Month        char(64)         NULL,
    Week         char(64)         NULL,
    Day          char(64)         NULL,
    MonthName    nvarchar(max)    NULL,
    CONSTRAINT PK__DimDate__40DF45E307159585 PRIMARY KEY CLUSTERED (DateKey)
)

go


IF OBJECT_ID('DimDate') IS NOT NULL
    PRINT '<<< CREATED TABLE DimDate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimDate >>>'
go

/* 
 * TABLE: DimGeography 
 */

CREATE TABLE DimGeography(
    GeographyKey    int             NOT NULL,
    CITY            varchar(254)    NULL,
    State           varchar(254)    NULL,
    ZIP             varchar(254)    NULL,
    CONSTRAINT PK__DimGeogr__F81E8E6BD95D4EF0 PRIMARY KEY CLUSTERED (GeographyKey)
)

go


IF OBJECT_ID('DimGeography') IS NOT NULL
    PRINT '<<< CREATED TABLE DimGeography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimGeography >>>'
go

/* 
 * TABLE: DimLicense 
 */

CREATE TABLE DimLicense(
    LicenseKey         int             NOT NULL,
    Name               varchar(254)    NULL,
    LicenseNo          varchar(254)    NULL,
    IssueDate          date            NULL,
    ExpiryDate         date            NULL,
    LicenseCategory    varchar(254)    NULL,
    CONSTRAINT PK__DimLicen__45E1DD6E7627B2F0 PRIMARY KEY CLUSTERED (LicenseKey)
)

go


IF OBJECT_ID('DimLicense') IS NOT NULL
    PRINT '<<< CREATED TABLE DimLicense >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimLicense >>>'
go

/* 
 * TABLE: DimRestaurant 
 */

CREATE TABLE DimRestaurant(
    RestaurantKey    int             NOT NULL,
    GeographyKey     int             NULL,
    TypeKey          int             NULL,
    businessname     varchar(254)    NULL,
    legalowner       varchar(254)    NULL,
    address          varchar(254)    NULL,
    Phone            varchar(254)    NULL,
    property_id      varchar(254)    NULL,
    Latitude         varchar(254)    NULL,
    Longitude        varchar(254)    NULL,
    CONSTRAINT PK__DimResta__B70B3E586CB067CC PRIMARY KEY CLUSTERED (RestaurantKey)
)

go


IF OBJECT_ID('DimRestaurant') IS NOT NULL
    PRINT '<<< CREATED TABLE DimRestaurant >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimRestaurant >>>'
go

/* 
 * TABLE: DimType 
 */

CREATE TABLE DimType(
    TypeKey            int             NOT NULL,
    TypeDescription    varchar(254)    NULL,
    CONSTRAINT PK__DimType__EDA2224411D360AF PRIMARY KEY CLUSTERED (TypeKey)
)

go


IF OBJECT_ID('DimType') IS NOT NULL
    PRINT '<<< CREATED TABLE DimType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimType >>>'
go

/* 
 * TABLE: DimViolation 
 */

CREATE TABLE DimViolation(
    ViolationKey    int             NOT NULL,
    violation       varchar(254)    NULL,
    viollevel       varchar(254)    NULL,
    violdesc        varchar(254)    NULL,
    CONSTRAINT PK__DimViola__CBDB5020AD387A7C PRIMARY KEY CLUSTERED (ViolationKey)
)

go


IF OBJECT_ID('DimViolation') IS NOT NULL
    PRINT '<<< CREATED TABLE DimViolation >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimViolation >>>'
go

/* 
 * TABLE: DimViolationResult 
 */

CREATE TABLE DimViolationResult(
    ResultKey           int             NOT NULL,
    Result              varchar(254)    NULL,
    ResultDateKey       date            NULL,
    ViolationDateKey    date            NULL,
    Comments            varchar(500)    NULL,
    CONSTRAINT PK__DimViola__47DC2449CC9C9780 PRIMARY KEY CLUSTERED (ResultKey)
)

go


IF OBJECT_ID('DimViolationResult') IS NOT NULL
    PRINT '<<< CREATED TABLE DimViolationResult >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimViolationResult >>>'
go

/* 
 * TABLE: FactInspection 
 */

CREATE TABLE FactInspection(
    RestaurantKey    int             NOT NULL,
    ViolationKey     int             NOT NULL,
    LicenseKey       int             NOT NULL,
    ResultKey        int             NOT NULL,
    StatusDate       date            NULL,
    Result           varchar(254)    NULL,
    CONSTRAINT PK__FactInsp__8077174562D565A8 PRIMARY KEY CLUSTERED (RestaurantKey, ViolationKey, LicenseKey, ResultKey)
)

go


IF OBJECT_ID('FactInspection') IS NOT NULL
    PRINT '<<< CREATED TABLE FactInspection >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FactInspection >>>'
go

/* 
 * TABLE: DimLicense 
 */

ALTER TABLE DimLicense ADD CONSTRAINT FK__DimLicens__Expir__1DB06A4F 
    FOREIGN KEY (ExpiryDate)
    REFERENCES DimDate(DateKey)
go

ALTER TABLE DimLicense ADD CONSTRAINT FK__DimLicens__Issue__1CBC4616 
    FOREIGN KEY (IssueDate)
    REFERENCES DimDate(DateKey)
go


/* 
 * TABLE: DimRestaurant 
 */

ALTER TABLE DimRestaurant ADD CONSTRAINT FK__DimRestau__Geogr__40F9A68C 
    FOREIGN KEY (GeographyKey)
    REFERENCES DimGeography(GeographyKey)
go

ALTER TABLE DimRestaurant ADD CONSTRAINT FK__DimRestau__TypeK__41EDCAC5 
    FOREIGN KEY (TypeKey)
    REFERENCES DimType(TypeKey)
go


/* 
 * TABLE: DimViolationResult 
 */

ALTER TABLE DimViolationResult ADD CONSTRAINT FK__DimViolat__Resul__45BE5BA9 
    FOREIGN KEY (ResultDateKey)
    REFERENCES DimDate(DateKey)
go

ALTER TABLE DimViolationResult ADD CONSTRAINT FK__DimViolat__Viola__46B27FE2 
    FOREIGN KEY (ViolationDateKey)
    REFERENCES DimDate(DateKey)
go


/* 
 * TABLE: FactInspection 
 */

ALTER TABLE FactInspection ADD CONSTRAINT FK__FactInspe__Licen__531856C7 
    FOREIGN KEY (LicenseKey)
    REFERENCES DimLicense(LicenseKey)
go

ALTER TABLE FactInspection ADD CONSTRAINT FK__FactInspe__Resta__51300E55 
    FOREIGN KEY (RestaurantKey)
    REFERENCES DimRestaurant(RestaurantKey)
go

ALTER TABLE FactInspection ADD CONSTRAINT FK__FactInspe__Resul__540C7B00 
    FOREIGN KEY (ResultKey)
    REFERENCES DimViolationResult(ResultKey)
go

ALTER TABLE FactInspection ADD CONSTRAINT FK__FactInspe__Statu__503BEA1C 
    FOREIGN KEY (StatusDate)
    REFERENCES DimDate(DateKey)
go

ALTER TABLE FactInspection ADD CONSTRAINT FK__FactInspe__Viola__5224328E 
    FOREIGN KEY (ViolationKey)
    REFERENCES DimViolation(ViolationKey)
go


