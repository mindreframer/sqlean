.read test/_settings.sql
.load dist/text
select '01', split_part(NULL, ',', 2) is NULL;
select '02', split_part('', ',', 2) = '';
select '03', split_part('one,two,three', ',', 2) = 'two';
select '04', split_part('one|two|three', '|', 2) = 'two';
select '05', split_part('один,два,три', ',', 2) = 'два';
select '06', split_part('one,two,three', ',', 10) = '';
select '07', split_part('one,two,three', ';', 2) = '';
select '08', split_part('one,two,three', '', 1) = 'one,two,three';
select '10', split_part('one,two,three', NULL, 2) is NULL;
select '11', split_part('one,,,four', ',', 2) = '';
select '12', split_part('one,,,four', ',', 4) = 'four';
select '13', split_part('one/two|three', '/|', 2) = 'two';