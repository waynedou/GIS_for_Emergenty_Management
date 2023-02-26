---
title: 应急管理与空间分析
subtitle: 矢量数据的基本量测与形状参数
author: 窦闻
Tags: #teaching

CJKmainfont: Songti SC
# mainfont: WenQuanYi Micro Hei Mono
classoption:
    - aspectratio=1610
pdf-engine: xelatex
section-titles: false

output:
    # beamer_presentation:
    #     theme: "AnnArbor"
    #     colortheme: "dolphin"
    #     fonttheme: "structurebold"
    #     slide_level: 3
    #     # pdf-engine: xelatex
    #     path: Slides/Lecture07.pdf
    #     pandoc_args: ["-F", "pandoc-crossref"]
    #   # pandoc_args: ["-d", "beamerslide"]
    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture07_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
  - 可适当增加spatialanalysis内容 https://www.spatialanalysisonline.com/HTML/index.html?length_and_area_for_vector_dat.htm 
  - 实际讲了两次课, 顺便复习. 操作讲解的速度要放慢.
---

# 空间问题与空间分析

- 空间分析是空间框架下的数据分析
- GIS 中的空间分析是一系列基本工具，即操作。
  - 空间问题求解就是利用空间分析的工具进行空间问题建模
- 矢量数据空间操作大致分为**距离**、**方位**、**拓扑**和**集合**四种类型。
- 空间量测
  - 距离
  - 面积

## 距离与长度 {.shrink}

- 点与点：广义距离 (Minkowski distance)，设有两点$X$和$Y$，第$i$维坐标分别为$x_i$和$y_i$，则两点间广义距离为 $$ D = \sqrt[p]{\sum{|x_i - y_i|^p}}$$
  - 欧氏距离 Euclidean distance, $p=2$
  - 棋盘距离 Chebyshev distance, $p=\infty$
  - 曼哈顿距离 Manhattan distance, $p=1$

![广义距离](assets/dist_euc_mann_ch.png){width=10cm}

- 长度 
  - 平面: 欧氏距离
  - 球面: $d_{i j}=R \cos ^{-1}\left[\sin \varphi_{i} \sin \varphi_{j}+\cos \varphi_{i} \cos \varphi_{j} \cos \left(\lambda_{i}-\lambda_{j}\right)\right]​$

:::notes
$\lambda$ 为经度, $\varphi$ 为纬度.
:::

### 不同距离间的关系 {.shrink}
:::{.columns align=bottom}
:::{.column width="40%" }
- 欧氏距离是最常用的距离, 表示不受限空间中两点之间的距离
- 曼哈顿距离, 又称出租车距离, 可以表现规则的城市街道网络中两点之间的距离
- 实际城市街道中两点间的距离可以用 $p \in (1,2)$ 的广义距离进行估算. 
:::
:::{.column width="60%"}
![欧氏距离与曼哈顿距离](assets/dist_euc_mann.png){width=4cm}
:::
:::

![不同距离定义下的单位圆](assets/dist_unit_circ.png){height=2cm}

 <!-- [来源: https://en.wikipedia.org/wiki/Minkowski_distance] -->

### 几何对象之间的距离

- 点/集合之间的距离定义
- 以点之间的距离为基础
  - GIS 中主要采用点集间距离最小的点对之间的距离作为点集间距离的定义

![几何对象之间的距离](assets/dist_geom.png){width=6cm}

## 面积度量 {.shrink}
:::{.columns align=center}
:::{.column width="40%" }

- 平面的面积：辛普森积分法
$$
A=\frac{1}{2} \sum_{i=1}^{n-1}\left(x_{i+1} y_{i}-x_{i} y_{i+1}\right)
$$
- 多边形对象的合法性
  - 边界不能自相交

![一个不合法的多边形, 计算面积为 0](assets/invalid_area.png){width=3cm}
:::
:::{.column width="60%"}
![](assets/measur_area_simp.png){width=8cm}


:::
::: 

## 几何形状
- 简单的图形概括
  - 质心
    - 可能落在空间对象外部
  - 最小外接矩形（Box2D）
  - 最小外接圆（MinimumBoundingCircle）
  - 最大内切圆
  - 最小凸包（ConvexHull）
- 形状参数
  - 紧凑度, 紧凑指数.
    - 圆是最紧凑的图形
    -  $P 2 A_{i}=\frac{L_{i}^{2}}{A_{i}}$
  - 凸度, 凹度, 弯曲度

# QGIS 操作

- 地图创建
  - `New Layout`
  - 添加多个地图
    - `Overview`
  - 添加指北针和比例尺
    - 旋转地图
- 矢量数据合法性
- 图形概括
- 形状参数计算

:::notes
`Pan Layout` 工具对布局进行平移, 滚轮对布局进行缩放; `Move item content` 工具对地图内容进行平移, 滚轮对地图内容进行缩放. 
:::
## 几何对象的合法性

- 合法性检查: `Vector geometry` - `check validity`
- 检查 `alaska`
- 查看结果
  - `Error Output` 设置为较为醒目的样式
- 修复: `Vector geometry` - `Fix geometries`
  - 再次检查

## 创建简单图形概括

- 为修复的`alaska`创建外接图形
  - `Vector geometry` - `Minimum bounding geometry`
  <!-- - `Vector geometry` - `Minimum enclosing circles`
  - `Vector geometry` - `Oriented minimum bounding box` -->
- 为`airports` 创建凹包
  - `Vector geometry` - `Concave hull`
- 为`regions` 创建代表点
  - 质心: `Vector geometry` - `Centroids`
    - 注意 `fid` 为 11 的对象
  - `Vector geometry` - `Point on surface`

## 几何属性计算 

- 检查合法性
- 属性计算器 ^[更多几何操作函数参见[用户手册](https://docs.qgis.org/3.22/en/docs/user_manual/expressions/functions_list.html#geometry-functions)]
  - `regions`表添加面积字段
    - 使用 `area` 和 `$area`
  - 将面积单位改为平方公里
  - 添加公里为单位的周长字段
    - ` $perimeter`
  - 计算形状指数
  - 对形状指数字段按不同分类方法显示
- `Vector geometry` - `Add geometry attributes`
- 重投影. 将`regions`重投影为`wgs84 (EPSG:4326)`
  - `Vector general` - `Reproject layer`
  - 在重投影图层上再次计算


:::notes
`area` 和 `$area` 的区别在于

- `area`以`$geometry` 为输入参数; `$area` 无需参数
- `area` 直接根据平面坐标计算面积, 单位由 CRS 决定; `$area` 在可能的情况下根据椭球体计算球面上的面积, 更加精确, 单位为平方米. 
:::