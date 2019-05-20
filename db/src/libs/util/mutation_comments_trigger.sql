-- db/src/libs/util/mutation_comments_trigger.sql
create or replace function mutation_comments_trigger() returns trigger as $$
declare
    c record;
    parent_type text;
begin
    if (tg_op = 'DELETE') then
        if old.parent_type = 'task' then
            delete from data.task_comment where id = old.id;
            if not found then return null; end if;
        elsif old.parent_type = 'project' then
            delete from data.project_comment where id = old.id;
            if not found then return null; end if;
        end if;
        return old;
    elsif (tg_op = 'UPDATE') then
        if (new.parent_type = 'task' or old.parent_type = 'task') then
            update data.task_comment 
            set 
                body = coalesce(new.body, old.body),
                task_id = coalesce(new.task_id, old.task_id)
            where id = old.id
            returning * into c;
            if not found then return null; end if;
            return (c.id, c.body, 'task'::text, c.task_id, null::int, c.task_id, c.created_on, c.updated_on);
        elsif (new.parent_type = 'project' or old.parent_type = 'project') then
            update data.project_comment 
            set 
                body = coalesce(new.body, old.body),
                project_id = coalesce(new.project_id, old.project_id)
            where id = old.id
            returning * into c;
            if not found then return null; end if;
            return (c.id, c.body, 'project'::text, c.project_id, c.project_id, null::int, c.created_on, c.updated_on);
        end if;
    elsif (tg_op = 'INSERT') then
        if new.parent_type = 'task' then
            insert into data.task_comment (body, task_id)
            values(new.body, new.task_id)
            returning * into c;
            return (c.id, c.body, 'task'::text, c.task_id, null::int, c.task_id, c.created_on, c.updated_on);
        elsif new.parent_type = 'project' then
            insert into data.project_comment (body, project_id)
            values(new.body, new.project_id)
            returning * into c;
            return (c.id, c.body, 'project'::text, c.project_id, c.project_id, null::int, c.created_on, c.updated_on);
        end if;

    end if;
    return null;
end;
$$ security definer language plpgsql;