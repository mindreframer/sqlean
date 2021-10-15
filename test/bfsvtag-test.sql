
.read test/_settings.sql
.load dist/bfsvtab

-- https://github.com/abetlen/sqlite3-bfsvtab-ext

/* Insert for the following examples */
create table edges(fromNode integer, toNode integer);
insert into edges(fromNode, toNode) values
  (1, 2),
  (1, 3),
  (2, 4),
  (3, 4);

/* Find the minimum distance from node 1 to node 4 */
select
  id, distance
  from bfsvtab
  where
    tablename  = 'edges'    and
    fromcolumn = 'fromNode' and
    tocolumn   = 'toNode'   and
    root       = 1          and
    id         = 4;

/* Find the shortest path from node 1 to node 4 */
select
  shortest_path
  from bfsvtab
  where
    tablename  = 'edges'    and
    fromcolumn = 'fromNode' and
    tocolumn   = 'toNode'   and
    root       = 1          and
    id         = 4;

/* Find the minimum distance from node 1 to all nodes */
select
  id, distance
  from bfsvtab
  where
    tablename  = 'edges'    and
    fromcolumn = 'fromNode' and
    tocolumn   = 'toNode'   and
    root       = 1;

/* Return the edge set of a spanning tree rooted at node 1 */
select
  parent, id
  from bfsvtab
  where
    tablename  = 'edges'    and
    fromcolumn = 'fromNode' and
    tocolumn   = 'toNode'   and
    root       = 1          and
    parent     is not null;