---
title: 应急管理与空间分析
subtitle: PostgreSQL 与 PostGIS
author: 窦闻
Tags: #teaching

CJKmainfont: Songti SC
# mainfont: WenQuanYi Micro Hei Mono
classoption:
    - aspectratio=1610
pdf-engine: xelatex
section-titles: false

output:
    beamer_presentation:
        theme: "AnnArbor"
        colortheme: "dolphin"
        fonttheme: "structurebold"
        slide_level: 3
        # section-titles: false
        pdf-engine: xelatex
        path: Slides/Lecture13.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture13_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
- 空间查询参见 /Users/wayne/Documents/Notes/Teaching/SDB_SA/空间查询示例.md
---
# PostGreSQL

- POSTGRES的实现始于 1986 年由Michael Stonebraker教授领导的POSTGRES项目, 该项目由防务高级研究项目局（DARPA）、陆军研究办公室（ARO）、国家科学基金等共同赞助。 
- 1994 年，Andrew Yu 和 Jolly Chen 向POSTGRES中增加了 SQL 语言的解释器。并随后用新名字Postgres95将源代码发布到互联网上供大家使用, 成为最初POSTGRES伯克利代码的开源继承者
- 1996年更名为 PostGreSQL. 出于传统或者更容易发音的原因, 常继续用``Postgres”来指代 PostgreSQL
  - 或直接简称为 PG
- PG官方教程中文版
  - http://www.postgres.cn/docs/12/tutorial.html

## 创建用户与数据库
使用 `psql`登录数据库

```sql
--创建用户并授予创建数据库的权限
create user test1 PASSWORD '123456'; 
alter user test1 CREATEDB;
--删除用户
drop user test1;
--创建超级用户
create role wen PASSWORD '123456' SUPERUSER LOGIN; 
create user wen PASSWORD '123456' SUPERUSER; 
--更换身份
\c - wen
--创建数据库
CREATE DATABASE wen;
--切换数据库
\c wen
```

:::notes
- 用户属性: https://www.postgresql.org/docs/current/role-attributes.html
:::

## 创建表
创建表的基本语法:

```sql
CREATE TABLE [schema.]table_name(
   column1 datatype,
   column2 datatype,
   column3 datatype,
   .....
   columnN datatype,
   PRIMARY KEY( 一个或多个列 )
);
```

#### 创建表示例
```sql
CREATE TABLE menu (
id serial,
item varchar(10) NOT NULL,
price numeric
);
```

## 插入记录
`INSERT INTO` 语句用于向表中插入新记录。
语法格式如下：

```sql
INSERT INTO TABLE_NAME (column1, column2, column3,...columnN)
VALUES (value1, value2, value3,...valueN);
```

#### 插入记录示例
```sql
INSERT INTO menu VALUES (1, 'GBJD',10);
INSERT INTO menu (item, price)VALUES ('GBRD',15), ('GBNRD', 20);
INSERT INTO menu(item) VALUES ('YXRS');
SELECT * FROM menu;
```

## 更新记录
如果我们要更新在 PostgreSQL 数据库中的数据，我们可以用 UPDATE 来操作。

语法
以下是 UPDATE 语句修改数据的通用 SQL 语法：

```sql
UPDATE table_name
SET column1 = value1, column2 = value2...., columnN = valueN
WHERE [condition];
```

#### 更改菜单价格
```sql
update menu set price=12 where item ILIKE '%yxrs%';
update menu set price=16 where id=2;
update menu set price=price*1.2;
```

## 删除记录/删除字段/删除表

- `DELETE` 语句来删除 PostgreSQL 表中的数据

  ```sql
  DELETE FROM table_name WHERE [condition];
  ```

- 删除字段使用 `ALTER TABLE` 语句

  ```sql
  ALTER TABLE table_name DROP COLUMN col_name;
  ```

- `DROP TABLE` 语句用于删除表格，包含表格数据、规则、触发器等

  ```sql
  DROP TABLE table_name;
  ```


#### 删除示例
```sql
delete from menu where id=3;
alter table menu drop column id;
drop table menu;
```

## 编码相关

`\encoding` 动态修改客户端编码

```sql
\encoding GBK
SHOW client_encoding;
SHOW server_encoding;
RESET client_encoding;
```

## 表连接

```sql
create table tbl_a (a int);
insert into tbl_a values (1),(2),(3);
create table tbl_b (b int);
insert into tbl_b values (2),(3),(4),(5);
select * from tbl_a, tbl_b;
select * from tbl_a, tbl_b where a=b;
select * from tbl_a, tbl_b where a>b;
select * from tbl_a inner join tbl_b on(a=b);
select * from tbl_a left join tbl_b on(a=b);
select * from tbl_a right join tbl_b on(a=b);
select *,a+b as sum from tbl_a full join tbl_b on(a=b);
```

# 空间数据库

空间数据库是能处理空间数据的数据库. 目前的主流方法是在对象-关系型数据库中增加对空间数据处理的能力.

- 空间数据处理与更新
- 海量数据存储与管理
- 空间分析与决策
- 空间信息交换与共享

## PostGIS

- PostGIS 对 PostGreSQL 进行空间数据管理能力的扩展

