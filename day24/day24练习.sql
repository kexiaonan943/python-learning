-- students表
create table students(
id int unsigned primary key auto_increment not null,
name varchar(20) default '', -- varchar可变长字符串
age tinyint unsigned default 0, -- 迷你整型 default 防止出现0岁
height decimal(5,2),-- 小数点后两位
gender enum('男','女','中性','保密') default '保密',
cls_id int unsigned default 0,
is_delete bit default 0
);


-- classes 表
create table classes(
id int unsigned auto_increment primary key not null,
name varchar(30) not null
);

INSERT INTO students(name,age,height,gender,cls_id,is_delete)
VALUES
( '小明', 18, 180.00, 2, 1, 0 ),
( '小月月', 18, 180.00, 2, 2, 1 ),
( '彭于晏', 29, 185.00, 1, 1, 0 ),
( '刘德华', 59, 175.00, 1, 2, 1 ),
( '黄蓉', 38, 160.00, 2, 1, 0 ),
( '凤姐', 28, 150.00, 4, 2, 1 ),
( '王祖贤', 18, 172.00, 2, 1, 1 ),
( '周杰伦', 36, NULL, 1, 1, 0 ), 
( '程坤', 27, 181.00, 1, 2, 0 ),
( '刘亦菲', 25, 166.00, 2, 2, 0 ),
( '金星', 33, 162.00, 3, 3, 1 ),
( '静香', 12, 180.00, 2, 4, 0 ),
( '郭靖', 12, 170.00, 1, 4, 0 ),
( '周杰', 34, 176.00, 2, 5, 0 );


-- 向 classes 表中插入数据
-- insert into classes values (0, "python_01 期"), (0, "python_02 期");
insert into classes values(0, "python)01 期"),(1, "python_02 期");


-- 查询所有字段
-- select * from 表名;
select * from classes;
select * from students;


-- • 查询指定字段
-- select 列 1,列 2,... from 表名;
select name from students;
select name, age from students;


-- • 使用 as 给字段起别名
-- select id as 序号, name as 名字, gender as 性别 from students;
select id as 序号,name as 名字,gender as 性别 from students;
select id 序号,name 名字, gender 性别 from students;   -- 可以不用加as


-- • 可以通过 as 给表起别名
select s.id,s.name,s.gender from students as s;
select c.id,c.name from classes as c;
select s.id,s.name,s.gender from students as s;


-- 如果是单表查询 可以省略表明
select id ,name ,gender from students;
select name from classes;


-- 表名.字段名
select classes.id,classes.name from classes;
select students.id,students.name,students.gender from students;


-- 在 select 后面列前使用 distinct 可以消除重复的行
-- select distinct 列 1,... from 表名;
select distinct gender from students;
select distinct age from students;
select distinct s.gender from students as s;


-- 使用 where 子句对表中的数据筛选，结果为 true 的行会出现在结果集中
-- select * from 表名 where 条件;
select * from students where id=1;
select s.age from students s where id =2;
select c.name from classes c where id =1; 
-- 例 1：查询编号大于 3 的学生
select * from students where id > 3;
-- 例 2：查询编号不大于 4 的学生
select * from students where id <= 4;
-- 例 3：查询姓名不是“黄蓉”的学生
select * from students where name!="黄蓉";
-- 例 4：查询没被删除的学生
select * from students where is_delete=0;


-- 逻辑运算符
-- 例 5：查询编号大于 3 的女同学
select * from students where id > 3 and gender=2;
-- 例 6：查询编号小于 4 或没被删除的学生
select * from students where id < 4 or is_delete=0;


-- 模糊查询
-- • like
-- • %表示零个或任意多个任意字符
-- • _表示一个 任意字符
-- 例 7：查询姓黄的学生
select * from students where name like '黄%';
-- 例 8：查询姓黄并且“名”是一个字的学生
select * from students where name like "黄_";
-- 例 9：查询姓黄或叫靖的学生
select s.name from students s where name like "黄%" or name like "%靖";


-- 空判断
-- • 注意：null 与''是不同的
-- • 判空 is null
-- 例 13：查询没有填写身高的学生姓名
select s.name from students s where height is null;
-- • 判非空 is not null
-- 例 14：查询填写了身高的学生
select s.name from students s where height is not null;
-- 例 15：查询填写了身高的男生
select * from students where height is not null and gender=1;


