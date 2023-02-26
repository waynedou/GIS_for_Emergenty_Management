---
title: 应急管理与空间分析
subtitle: 空间数据与图层
author: 窦闻
Tags: #teaching

allowframebreaks: true

CJKmainfont: Songti SC
# beamerarticle: true
classoption:
    - aspectratio=1610
pdf-engine: xelatex
section-titles: false

# pandoc -t latex -V beamerarticle pyds_Lec_02.md --pdf-engine=xelatex -o Handout/pyds_Lec02_handout.pdf

output:
  beamer_presentation:
    theme:  "AnnArbor" #"Hannover"
    colortheme: "dolphin"
    fonttheme: "structurebold"
    slide_level: 3
    # beamerarticle: true
    # pdf-engine: xelatex
    path: Slides/Lecture05.pdf
    pandoc_args: ["-F", "pandoc-crossref"]
  custom_document:
    pandoc_args: ["-F", "pandoc-crossref", "-t", "latex", "-V", "beamerarticle", "-s"]
    path: 'Handout/Lecture05_handout.pdf'

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"
---


# 空间数据

- 空间数据是描述地球表面之上或接近地球表面的物体、事件或其他特征的数据。
  - 将位置信息（通常是地球上的坐标）和属性信息（相关对象、事件或现象的特征）与时间信息（位置和属性存在的时间或寿命）结合起来。 
- 能够直接进行地图制图的数据
- 现实 $\to$ 空间认知模型 $\to$ 空间数据模型 $\to$ 空间数据结构 $\to$ 文件

## 空间认知模型
:::{.columns align=center}
:::{.column width="60%" }
- 基于对象(Objects) vs. 基于场(Fields)
	- 认知的方式不同（场，对象）
	- 认知的对象不同（现象，实体）
    - 回答的问题不同
- 实体（entity）与对象（object）的区别：前者存在于现实世界，后者存在于数字世界
- 场模型相关概念
  - 空间框架
  - 场函数
  - 场操作：局域(local), 邻域(focal), 区域(zonal)

:::
:::{.column width="35%"}
\pause

![对象模型和场模型是两种互斥的视角. Rubin 花瓶](assets/rubinVase.png){width=4cm}

:::
:::

## 空间表达模型

空间表达模型是对认知模型的数学表达

- 矢量数据模型
- 栅格数据模型

### 矢量数据模型

:::{.columns align=center}
:::{.column width="50%" }
- 矢量数据采用离散对象（点、线和多边形）来表示地球表面的空间要素/实体
- 基本类型
  - 点：表示过小而无法表示为线或面以及点位置（如 GPS 观测值）的要素。
  - 线：表示形状和位置过窄而无法表示为区域的地理对象, 或有长度但没有面积的要素
  - 面：一组具有多个边的面要素，表示同类要素类型的形状和位置。


:::
:::{.column width="50%"}

![](assets/vector.png){width=5cm}

:::
:::
## 栅格数据模型
- 栅格是对场模型的自然表达
- 最简形式的栅格由按行和列（或格网）组织的像元（或像素）矩阵组成，其中的每个像元都包含一个信息值（例如温度）

:::{.columns align=center}
:::{.column width="50%" }

![](assets/raster.png){width=5cm}
:::
:::{.column width="50%"}


![栅格尺寸](assets/rasterPix.png){width=5cm}

:::
:::

### 要素表达 {.shrink}
<!-- ![](assets/rasterPt.png)

![](assets/rasterLn.png)

![](assets/rasterArea.png) -->

![](assets/vec_ras.png){width=8cm}


- 矢量和栅格都是离散化的表达
- 矢量根据坐标的顺序表示连接关系
- 栅格利用邻近关系的定义表示连接关系

## 空间数据结构
在计算机中对空间表达模型进行数据组织的方法.

- 矢量数据
  - 两种基本类型：简单数据模型，拓扑数据模型
- 栅格数据：四叉树、游程编码、小波变换等

## GIS文件格式
基于某种空间数据结构对空间数据进行封装、存储的方式, 一般包含对元数据的记录. 

- 矢量数据：shapefile, coverage, gdb, mapinfo, dxf ...
- 栅格数据：bmp, jpg, img ...

# QGIS 地图项目

- GIS 进行信息组织的基本逻辑单元是图层
  - 专题类型
  - 空间对象类型
- QGIS以项目来管理用户的所有操作
  - 添加多个不同类型的图层
  - 分别对各图层进行各种配置
  - 单独设置各种地图要素，如标题、图例等。 
- QGIS项目以`.qgs`后缀的文件名存储
  - 实际上是一个xml文件
  - 定义了QGIS的版本，地图基本信息，以及该地图包含的所有图层文件，以及渲染信息等。
- 项目文件仅保存设置，并不保存数据文件本身，因此无法单独使用项目文件绘制地图。

## 创建新项目

- 打开QGIS
- 新建项目
  - 菜单: `Project` - `New`
  - 工具栏
- 添加图层
  -  工具栏: `Data Source Manager`
  -  菜单
     - `Data Source Manager`
     - `Add Layer`
  - Browser 面板
- 保存项目
  - 菜单: `Project` - `Save`
  - 保存为 `exercise_data/basic.qgs`


## 使用 Data Source Manager 添加矢量图层

- shapefile: `exercise_data/shapefile/protected_areas.shp`
  - `Browser`面板添加收藏
  - 添加 `places.shp`, `rivers.shp`, `water.shp`
- 添加 Geopackage 库 `training_data.gpkg`
  - `road`
  - `buildings`
- 添加 SpatiaLite 库 `landuse.sqlite`
  - `landuse`
- 调整图层顺序: 点 $\to$ 线 $\to$ 面
- 保存项目

## 地图浏览工具

- 地图元素装饰
  -  菜单 `View`, `Decorations`
- 图层基本操作
- 平移与缩放
  - 指定比例尺
- 设置图层可见的比例尺范围
  - 菜单`Layer`, `Set Scale Visibility of Layer`

## 图层样式设定

- 符号选择
  - Single Symbol：单一符号, 图层中所有要素都用相同的符号显示。
    - 自定义点符号和线符号
  - Categorized：分类符号, 按类别进行符号显示。
  - Graduated：分级符号, 又称分层设色, 按数值分级显示。
  - Rule-based：这是最高级的选项。基于规则的样式非常灵活，允许我们为一个图层编写多个规则。
- 图层渲染