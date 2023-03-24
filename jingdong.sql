-- 创建 "京东" 数据库
create database jing_dong charset=utf8;
create database jing_dong charset=utf8;
-- 使用 "京东" 数据库
use jing_dong;
use jing_dong;
-- 创建一个商品 goods 数据表
create table goods(
id int unsigned primary key auto_increment not null,
name varchar(150) not null,
cate_name varchar(40) not null,
brand_name varchar(40) not null,
price decimal(10,3) not null default 0,
is_show bit not null default 1,
is_saleoff bit not null default 0
);


create table goods(
id int unsigned primary key auto_increment not null,
name varchar(150) not null,
cate_name varchar(40) not null,-- 商品种类
brand_name varchar(40) not null, -- 品牌
price decimal(10,3) not null default 0,
is_show bit not null default 1,
is_salaoff bit not null default 0
);

select * from goods;

-- 导入数据
insert into goods values(0,'r510vc 15.6 英寸笔记本','笔记本','华硕','3399',default,default);
insert into goods values(0,'y400n 14.0 英寸笔记本电脑','笔记本','联想','4999',default,default);
insert into goods values(0,'g150th 15.6 英寸游戏本','游戏本','雷神','8499',default,default);
insert into goods values(0,'x550cc 15.6 英寸笔记本','笔记本','华硕','2799',default,default);
insert into goods values(0,'x240 超极本','超级本','联想','4880',default,default);
insert into goods values(0,'u330p 13.3 英寸超极本','超级本','联想','4299',default,default);
insert into goods values(0,'svp13226scb 触控超极本','超级本','索尼','7999',default,default);
insert into goods values(0,'ipad mini 7.9 英寸平板电脑','平板电脑','苹果','1998',default,default);
insert into goods values(0,'ipad air 9.7 英寸平板电脑','平板电脑','苹果','3388',default,default);
insert into goods values(0,'ipad mini 配备 retina 显示屏','平板电脑','苹果','2788',default,default);
insert into goods values(0,'ideacentre c340 20 英寸一体电脑 ','台式机',' 联想','3499',default,default);
insert into goods values(0,'vostro 3800-r1206 台式电脑','台式机','戴尔','2899',default,default);
insert into goods values(0,'imac me086ch/a 21.5 英寸一体电脑','台式机',' 苹果','9188',default,default);
insert into goods values(0,'at7-7414lp 台式电脑 linux ）','台式机','宏碁','3699',default,default);
insert into goods values(0,'z220sff f4f06pa 工作站','服务器/工作站','惠普','4288',default,default);
insert into goods values(0,'poweredge ii 服务器','服务器/工作站','戴尔','5388',default,default);
insert into goods values(0,'mac pro 专业级台式电脑','服务器/工作站','苹果','28888',default,default);
insert into goods values(0,'hmz-t3w 头戴显示设备','笔记本配件','索尼','6999',default,default);
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default);
insert into goods values(0,'x3250 m4 机架式服务器','服务器/工作站','ibm','6888',default,default);
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default);

-- 1. SQL 语句的强化
-- • 查询类型 cate_name 为 '超极本' 的商品名称、价格
-- select name,price from goods where cate_name = '超级本';
select name,price from goods where cate_name = '超级本';
-- • 显示商品的种类
-- select cate_name from goods group by cate_name;
select cate_name from goods group by cate_name;
-- • 求所有电脑产品的平均价格,并且保留两位小数
-- select round(avg(price),2) as avg_price from goods;
select round(avg(price),2) avg_price from goods;
-- • 显示每种商品的平均价格
select cate_name,avg(price) from goods group by cate_name;
select cate_name,avg(price) from goods group by cate_name;   -- group by cate_name就是按cate_name分类 行标签为cate_name,avg(price) 
-- • 查询每种类型的商品中 最贵、最便宜、平均价、数量
-- select cate_name,max(price),min(price),avg(price),count(*) from goods group by cate_name;-- count(*) 数量
select cate_name,max(price),min(price),avg(price),count(*) from goods group by cate_name;


-- • 查询所有价格大于平均价格的商品，并且按价格降序排序
-- select id,name,price from goods where price > (select round(avg(price),2) as avg_price from goods) order by price desc; 
select id,name,price from goods where price > (select round(avg(price),2) avg_price from goods) order by price desc;
-- • 查询每种类型中最贵的电脑信息
select * from goods
inner join
(
select cate_name,max(price) as max_price,min(price) as min_price,avg(price) as avg_price,count(*) from goods group by cate_name
) as goods_new_info on goods.cate_name=goods_new_info.cate_name and goods.price=goods_new_info.max_price;

select * from goods inner join (select cate_name,max(price) max_price from goods group by cate_name) goods_new_info 
on goods.cate_name=goods_new_info.cate_name order by max_price desc;



-- 创建商品分类表
create table if not exists goods_cates(
id int unsigned primary key auto_increment,
name varchar(40) not null
);


create table if not exists goods_cates(	
id int unsigned primary key auto_increment,
name varchar(40) not null
);


-- • 查询 goods 表中商品的种类
-- select cate_name from goods group by cate_name;
select cate_name from goods group by cate_name;
-- • 将分组结果写入到 goods_cates 数据表
-- insert into goods_cates (name) select cate_name from goods group by cate_name;
insert into goods_cates (name) select cate_name from goods group by cate_name;
select * from goods_cates;



-- 3. 同步表数据
-- • 通过 goods_cates 数据表来更新 goods 表（为什么要这么做？）
update goods as g inner join goods_cates as c on g.cate_name=c.name set g.cate_name=c.id;

update goods g inner join goods_cates c on g.cate_name =c.name set g.cate_name = c.id;

-- 4. 创建 "商品品牌表" 表
-- • 通过 create...select 来创建数据表并且同时写入记录,一步到位
select brand_name from goods group by brand_name;

-- 在创建数据表的时候一起插入数据
-- 注意: 需要对 brand_name 用 as 起别名，否则 name 字段就没有值
-- create table goods_brands (
-- id int unsigned primary key auto_increment,
-- name varchar(40) not null) select brand_name as name from goods group by brand_name;
create table goods_brands (
id int unsigned primary key auto_increment,name varchar(40) not null) select brand_name as name from goods group by brand_name;
select * from goods_brands;
-- 5. 同步数据
-- • 通过 goods_brands 数据表来更新 goods 数据表（为什么要这么做？）
update goods as g inner join goods_brands as b on g.brand_name=b.name set g.brand_name=b.id;
update goods as g inner join goods_brands as b on g.brand_name=b.name set g.brand_name=b.id;
select * from goods;


-- 6. 修改表结构
-- • 查看 goods 的数据表结构,会发现 cate_name 和 brand_name 对应的类型为
-- varchar 但是存储的都是数字
desc goods;
-- • 通过 alter table 语句修改表结构
-- alter table goods
-- change cate_name cate_id int unsigned not null,
-- change brand_name brand_id int unsigned not null;
alter table goods
change cate_name cate_id int unsigned not null,
change brand_name brand_id int unsigned not null;