-- 排序
-- 语法：desc降序  asc升序
-- select * from 表名 order by 列 1 asc|desc [,列 2 asc|desc,...]
-- 例 1：查询未删除男生信息，按学号降序
select * from students where gender=1 and is_delete=0 order by id desc;
select * from students order by age asc;
-- 例 2：查询未删除学生信息，按名称升序
select * from students where is_delete=0 order by name asc;
-- 例 3：显示所有的学生信息，先按照年龄从大-->小排序，当年龄相同时 按照身高
-- 从高-->矮排序
select * from students order by age desc,height desc;


-- 聚合函数
-- 总数
-- • count(*)表示计算总行数，括号中写星与列名，结果是相同的
-- 例 1：查询学生总数
select count(*) from students;
-- 最大值
-- • max(列)表示求此列的最大值
-- 例 2：查询女生的编号最大值
select max(id) from students where gender=2;
select max(age) from students where gender=1;
-- 最小值
-- • min(列)表示求此列的最小值
-- 例 3：查询未删除的学生最小编号
select min(id) from students where is_delete=0;
-- 求和
-- • sum(列)表示求此列的和
-- 例 4：查询男生的总年龄
select sum(age) from students where gender=1;
-- 平均年龄
select sum(age)/count(*) from students where gender=1;
select sum(age)/count(*) from students s where s.gender=2;
-- 平均值
-- • avg(列)表示求此列的平均值
-- 例 5：查询未删除女生的编号平均值
select avg(id) from students where is_delete=0 and gender=2;


-- 分组
select gender from students group by gender;
-- group by + group_concat()
-- group_concat(字段名)可以作为一个输出字段来使用，concat 是构造合并的含义
select gender,group_concat(name) from students group by gender;
select gender,GROUP_CONCAT(name) from students group by gender;
select gender,group_concat(id) from students group by gender;
-- group by + 集合函数
-- 分别统计性别为男/女的人年龄平均值
select gender,avg(age) from students group by gender;
-- 分别统计性别为男/女的人的个数
select gender,count(*) from students group by gender;


-- group by + having
-- 1. having 条件表达式：用来分组查询后指定一些条件来输出查询结果
-- 2. having 作用和 where 一样，但 having 只能用于 group by
-- 总数大于2的输出
select gender,count(*) from students group by gender having count(*)>2;


-- group by + with rollup
-- 1. with rollup 的作用是：在最后新增一行，来记录当前列里所有记录的总和，
-- having 操作要放到 rollup 之后
select gender,count(*) from students group by gender with rollup;
select gender,count(*) from students group by gender with rollup having count(*)>2;
select gender,GROUP_CONCAT(age) from students group by gender with rollup;


-- 语法
-- select * from 表名 limit start,count
-- 说明
-- • 从 start 开始，获取 count 条数据，最上面一行是第 0 行
-- 例 1：查询前 3 行男生信息
select * from students where gender=1 limit 0,3;


-- 连接查询 分为内 左 右
-- select * from 表 1 inner 或 left 或 right join 表 2 on 表 1.列 = 表 2.列
-- 例 1：使用内连接查询班级表与学生表
select * from students inner join classes on students.cls_id = classes.id;
select * from students inner join classes on students.cls_id = classes.id;
-- 例 2：使用左连接查询班级表与学生表
-- • 此处使用了 as 为表起别名，目的是编写简单
select * from students s left join classes c on s.cls_id=c.id;
select * from students as s left join classes as c on s.cls_id = c.id;
-- 例 3：使用右连接查询班级表与学生表
select * from students as s right join classes as c on s.cls_id = c.id;
-- 例 4：查询学生姓名及班级名称
-- 不能出翔相同的列名在一个表中
select s.name,c.name cname from students s inner join classes c on s.cls_id = c.id;
select s.name,c.name as cname from students as s inner join classes as c on s.cls_id = c.id;


-- 自相关
create table areas(
aid int primary key,
atitle varchar(20),-- 名称
pid int  
);

select * from areas;
-- •查询一共有多少个省
select * from areas where pid is null;
select aid from areas where pid is null;


-- •例1：查询省的名称为“广东省”的所有城市
select * from areas c inner join areas p on c.pid=p.aid where p.atitle='广东省';
select * from areas c inner join areas p on c.pid = p.aid where p.atitle="揭阳市";

