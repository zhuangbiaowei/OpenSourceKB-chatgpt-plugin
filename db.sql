CREATE TABLE openSourceProject (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    description TEXT,
    website VARCHAR(255),
    product VARCHAR(255),
    community VARCHAR(255),
    foundation VARCHAR(255),
    member TEXT,
    history TEXT,
    devService VARCHAR(255),
    bugTracker VARCHAR(255),
    wiki VARCHAR(255),
    source VARCHAR(255),
    mailingList VARCHAR(255),
    forum VARCHAR(255),
    agreement TEXT
);
CREATE TABLE people (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    nickname VARCHAR(255),
    type VARCHAR(255),
    email VARCHAR(255),
    twitter VARCHAR(255),
    facebook VARCHAR(255),
    weixin VARCHAR(255),
    QQ VARCHAR(255),
    website VARCHAR(255),
    blog VARCHAR(255),
    sex VARCHAR(255),
    country VARCHAR(255),
    city VARCHAR(255),
    company VARCHAR(255),
    community VARCHAR(255),
    project VARCHAR(255),
    fundation VARCHAR(255),
    devService VARCHAR(255)
);
CREATE TABLE peopleEvent (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(255),
    actor VARCHAR(255),
    project VARCHAR(255),
    community VARCHAR(255),
    issue_id VARCHAR(255),
    extInfo VARCHAR(255),
    devService VARCHAR(255)
);
CREATE TABLE openSourceProduct (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    authors VARCHAR(255),
    publisher VARCHAR(255),
    website VARCHAR(255),
    downloadUrl VARCHAR(255),
    components VARCHAR(255),
    language VARCHAR(255),
    project VARCHAR(255)
);
CREATE TABLE agreement (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    identifier VARCHAR(255),
    type VARCHAR(255),
    name VARCHAR(255),
    text VARCHAR(255),
    url VARCHAR(255)
);
CREATE TABLE copyright (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text VARCHAR(255),
    url VARCHAR(255)
);
CREATE TABLE patent (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255),
    application_no VARCHAR(255),
    publication_date VARCHAR(255),
    country VARCHAR(255),
    url VARCHAR(255)
);
CREATE TABLE version (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product VARCHAR(255),
    version VARCHAR(255),
    agreement VARCHAR(255),
    patent VARCHAR(255),
    copyright VARCHAR(255),
    purl VARCHAR(255),
    swid VARCHAR(255),
    platform VARCHAR(255),
    releaseDate VARCHAR(255)
);
CREATE TABLE CVE (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    CVEID VARCHAR(255),
    description VARCHAR(255),
    cvss2Score VARCHAR(255),
    cvss3Score VARCHAR(255),
    refs VARCHAR(255),
    cweList VARCHAR(255),
    cpe VARCHAR(255),
    published VARCHAR(255),
    modified VARCHAR(255),
    affectedPackages VARCHAR(255),
    affectedVersions VARCHAR(255)
);
CREATE TABLE issue (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255),
    description VARCHAR(255),
    refs VARCHAR(255),
    created VARCHAR(255),
    modified VARCHAR(255),
    product VARCHAR(255),
    project VARCHAR(255),
    version VARCHAR(255)
);
CREATE TABLE repository (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    vcsType VARCHAR(255),
    repoType VARCHAR(255),
    owner VARCHAR(255),
    project VARCHAR(255),
    url VARCHAR(255),
    devService VARCHAR(255)
);
CREATE TABLE branch (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    repo VARCHAR(255),
    commitId VARCHAR(255),
    protected VARCHAR(255)
);
CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    repo VARCHAR(255),
    commitId VARCHAR(255),
    zipballUrl VARCHAR(255),
    tarballUrl VARCHAR(255)
);
CREATE TABLE artifact (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    packageFormat VARCHAR(255),
    description VARCHAR(255),
    version VARCHAR(255),
    author VARCHAR(255),
    contributors VARCHAR(255),
    product VARCHAR(255),
    filename VARCHAR(255),
    size VARCHAR(255),
    gav VARCHAR(255),
    mirrors VARCHAR(255)
);
CREATE TABLE packageManegementTool (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    language VARCHAR(255),
    platform VARCHAR(255),
    website VARCHAR(255),
    project VARCHAR(255),
    packageFormat VARCHAR(255)
);
CREATE TABLE devService (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    country VARCHAR(255),
    website VARCHAR(255),
    supportPackageFormat VARCHAR(255),
    extInfo TEXT
);
CREATE TABLE mirror (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(255),
    language VARCHAR(255),
    website VARCHAR(255),
    supportTool VARCHAR(255)
);
CREATE TABLE community (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    members VARCHAR(255),
    website VARCHAR(255),
    description VARCHAR(255),
    project VARCHAR(255),
    product VARCHAR(255),
    newsletter VARCHAR(255),
    blog VARCHAR(255),
    Media VARCHAR(255)
);
CREATE TABLE foundation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    members VARCHAR(255),
    website VARCHAR(255),
    description VARCHAR(255),
    projects VARCHAR(255),
    products VARCHAR(255),
    newsletter VARCHAR(255),
    blog VARCHAR(255),
    Media VARCHAR(255)
);
CREATE TABLE mediaPlatform (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    website VARCHAR(255)
);
CREATE TABLE orgBehavior (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    org_name VARCHAR(255),
    org_type VARCHAR(255),
    actionName VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    beginDate VARCHAR(255),
    endDate VARCHAR(255),
    extInfo TEXT
);