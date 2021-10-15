.load dist/text
select '01', reverse(null) is NULL;
[{"'01'":"01","reverse(null) is NULL":1}]
select '02', reverse('hello') = 'olleh';
[{"'02'":"02","reverse('hello') = 'olleh'":1}]
select '03', reverse('привет') = 'тевирп';
[{"'03'":"03","reverse('привет') = 'тевирп'":1}]
select '04', reverse('𐌀𐌁𐌂') = '𐌂𐌁𐌀';
[{"'04'":"04","reverse('𐌀𐌁𐌂') = '𐌂𐌁𐌀'":1}]
select '05', reverse('hello 42@ world') = 'dlrow @24 olleh';
[{"'05'":"05","reverse('hello 42@ world') = 'dlrow @24 olleh'":1}]
