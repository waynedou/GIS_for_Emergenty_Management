---
title: 应急管理中的空间分析
author: 窦闻
date: 
tags: 
    - #EM #GIS #SA
notes: 
    - 2021.3.1~6.20，周一上午3-4节
    - 共16周
---

# 教学思路

应急管理专业研究生，大部分为纯文科背景，缺乏计算机相关知识和技能。因此，本课程首要任务是为学生提供一定的基础知识和感性经验，逐步建立对信息技术的基本认识，最终建立起应急管理中的空间视角和数据库视角。基本环节包括：

- 从GIS制图技能入手
    * 使用QGIS进行地图制图
    * 了解地图基本概念：投影、空间参照系、制图要素等
    * 结合图层介绍抽象的思路
- 数据和空间数据
    * 模型思想；DIKW
    * 计算的思想：基本数字逻辑电路
    * 空间数据模型：从现实到文件
- 信息查询：数据库视角
    * 地图图形的背后是数据 $\rightarrow$ 地图图形是空间数据，图形和其他字段一样，是地理实体的属性。
    * 数据库设计：三层建模
    * 空间分析是空间字段上可以施行的操作，和统计分析工具相似

# Lec 1 课程介绍

破题。

- 空间分析的含义
    - 与传统数据分析/非空间分析比较
- GIS
    -  概念
- 课堂纪律
- 评价方法
    - 课程论文要求
- 授课方式与风格

# Lec 2 初识GIS

GIS应用 vs 平台

QGIS简介

[官方教程模块1](https://docs.qgis.org/3.16/en/docs/training_manual/basic_map/index.html)

Modern-day GIS is:

- The hardware, software, and methods that allow people to capture, store, manipulate, analyze, manage, and present geographically referenced data.
- A spatial data-management tool made up of “intelligent” computer maps linked to databases that describe map features.



# Lec 3 







# Lec 10

- 认识计算机存储结构
- 磁盘驱动器的物理结构与逻辑结构
- 文件在磁盘上的存储与读写
- 文件与数据库 [../../Teaching/SDB_SA/小餐馆的故事.md]
- PostgreSQL安装
- PG教程
- ~~对照QGIS教程 [Module: Database Concepts with PostgreSQL](https://docs.qgis.org/3.16/en/docs/training_manual/index.html)~~

# Lec

学生对数据库进行了实操，但是不明所以，主要是两个原因：

- 不能区分命令行命令和SQL命令
- 不明白数据库的必要性

所以这一讲首先要解释：

- 文件操作和数据库操作
    - 人 -> 应用程序（excel）-> 文件（xxx.xls）
    - 人 -> 客户端程序（psql）-> 服务器进程（postgres） -> 数据文件（xxx.001）
        - 指令明确（SQL命令，数据库登录时的各种输入等，程序员买包子）
- 计算机硬件 -> kernel -> shell (terminal) -> 操作系统
    - 简单的shell命令演示
    - shell命令（createdb）是操作计算机
    - SQL命令操作数据库

其次梳理SQL基本命令。

![](assets/sql_category.png)

* DDL – Data Definition Language
* DQl – Data Query Language
* DML – Data Manipulation Language
* DCL – Data Control Language

操作实践：

* 基本的增删改
    - `values` 可以添加多条行记录。
    ```sql
    insert into menu values (2, 'GBRD',15), (3, 'GBNRD', 20);
    ```
    - copy导入导出数据 
    ```sql
    -- COPY必须使用绝对路径
    \copy (select * from dish) to 'dish.csv' with csv HEADER;
    \copy dish from 'dish.csv' with csv header;
    ```
    - 去除空格
    ```sql
    update weather set city = trim(city);
    ```

* 选择查询
* 表连接

## 允许其他终端访问server

在 `postgresql.conf` 中添加监听地址。

```
listen_addresses = '*'
```

在 `pg_hba.conf` 中添加允许连接的地址范围。

```
host    all             all             10.0.4.1/24            trust
```


# 概论

## 空间数据

DIKW

## 空间分析

# 初识GIS

QGIS入门

- GIS数据
- 图层
- 查询
- 地图

# 认识数据

- 数据文件
- 数据库
- 空间数据
    - 区分标准（例如WKT）和文件类型（.shp）