-- •例2：查询市的名称为“广州市”的所有区县
select dis.* from areas as dis
inner join areas as city on city.aid=dis.pid
where city.atitle='广州市';
select dis.* from areas dis inner join areas city on city.aid=dis.pid where city.atitle="揭阳市";



-- 子查询

-- 标量子查询
-- 1.查询班级学生平均年龄
-- 2.查询大于平均年龄的学生
-- 查询班级哪些学生的身高大于平均身高
select avg(height) from students;
select * from students where height > (select avg(height) from students);
select * from students where age >(select avg(age) from students);

-- 列级子查询
-- •查询还有学生在班的所有班级名字
-- a.找出学生表中所有的班级 id
-- b.找出班级表中对应的名字
select name from classes where id in (select DISTINCT cls_id from students);
select name from classes where id in (select distinct cls_id from students);
-- 行子查询
select * from students where (height,age) = (select max(height),max(age) from students);
select * from students where (height,age)=(select max(height),max(age) from students);

desc mysql.`user`;



-- 京东数据分析
create table goods(
id int unsigned primary key auto_increment not null,
name varchar(150) not null,
cate_name varchar(40) not null,
brand_name varchar(40) not null,
price decimal(10,3) not null default 0,
is_show bit not null default 1,
is_saleoff bit not null default 0
);
-- auto_increment主键自动增长
create table goods(
id int unsigned primary key auto_increment not null, 
name varchar(150) not null,
cate_name varchar(40) not null,-- 商品种类
brand_name varchar(40) not null,
price decimal(10,3) not null default 0,
is_show bit not null default 1,
is_saleoff bit not null default 0
);

insert into goods values(0,'r510vc 15.6英寸笔记本','笔记本','华硕','3399',default,default); 
insert into goods values(0,'y400n 14.0英寸笔记本电脑','笔记本','联想','4999',default,default);
insert into goods values(0,'g150th 15.6英寸游戏本','游戏本','雷神','8499',default,default); 
insert into goods values(0,'x550cc 15.6英寸笔记本','笔记本','华硕','2799',default,default); 
insert into goods values(0,'x240 超极本','超级本','联想','4880',default,default); 
insert into goods values(0,'u330p 13.3英寸超极本','超级本','联想','4299',default,default); 
insert into goods values(0,'svp13226scb 触控超极本','超级本','索尼','7999',default,default); 
insert into goods values(0,'ipad mini 7.9英寸平板电脑','平板电脑','苹果','1998',default,default);
insert into goods values(0,'ipad air 9.7英寸平板电脑','平板电脑','苹果','3388',default,default); 
insert into goods values(0,'ipad mini 配备 retina 显示屏','平板电脑','苹果','2788',default,default); 
insert into goods values(0,'ideacentre c340 20英寸一体电脑 ','台式机','联想','3499',default,default); 
insert into goods values(0,'vostro 3800-r1206 台式电脑','台式机','戴尔','2899',default,default); 
insert into goods values(0,'imac me086ch/a 21.5英寸一体电脑','台式机','苹果','9188',default,default); 
insert into goods values(0,'at7-7414lp 台式电脑 linux ）','台式机','宏碁','3699',default,default); 
insert into goods values(0,'z220sff f4f06pa工作站','服务器/工作站','惠普','4288',default,default); 
insert into goods values(0,'poweredge ii服务器','服务器/工作站','戴尔','5388',default,default); 
insert into goods values(0,'mac pro专业级台式电脑','服务器/工作站','苹果','28888',default,default); 
insert into goods values(0,'hmz-t3w 头戴显示设备','笔记本配件','索尼','6999',default,default); 
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default); 
insert into goods values(0,'x3250 m4机架式服务器','服务器/工作站','ibm','6888',default,default); 
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default);

select * from goods;
-- •查询类型cate_name为 '超极本' 的商品名称、价格
select name,price from goods where cate_name = '超级本';
-- •显示商品的种类
select cate_name from goods group by cate_name;
-- •求所有电脑产品的平均价格,并且保留两位小数 round 将结果舍入到指定小数位数
select round(avg(price),2) avg_price from goods;
-- •显示每种商品的平均价格
select g.cate_name, round(avg(g.price),2) avg_price from goods g group by g.cate_name; 
-- •查询每种类型的商品中 最贵、最便宜、平均价、数量
select cate_name, max(price),min(price),avg(price),count(*) from goods group by cate_name;
-- •查询所有价格大于平均价格的商品，并且按价格降序排序
select id, name ,price from goods where price >(select round(avg(price),2) avg_price from goods) order by price desc;

