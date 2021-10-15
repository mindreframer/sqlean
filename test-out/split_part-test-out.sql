.load dist/text
select '01', split_part(NULL, ',', 2) is NULL;
[{"'01'":"01","split_part(NULL, ',', 2) is NULL":1}]
select '02', split_part('', ',', 2) = '';
[{"'02'":"02","split_part('', ',', 2) = ''":1}]
select '03', split_part('one,two,three', ',', 2) = 'two';
[{"'03'":"03","split_part('one,two,three', ',', 2) = 'two'":1}]
select '04', split_part('one|two|three', '|', 2) = 'two';
[{"'04'":"04","split_part('one|two|three', '|', 2) = 'two'":1}]
select '05', split_part('один,два,три', ',', 2) = 'два';
[{"'05'":"05","split_part('один,два,три', ',', 2) = 'два'":1}]
select '06', split_part('one,two,three', ',', 10) = '';
[{"'06'":"06","split_part('one,two,three', ',', 10) = ''":1}]
select '07', split_part('one,two,three', ';', 2) = '';
[{"'07'":"07","split_part('one,two,three', ';', 2) = ''":1}]
select '08', split_part('one,two,three', '', 1) = 'one,two,three';
[{"'08'":"08","split_part('one,two,three', '', 1) = 'one,two,three'":1}]
select '10', split_part('one,two,three', NULL, 2) is NULL;
[{"'10'":"10","split_part('one,two,three', NULL, 2) is NULL":1}]
select '11', split_part('one,,,four', ',', 2) = '';
[{"'11'":"11","split_part('one,,,four', ',', 2) = ''":1}]
select '12', split_part('one,,,four', ',', 4) = 'four';
[{"'12'":"12","split_part('one,,,four', ',', 4) = 'four'":1}]
select '13', split_part('one/two|three', '/|', 2) = 'two';
[{"'13'":"13","split_part('one/two|three', '/|', 2) = 'two'":1}]
