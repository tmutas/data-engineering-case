create schema if not exists raw;
create schema if not exists modelled;

create table if not exists raw.raw_data (
    "Mould ID" integer,
    "mould name" varchar(100),
    "mould family" varchar(100),
    "line ID" integer,
    "line name" varchar(100),
    "scheduled day" date,
    "scheduled shift" varchar(20),
    "scheduled quantity" integer,
    "article ID" integer,
    "article code" integer,
    "article description" varchar(1000),
    "article category" varchar(100),
    "production process status" varchar(20),
    "production process id" integer,
    "production day" date,
    "shift" varchar(20),
    "quantity produced" integer,
    "quantity discarded" integer,
    "comment" varchar(1000) default null,
    "batch_number" integer
)

create type SHIFT as enum ('Day', 'Evening', 'Night');
create type STATUS as enum ('Completed', 'Active');

create table if not exists modelled.dim_mould (
    "Mould ID" integer primary key,
    "mould name" varchar(100),
    "mould family" varchar(100)
);

create table if not exists modelled.dim_line (
    "line ID" integer primary key,
    "line name" varchar(100)
);

create table if not exists modelled.dim_article (
    "article ID" integer primary key,
    "article code" integer,
    "article description" varchar(1000) default null,
    "article category" varchar(100)
);


create table if not exists modelled.fact_production_processes (
    "Mould ID" integer references modelled.dim_mould("Mould ID"),
    "line ID" integer references modelled.dim_line("line ID"),
    "scheduled day" date,
    "scheduled shift" shift,
    "scheduled quantity" integer check ("scheduled quantity" > 0),
    "article ID" integer references modelled.dim_article("article ID"),
    "production process status" STATUS,
    "production process id" integer primary key generated by default as identity,
    "production day" date,
    "shift" shift,
    "quantity produced" integer check ("quantity produced" >= 0),
    "quantity discarded" integer check ("quantity discarded"  >= 0),
    "comment" varchar(1000) default null,
    "batch_number" integer,
    check ("quantity produced" >= "quantity discarded")
);