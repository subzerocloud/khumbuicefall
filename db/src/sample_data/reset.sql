BEGIN;
\set QUIET on
\set ON_ERROR_STOP on
set client_min_messages to warning;
set search_path = data, public;
truncate data.todo restart identity cascade;
truncate data.user restart identity cascade;
truncate data.client restart identity cascade;
truncate data.project restart identity cascade;
truncate data.task restart identity cascade;
truncate data.project_comment restart identity cascade;
truncate data.task_comment restart identity cascade;
\ir data.sql
COMMIT;