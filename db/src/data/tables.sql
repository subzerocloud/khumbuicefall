create table client (
  id           serial primary key,
  name         text not null,
  address      text,
  user_id      int not null references "user"(id) default request.user_id(),
  created_on   timestamptz not null default now(),
  updated_on   timestamptz,
  check (length(name)>2 and length(name)<100),
  check (updated_on is null or updated_on > created_on)
);
create index client_user_id_index on client(user_id);

create table project (
  id           serial primary key,
  name         text not null,
  client_id    int not null references client(id),
  user_id      int not null references "user"(id) default request.user_id(),
  created_on   timestamptz not null default now(),
  updated_on   timestamptz,
  check (length(name)>2),
  check (updated_on is null or updated_on > created_on)
);
create index project_user_id_index on project(user_id);
create index project_client_id_index on project(client_id);

create table task (
  id           serial primary key,
  name         text not null,
  completed    bool not null default false,
  project_id   int not null references project(id),
  user_id      int not null references "user"(id) default request.user_id(),
  created_on   timestamptz not null default now(),
  updated_on   timestamptz,
  check (length(name)>2),
  check (updated_on is null or updated_on > created_on)
);
create index task_user_id_index on task(user_id);
create index task_project_id_index on task(project_id);

create table project_comment (
  id           serial primary key,
  body         text not null,
  project_id   int not null references project(id),
  user_id      int not null references "user"(id) default request.user_id(),
  created_on   timestamptz not null default now(),
  updated_on   timestamptz,
  check (length(body)>2),
  check (updated_on is null or updated_on > created_on)
);
create index project_comment_user_id_index on project_comment(user_id);
create index project_comment_project_id_index on project_comment(project_id);

create table task_comment (
  id           serial primary key,
  body         text not null,
  task_id      int not null references task(id),
  user_id      int not null references "user"(id) default request.user_id(),
  created_on   timestamptz not null default now(),
  updated_on   timestamptz,
  check (length(body)>2),
  check (updated_on is null or updated_on > created_on)
);
create index task_comment_user_id_index on task_comment(user_id);
create index task_comment_task_id_index on task_comment(task_id);