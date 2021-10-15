.load dist/crypto

select '01', md5(null) is NULL;
[{"'01'":"01","md5(null) is NULL":1}]
select '02', hex(md5('')) = upper('d41d8cd98f00b204e9800998ecf8427e');
[{"'02'":"02","hex(md5('')) = upper('d41d8cd98f00b204e9800998ecf8427e')":1}]
select '03', hex(md5('abc')) = upper('900150983cd24fb0d6963f7d28e17f72');
[{"'03'":"03","hex(md5('abc')) = upper('900150983cd24fb0d6963f7d28e17f72')":1}]

select '11', sha1(null) is NULL;
[{"'11'":"11","sha1(null) is NULL":1}]
select '12', hex(sha1('')) = upper('da39a3ee5e6b4b0d3255bfef95601890afd80709');
[{"'12'":"12","hex(sha1('')) = upper('da39a3ee5e6b4b0d3255bfef95601890afd80709')":1}]
select '13', hex(sha1('abc')) = upper('a9993e364706816aba3e25717850c26c9cd0d89d');
[{"'13'":"13","hex(sha1('abc')) = upper('a9993e364706816aba3e25717850c26c9cd0d89d')":1}]

select '21', sha256(null) is NULL;
[{"'21'":"21","sha256(null) is NULL":1}]
select '22', hex(sha256('')) = upper('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');
[{"'22'":"22","hex(sha256('')) = upper('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855')":1}]
select '23', hex(sha256('abc')) = upper('ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad');
[{"'23'":"23","hex(sha256('abc')) = upper('ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad')":1}]

select '31', sha384(null) is NULL;
[{"'31'":"31","sha384(null) is NULL":1}]
select '32', hex(sha384('')) = upper('38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b');
[{"'32'":"32","hex(sha384('')) = upper('38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b')":1}]
select '33', hex(sha384('abc')) = upper('cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7');
[{"'33'":"33","hex(sha384('abc')) = upper('cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7')":1}]

select '41', sha512(null) is NULL;
[{"'41'":"41","sha512(null) is NULL":1}]
select '42', hex(sha512('')) = upper('cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e');
[{"'42'":"42","hex(sha512('')) = upper('cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e')":1}]
select '43', hex(sha512('abc')) = upper('ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f');
[{"'43'":"43","hex(sha512('abc')) = upper('ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f')":1}]