-- •查询每种类型中最贵的电脑信息
select * from goods
inner join 
    (
        select
        cate_name, 
        max(price) as max_price, 
        min(price) as min_price, 
        avg(price) as avg_price, 
        count(*) from goods group by cate_name
    ) as goods_new_info 
on goods.cate_name=goods_new_info.cate_name and goods.price=goods_new_info.max_price;

select * from goods
inner join 
(
select cate_name, max(price) max_price,min(price) min_price ,avg(price) avg_price,count(*)
from goods group by cate_name
) goods_new_info on goods.cate_name=goods_new_info.cate_name and goods.price=goods_new_info.max_price;


create table if not exists goods_cates(
id int unsigned primary key auto_increment,
name varchar(40) not null
);

-- •查询goods表中商品的种类
select cate_name from goods group by cate_name;
select cate_name from goods group by cate_name;
-- •将分组结果写入到goods_cates数据表
insert into goods_cates (name) select cate_name from goods group by cate_name;
insert into goods_cates (name) select cate_name from goods group by cate_name;

-- •通过goods_cates数据表来更新goods表（为什么要这么做？）
update goods g inner join goods_cates c on g.cate_name=c.name set g.cate_name=c.id;
update goods g inner join goods_cate c on g.cate_name=c.name set g.cate_name=c.id;

create table goods_brands (
    id int unsigned primary key auto_increment,
    name varchar(40) not null) select brand_name as name from goods group by brand_name;
		
-- •通过goods_brands数据表来更新goods数据表（为什么要这么做？）
update goods inner join goods_brands on goods.brand_name=goods_brands.name set goods.brand_name=goods_brands.id;

-- •通过alter table语句修改表结构
alter table goods  
change cate_name cate_id int unsigned not null,
change brand_name brand_id int unsigned not null;


-- •查询所有商品的详细信息 (通过内连接)
select g.id,g.name,c.name,b.name,g.price from goods as g
inner join goods_cates as c on g.cate_id=c.id
inner join goods_brands as b on g.brand_id=b.id;


select g.id,g.name,c.name,g.brand_id,g.price from goods as g
inner join goods_cates as c on g.cate_id=c.id;
-- •查询所有商品的详细信息 (通过内连接)
select gc.*,b.name from (select g.id,g.name,c.name as cname,g.brand_id,g.price from goods as g
inner join goods_cates as c on g.cate_id=c.id) gc INNER JOIN goods_brands b on gc.brand_id=b.id;


insert into goods_cates(name) values ('路由器'),('交换机'),('打印机');
insert into goods (name,cate_id,brand_id,price)
values('LaserJet Pro P1606dn 黑白激光打印机', 10, 4,'1849');

alter table goods add foreign key (cate_id) references goods_cates(id);
show create table goods;

alter table goods drop foreign key goods_ibfk_1;


-- 多对多

create table TEACHER(
ID int primary key,
NAME varchar(100)
);
insert into TEACHER values(1,'math teacher');
insert into TEACHER values(2,'chinese teacher');
insert into TEACHER values(3,'english teacher');

create table STUDENT3(
ID int primary key,
NAME varchar(100)
);

insert into STUDENT3 values(1,"lily");
insert into STUDENT3 values(2,"lucy");
insert into STUDENT3 values(3,"lilei");
insert into STUDENT3 values(4,"xiongda");


create table TEACHER_STUDENT(
T_ID int,
S_ID int,
primary key(T_ID,S_ID),
constraint T_ID_FK foreign key(T_ID) references TEACHER(ID),
constraint S_ID_FK foreign key(S_ID) references STUDENT3(ID));

insert into TEACHER_STUDENT VALUES(1,2);
insert into TEACHER_STUDENT VALUES(1,1);
insert into TEACHER_STUDENT VALUES(2,1);

select t.`NAME`,s.`NAME` from TEACHER as t INNER JOIN TEACHER_STUDENT as ts on ts.T_ID=t.ID INNER JOIN STUDENT3 as s on s.ID=ts.S_ID;

select t.`NAME`,s.`NAME` from TEACHER as t LEFT JOIN TEACHER_STUDENT as ts on ts.T_ID=t.ID LEFT JOIN STUDENT3 as s on s.ID=ts.S_ID;
