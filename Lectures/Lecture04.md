---
title: 应急管理与空间分析
subtitle: 地理信息系统
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
    path: Slides/Lecture04.pdf
    pandoc_args: ["-F", "pandoc-crossref"]
  custom_document:
    pandoc_args: ["-F", "pandoc-crossref", "-t", "latex", "-V", "beamerarticle", "-s"]
    path: 'Handout/Lecture04_handout.pdf'

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
- 参考 https://docs.qgis.org/3.22/en/docs/gentle_gis_introduction/coordinate_reference_systems.html
---

# 地理信息系统

地理信息系统（Geographic Information System, GIS）
: 地理信息系统是一门综合性学科，结合地理学与地图学，已经广泛的应用在不同的领域，是用于输入、存储、查询、分析和显示地理数据的计算机系统。

- 硬件. 硬件的性能影响到处理速度，使用是否方便及可能的输出方式。
- 软件. 不仅包含GIS软件，还包括各种数据库，绘图、统计、影像处理及其它程序。
- 数据. 精确可用的数据可以影响到查询和分析的结果。
- 过程. GIS要求明确定义，一致的方法来生成正确的可验证的结果。
- 人员. 人员是GIS中最重要的组成部分。开发人员必须定义GIS中被执行的各种任务，开发处理程序。

:::notes
人员是 GIS 系统中最容易被忽略但其实最重要的部分。熟练的操作人员通常可以克服GIS软件功能的不足，但是相反的情况就不成立。最好的软件也无法弥补操作人员对GIS的一无所知所带来的副作用。
:::

地理信息系统（GIS）与全球卫星导航系统（Global Navigation Satellite System, GNNS）、遥感（Remote Sensing, RS）合称3S。

# 地图
:::{.columns align=top}
:::{.column width="50%" }
- 专题地图
  - 自然地图
    - 地质图
    - 气候图
    - 海洋图
    - ...
  - 人文地图
    - 行政区划地图
    - 人口地图
    - 经济地图
    - 工业地图
    - ...

:::
:::{.column width="50%"}

- 专用地图
  - 教学地图
  - 航海图/航空图
  - 旅游地图
  - 公路交通图
  - 军事地图
  - ...
:::
:::



# 空间参照系 -- 从地球到地图

空间参照系是空间数据获取的基础

![空间参照系](assets/SRS.png){width=8cm}

## 大地水准面

大地水准面被定义为地球重力场的表面，它与平均海平面大致相同。其方向与重力方向垂直。

:::notes

因为地球的质量并非在各个点均匀分布，因此重力的方向也会相应发生变化，所以大地水准面的形状是不规则的。
从数学上看，大地水准面是一个连续但不规则的闭合曲面，它与经过这一曲面的铅垂线处处正交。
:::


:::{.columns align=center}
:::{.column width="30%" }

![表现大地水准面差距的假彩色图像，差距放大了10,000倍，地形添加了阴影效果](assets/geoid.png)

<!-- 来源: https://zh.wikipedia.org/wiki/%E5%A4%A7%E5%9C%B0%E6%B0%B4%E5%87%86%E9%9D%A2 -->
:::
:::{.column width="50%"}

![大地水准面与椭球体](assets/ocean_ellipsoid.png)
:::
:::

### 椭球体

椭球体是通过二维椭圆创建的三维形状。椭圆是扁平化的圆形，具有一个长轴（较长的轴）和一个短轴（较短的轴）。如果旋转椭圆，旋转所形成的形状即为椭球体。

- 长半轴是长轴长度的一半。
- 短半轴是短轴长度的一半。
- 对于地球，长半轴是从地心到赤道的半径，短半轴是从地心到极点的半径。

### 基准面
- 基准面用于定义旋转椭球体相对于地心的位置, 基准面给出了测量地球表面上位置的参考框架, 定义了经线和纬线的原点及方向。

地心基准面
: 使用地球的质心作为原点的基准面。最新开发的并且使用最广泛的基准是 WGS 1984。它被用作在世界范围内进行定位测量的框架。

