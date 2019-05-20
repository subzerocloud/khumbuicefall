-- db/src/libs/util/schema.sql
drop schema if exists util cascade;
create schema util;
set search_path = util, public;
-- ...
\ir mutation_comments_trigger.sql;
