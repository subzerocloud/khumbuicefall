BEGIN;
\set QUIET on
\set ON_ERROR_STOP on
set client_min_messages to warning;
set search_path = data, public;
truncate todo restart identity cascade;
truncate user restart identity cascade;
truncate client restart identity cascade;
truncate project restart identity cascade;
truncate task restart identity cascade;
truncate project_comment restart identity cascade;
truncate task_comment restart identity cascade;
\ir data.sql
COMMIT;