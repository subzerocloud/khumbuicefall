create or replace view clients as
select id, name, address, created_on, updated_on from data.client;

create or replace view projects as
select id, name, client_id, created_on, updated_on from data.project;

create or replace view tasks as
select id, name, completed, project_id, created_on, updated_on from data.task;

create or replace view project_comments as
select id, body, project_id, created_on, updated_on from data.project_comment;

create or replace view task_comments as
select id, body, task_id, created_on, updated_on from data.task_comment;

create or replace view comments as
select 
  id, body, 'project'::text as parent_type, project_id as parent_id, 
  project_id, null as task_id, created_on, updated_on
from data.project_comment
union
select id, body, 'task'::text as parent_type, task_id as parent_id,
  null as project_id, task_id, created_on, updated_on
from data.task_comment;

-- ...
alter view clients owner to api;
alter view projects owner to api;
alter view tasks owner to api;
alter view comments owner to api;

-- ...
create trigger comments_mutation
instead of insert or update or delete on comments
for each row execute procedure util.mutation_comments_trigger();