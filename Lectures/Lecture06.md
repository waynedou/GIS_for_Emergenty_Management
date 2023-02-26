---
title: 应急管理与空间分析
subtitle: 属性查询
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
        # pdf-engine: xelatex
        path: Slides/Lecture06.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]
    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture06_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"
---

# 空间实体的属性

- 空间表达模型
  - 栅格数据是"图数一体"的
  - 矢量模型只描述了图形
- "空间对象"是指对在计算机中对空间实体的形状和位置进行表达的数字对象. 
  - 空间对象是空间实体的**空间属性**
- 空间对象的性质称为**非空间属性**, 或简称**属性 (attribute)**.
  - GIS中属性通常以 **属性表** 形式进行存储和管理.
- 矢量数据的三种组织方式
  - 空间数据与非空间数据分别存储
    - Arc/Info
    - shapefile
  - 基于正则分解的数据库存储
  - 一体化存储

## 属性表

- 表格信息是地理要素的基础，可用于显示、查询和分析数据。
- 表是由行和列组成，且所有行都具有相同的列。
  - 行和列分别称为记录和字段。
- 每个字段可存储一个特定的数据类型，如数字、日期或文本段。

## 数据类型与地图表达
:::{.columns align=center}
:::{.column width="50%" }

定性 vs 定量

- 名义(定类)数据: 质的差异. 相等比较
- 顺序(定序)数据: 存在偏序关系. 大小比较
- 间隔(定距)数据: 可以表示差异的大小, 没有绝对零点. 减法和求均值
- 比率(定比)数据: 最复杂的测量尺度,有绝对零点. 加法, 乘除法

数据类型决定了可执行的查询方法
:::
:::{.column width="40%"}

地图表达

- 样式
  - 符号大小
  - 颜色
  - 图案
- 数据类型
  - 注记
  - 分类
  - 分级
    - 分级策略
  - 连续
    - 拉伸方法
:::
:::


# QGIS 中的属性操作

## 数据准备

- 解压 `QGIS-Sample-Data-master.zip`
- 加载`shapefiles`中的所有文件
  - 查看属性表, 检查是否有乱码
  - 如果有乱码, 改用数据源管理器打开文件
- 创建 GeoPackage 库 `qgis-sample`
  - `Geometry Type`: `No Geometry`
- 所有图层加入`qgis-sample`
- 新建项目, 添加`qgis-sample`
  - 拖拽
  - 保存项目

## 属性查看

- 查看 `identify features`
  - `idenfity results` 面板
- 标注
- 属性表: 属性表和表单视图
  - 浏览/排序
  - 地图和记录跳转
- 选择工具
  - 全选, 全不选, 反选
- 分类显示
  - `popp`按`fcodedesc`分类显示
  - 分类编辑符号样式

## 要素选择

- 鼠标选择
  - 地图选择工具
  - 属性表选择记录
  - 地图-属性表联动
- 按属性查询
  - 表单方式查询: 选择 'WULIK RIVER'
  - 表达式: 选择军用机场; 选择以方位词结尾的地区
  - 查询动作: 选择, 追加, 删除, 过滤
- 导出选择的要素
- 图层过滤

:::notes
选择军用机场可以采用以下两种方式:

- `"use" in ('Joint Military/Civilian' ,'Military')`
- `"use" = 'Joint Military/Civilian' OR "use" = 'Military')`

双引号表示字段名, 单引号表示字符串.

QGIS 提供了非常丰富的表达式函数, 详细列表参见 https://docs.qgis.org/3.22/en/docs/user_manual/expressions/functions_list.html#
:::

## 属性编辑

- 编辑
- 增加/删除字段
- 保存, 退出编辑