区域基准面
: 在特定区域内与地球表面极为吻合的旋转椭球体。旋转椭球体表面上的点与地球表面上的特定位置相匹配。该点也被称作基准面的原点。原点的坐标是固定的，所有其他点由其计算获得。

![地心基准面, 区域基准面与大地水准面](assets/datum.png){width=5cm}

<!-- 
![分别使用 3 个不同基准面时华盛顿州贝灵厄姆市的地理坐标](assets/cordUnderDatum.png)

区域基准面的坐标系原点不在地心上。区域基准面的旋转椭球体中心距地心有一定偏移。

地球坐标系按照坐标原点不同可以分为地心坐标系（原点为地球质心，以参考椭球为基准）和参心坐标系（原点为参考椭球中心，以总地球椭球为基准）。 -->

### 地理坐标系

- 地理坐标系 (GCS) 使用三维球面来定义地球上的位置。GCS 包括角度测量单位、本初子午线和基准面（基于椭球体）。
- 点要素可通过其经度和纬度值进行引用。
- 可以将地理坐标系理解为球面上的坐标系

### 地图投影与投影坐标系

- 地图绘制在二维平面上
- 地图投影使用数学公式将地球上的球面坐标与平面坐标关联起来。
- 投影坐标系始终基于地理坐标系，而后者则基于球体或椭圆体。
  - WGS84 既是地理坐标系, 也是一种无投影的投影坐标系
- 球面是不可展开面

![等角航线在墨卡托投影里是直线。等角航线是一条恒定方位的航线。方向角是罗盘的运动方向。](assets/proj_merc.png){width=60%}

### 投影的性质

- 等角投影
  - 保持角度
- 等积投影
  - 保持面积
- 等距投影
  - 某些方向上保持距离

### 基本投影类型 {.allowframebreaks}
:::notes
地图投影（英语：map projection）是一种将地球表面展平的方法，以便制作地图，这就需要一种方法将球面上的点转换为平面上的点. 地图投影有很多方法, 参见[地图投影列表](https://en.wikipedia.org/wiki/List_of_map_projections)
:::

![主要投影类型](assets/proj_cat.png){width=70%}

\framebreak

<!-- ![](assets/proj_albs.png) -->

![切投影与割投影](assets/proj_sec_tang.png){width=60%}


# 初识 QGIS

Quantum GIS（QGIS）是开源地理信息系统桌面软件， 使用GNU（General Public License）授权，属于 Open Source Geospatial Foundation（OSGeo）的官方计划。 在 GNU 授权下，开发者可以自行检阅与调整程序代码，并保障让所有使用者可以免费且自由地修改程序。

## 基本界面
:::{.columns align=center}
:::{.column width="40%" }
- 菜单
- 工具栏
  - 下方状态条
  - 左下快速访问
- 面板
  - 左侧: Layers和Browser面板
  - 右侧: Processing Toolbox
- 绘图区

:::
:::{.column width="60%"}
![](assets/qgis_ui.png)
:::
:::

## 插件安装与使用

![QGIS 插件管理](assets/qgis_plugins.png){width=60%}

- QuickMapServices
- QuickOSM

## 快速上手
- 使用 `XYZ Tiles`显示 OSM 地图
  - `https://tile.openstreetmap.org/{z}/{x}/{y}.png`
  - [OSM zoom level](https://wiki.openstreetmap.org/wiki/Zoom_levels)设为 20.
- 加载 OSM 图层
- `Create grid`工具创建经纬网
- 改变显示的投影方式
  - 4326(WGS 84), 3857(WGS 84), 54052(Goode), 54024(Bonne), 102025(Albers), 方位投影(azimuthal)
  
## OSM 数据下载

- 左下快速访问 `go 119,32`
- QuickOSM
  - key: `building`
  - `Canvas Extent`
- 增加标注
  - `Single Labels`: `name`
- 根据属性过滤
  - `"building" IN ('dormitory','residential','apartments'`
- 修改图层名
- 导出