--criação do banco de dados
CREATE DATABASE "banco-driven";
\c banco-driven;

--tabela states
CREATE TABLE states (
    id SERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);

--tabela cities
CREATE TABLE cities (
    id SERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    "stateId" INTEGER REFERENCES states(id)
);

--tabela customers
CREATE TABLE customers (
    id SERIAL NOT NULL PRIMARY KEY,
    "fullName" TEXT NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

--tabela customerAddresses
CREATE TABLE "customerAddresses" (
    id SERIAL NOT NULL PRIMARY KEY,
    "customerId" INTEGER REFERENCES customers(id) UNIQUE,
    street TEXT NOT NULL,
    number INTEGER NOT NULL,
    complement TEXT,
    "postalCode" VARCHAR(8) NOT NULL,
    "cityId" INTEGER REFERENCES cities(id)
);

--tabela customerPhones
CREATE TABLE "customerPhones" (
    id SERIAL NOT NULL PRIMARY KEY,
    "customerId" INTEGER REFERENCES customers(id),
    number VARCHAR(9) NOT NULL,
    type TEXT
);

--tabela bankAccount
CREATE TABLE "bankAccount" (
    id SERIAL NOT NULL PRIMARY KEY,
    "customerId" INTEGER REFERENCES customers(id),
    "accountNumber" TEXT NOT NULL UNIQUE,
    agency TEXT NOT NULL,
    "openDate" DATE NOT NULL DEFAULT NOW(),
    "closeDate" DATE
);

--tabela transactions
CREATE TABLE transactions (
    id SERIAL NOT NULL PRIMARY KEY,
    "bankAccountId" INTEGER REFERENCES "bankAccount"(id),
    amount NUMERIC NOT NULL,
    type TEXT NOT NULL,
    time TIMESTAMP NOT NULL DEFAULT NOW(),
    description TEXT,
    cancelled BOOLEAN NOT NULL DEFAULT false
);

--tabela creditCards
CREATE TABLE "creditCards" (
    id SERIAL NOT NULL PRIMARY KEY,
    "bankAccountId" INTEGER REFERENCES "bankAccount"(id),
    name TEXT NOT NULL,
    number VARCHAR(16) NOT NULL UNIQUE,
    "securityCode" VARCHAR(3) NOT NULL,
    "expirationMonth" VARCHAR(2) NOT NULL,
    "expirationYear" VARCHAR(4) NOT NULL,
    password TEXT NOT NULL,
    "limit" NUMERIC NOT NULL DEFAULT 0
);