```sql
CREATE EXTENSION postgis;
SELECT postgis_version();
SELECT st_pointfromtext('POINT(1 1)');
```

帮助文件参见 https://www.postgis.net/docs/manual-2.5/

# 基于 PostGIS 的空间分析应用示例
- QGIS中创建PostGIS连接
  - `Host`: 本机填 localhost
  - `Database`: 要连接的数据库名称
  - `Authentication`: Basic 填写数据库用户名和密码
  - 选中 `Also list tables with no geometry`
- 导入数据
  - 浏览面板拖拽操作
  - 利用 `DB Manager`, 选中数据库, 点击`Import Layer/File...`按钮, 勾选创建空间索引, 将字段名改为小写, 创建空间索引.

## 数据说明

文件名 | 表名 | 数据内容
|------|-------|----------------------|
district.shp | stb_district | 城区行政范围
stb_bus_stop.shp | stb_bus_stop | 公交站点数据
stb_resident_bld.shp | stb_resident_bld | 住宅建筑与人口数据
stb_bus_line.shp | stb_bus_line | 公交线路数据
stb_flood_level.shp | stb_flood_level | 洪水淹没情景
stb_store.shp | stb_store | 便利店数据

## 估算各淹没深度级别的面积
- 查看 stb_flood_level
- 对不同淹没深度进行聚合统计
  - `st_area`用于计算面积


```sql
SELECT floodlevel, sum(st_area(geom))/1e6 AS area
FROM stb_flood_level
WHERE floodlevel >= 100
GROUP BY floodlevel
ORDER BY floodlevel DESC;
```

## 统计住宅建筑和人口暴露情况

- 根据淹没区和住宅建筑的位置关系, 确定被淹没的住宅, 并聚合统计人口数量
  - "std_resident_bld" 中 "pop" 字段记录了住宅建筑物内的人口数量
- `count` 和 `sum` 为聚合函数
- `st_within`用于判别空间包含关系, 返回bool值


```sql
SELECT f.floodlevel, 
       count(r.id) AS num_buildings, 
       sum(r.pop) AS num_pop
FROM stb_flood_level f, stb_resident_bld r
WHERE st_within(r.geom, f.geom)
GROUP BY floodlevel
ORDER BY floodlevel;
```

:::notes
为便于理解, 示例可分步执行查看效果: 首先查看表连接的结果, 然后加上过滤条件, 最后修改查询字段进行分组统计. 
:::

## 公交线的洪水暴露

公交数据存储在 "stb_bus_line" 和 "stb_bus_stop" 表中.

- 统计每条线路的长度和经过的公交车站数量
  - `st_length` 计算线路长度
- 统计站点淹没情况
  - `st_within` 判断淹没等级并聚合统计
- 统计每个淹没深度级别的公交路线里程
  - `st_intersection` 获取每条线路在每个淹没等级区域的部分
  - `st_length` 计算各部分的长度
  - 按淹没等级聚合统计各区域内公交线路的总长度

### 统计每条线路的长度和经过的公交车站数量

```sql
SELECT l.busline_id, count(s.id) as num_stops, 
     st_length(l.geom)/1000 as length
FROM "stb_bus_line" l , "stb_bus_stop" s
WHERE l.busline_id = s.busline_id
GROUP BY l.busline_id, l.geom
ORDER BY l.busline_id
```

### 统计站点淹没情况

```sql
SELECT s.busline_id,
	   f.floodlevel, 
       count(s.id) AS num_stops_effected
FROM stb_flood_level f, stb_bus_stop s
WHERE st_within(s.geom, f.geom)
GROUP BY floodlevel, s.busline_id
ORDER BY floodlevel, s.busline_id;
```

### 统计每个淹没深度级别的公交路线里程

```sql
SELECT l.busline_id, f.floodlevel, 
  sum(st_length(st_intersection(l.geom, f.geom)))/1000 as length
FROM "stb_bus_line" l , "stb_flood_level" f
WHERE st_intersects(l.geom, f.geom)
GROUP BY l.busline_id , f.floodlevel
ORDER BY l.busline_id, f.floodlevel
```

## 便利店洪水暴露

- 确定服务范围
  - QGIS中创建Voronoi图并用"stb_district"图层进行裁剪(clip), 保存为"stb_store_voronoi"并导入数据库
- 查询受影响的服务区范围
  - `st_within` 选择被淹没的便利店, 通过 id 关联获得其对应的服务范围
- 统计各街道受淹便利店服务范围内的人口数
  - 利用上一步的查询结果

### 查询受影响的服务区范围

```sql
SELECT sv.id, sv.name, sv.area,
	   f.floodlevel,
	   sv.geom
-- INTO stb_service_in_flood 
FROM stb_flood_level f, stb_store s, stb_store_voronoi sv
WHERE st_within(s.geom, f.geom) and s.id=sv.id;
```

- 取消注释, 可将结果保存在 "stb_service_in_flood" 表中
- 或使用`CREATE VIEW` 语句将上述查询保存为视图

### 统计各街道受淹便利店服务范围内的人口数

```sql
SELECT sif.area, sum(r.pop)
FROM stb_service_in_flood sif, stb_resident_bld r
WHERE st_within(r.geom, sif.geom)
GROUP BY sif.area
```