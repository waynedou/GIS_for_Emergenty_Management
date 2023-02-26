---
title: 应急管理与空间分析
subtitle: 数量数据生成、编辑与转换
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
        path: Slides/Lecture08.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture08_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
- 创建矢量数据
- 点转坐标
- x,y 坐标生成空间对象
---

# 矢量数据的简单要素模型

## WKT 与 WKB

WKT (Well-known Text) 表达矢量几何对象的标记文本. 二进制的对应物为 WKB (Well-known Binary)

- Point, MultiPoint
- LineString, MultiLineString
- Polygon, MultiPolygon, Triangle
- PolyhedralSurface
- TIN (Triangulated irregular network)
- GeometryCollection

![](assets/geom2d_primitives.png){width=10cm}

:::notes
如果使用OGC标准进行空间对象的表达, 那么空间对象就可以作为一个字段添加到数据表中. 
:::

## 拓扑检查
在GIS中，拓扑表达了相连或相邻的矢量要素之间的关系

- 拓扑错误


<!-- `delete holes` -->

![](assets/topology_errors.png)

## 合并对象

- [ ] 修复碎片和洞

# 叠置分析

<!-- # 表连接 -->

# QGIS 操作

## 屏幕数字化与要素编辑

[屏幕数字化](https://www.osgeo.cn/qgis-tutorial/docs/digitizing_basics.html)

`Create Layer --> New Temporary Scratch Layer`

- 添加多边形
  - 移动
  - 添加ring
  - 节点工具
  - snapping自动接合

## 对象合并 Dissolve

`China-province`

- 全部合并
- 地图/属性表手动选择
- 添加列按属性选择
  - 添加`eco-dist`列
  - 将需要合并的对象赋予同一个值
  - 选择`"eco-dist" IS NOT NULL`
  - 调用`Dissolve`工具, 勾选 `selected features only`
    - `dissolve field`选'eco-dist`


## 属性数据编辑
- 数据: tl_2018_06_tract.zip, ACS_17_5YR_B01003.zip
- 直接编辑
- 字段计算器
  - 生成新字段: 人口密度
  - 更新字段

## 表格数据导入与连接

http://www.osgeo.cn/qgis-tutorial/docs/3/performing_table_joins.html

## 投影变换

## 矢栅转换

## 空间/非空间数据相互转化

- 字段计算器获取点的坐标
- 表格数据生成点

### 导入csv

- 数据: `earthquakes_2021_11_25_14_31_59_+0530.tsv`
- 拖拽 --> `create points layer from table`
- 加载CSV数据



<!-- http://www.qgistutorials.com/en/docs/3/importing_spreadsheets_csv.html

http://www.qgistutorials.com/en/docs/3/performing_table_joins.html -->


1. 数据编辑与处理
   - 图形与属性编辑 
2. 基于位置的查询
  - 叠置分析
