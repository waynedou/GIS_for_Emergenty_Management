---
title: 应急管理与空间分析
subtitle: 空间邻近性分析
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
        path: Slides/Lecture10.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture10_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
---

# 缓冲区分析

:::{.columns align=center}
:::{.column width="40%" }
- 在空间分析中, 与给定空间对象不超过给定距离的区域称为缓冲区, 用以检查物体对周边的影响. 
  - 独立缓冲区
  - 融合缓冲区
- 缓冲区分析和叠置分析是最常用的两种空间分析手段
  - 检查楼间距是否达标
  - 洪泛区划定
:::
:::{.column width="60%"}
![](assets/buffer_analysis.png){width=8cm}

:::
:::

<!-- https://www.osgeo.cn/qgis-tutorial/relation-buffer.html -->


## 缓冲区基本要素

:::{.columns align=center}
:::{.column width="40%" }
- 缓冲区对象
- 缓冲区半径
  - 定值或变量
  - 半径可以为负值
- 缓冲区方向
  - 线: 左/右/两侧
  - 面: buffer vs. setback
    - setback 可以用多边形减去负值缓冲区获得, 或提取多边形边界后生成单侧缓冲区

:::
:::{.column width="60%"}
![](assets/buff_setback.png){width=8cm}

:::
:::

# QGIS 缓冲区操作示例

## 统计便利店100m范围内的公交车站个数
- 创建便利店缓冲区->"store_buf"
- `Join attributes by location (summary)`: `count`
- 更新计数字段: `coalesce( "name_count" , 0)`
- 根据计数字段显示

## 查询 100m 范围内没有便利店的公交车站
- 创建便利店缓冲区: `Dissolve result`->"store_buf_dis"
- 方法1: `Select by location`: `disjoint` 
- 方法2: 全选公交车站 -> `Select by location`: `within`, `removing from current selection`
- 方法3: `Join attributes by location`: `unjoinable features from first layer`

## 统计静安区便利店服务覆盖面积
- `Lines to Polygons` 将 "boundary" 转为面状数据, 重命名为"stb_boudary"
- `Clip`: "stb_boudary" 对 "store_buf_dis" 裁剪 -> "store_service"
- 为 "store_service" 增加面积字段 "area_service"
  - `$area/1e6`
- 进一步: `Difference` 将 "stb_boudary" 减去  "store_service", 获得无覆盖区域

# 镶嵌/剖分(Tessellation)

:::{.columns align=center}
:::{.column width="40%" }
- 镶嵌就是对空间的划分
  - 规则划分: 矩形/正方形, 三角形, 六边形
  - 不规则划分: Delaunay 三角网, Voronoi 图
- Delaunay 三角网(TIN) 与Voronoi 图 (泰森多边形)
  - 对偶图形

:::
:::{.column width="60%"}
![](assets/TIN_VORONOI.png){width=8cm}

:::
:::


## Voronoi 图

用${X}$表示一个距离函数为$d$的空间（一个非空集合）。令$K$为一个指数集合，$(P_{k})_{{k\in K}}$为空间$X$的一个非空子集的有序元组。对应于${P_{k}}$的$R_{k}$，称为 Voronoi 区域，是空间 $X$ 中所有到 $P_{k}$ 的距离不大于到其他位置 $P_{j} (j \neq k)$ 的点集。或者说，如果定义 $d(x,A)=\inf\{d(x,a)\,|\,a\in A\}$为点 $x$ 和子集 $A$ 的距离，则
$$R_{k}=\{x\in X\,\,|\,\,d(x,P_{k})\leq d(x,P_{j})\,\,{\text{for all}}\,\,j\neq k\}$$

<!-- ![](assets/voronoi_euc_dist.png){width=8cm} -->

![](assets/Voronoi_dist.png){width=8cm}

# QGIS Voronoi 图操作示例

## 便利店服务区划分
- 数据: Lec10-1.gpkg
- 数据预处理
  - `Multipart to singleparts` 转换 store
- 为便利店创建Voronoi多边形
  - `Voronoi Polygons`: `Buffer region`=25
  - 选择"stb_boundary"裁剪生成的Voronoi多边形 -> "store_Voronoi"
- 如何查询到给定位置最近的便利店?

## 便利店服务区人口统计

- "Jingan_pop2015" 为网格形式存储的人口数据
- `Intersection`: "store_Voronoi" and  "Jingan_pop2015"
  - 图层重命名 => "intersection_voro_pop"
- 字段计算: `$area *  "pop" / "area_2" `, 保存为字段 "pop_service"
- `Statistics by categories`
  - 统计字段: "pop_service"
  - 类别字段: "id"
- 将"store_Voronoi" 与统计结果关联并显示

###  点符号大小表示定量数据
:::{.columns align=center}
:::{.column width="40%" }

- ``store" 与统计结果关联, 获取服务区人口数
- 根据服务区人口数设置符号大小
:::
:::{.column width="60%"}

![](assets/pt_symb_size.png){width=8cm}

:::
:::

### 统计服务区内100m范围内的公交车站数

- `Intersection`: "store_Voronoi" and "store_buf" 
- `Extract by expression`: "id"="id_2"
- `Count points in polygon`: "bus_stop"
  - 按点数显示

# 综合练习: 市区择房分析

## 选址问题

要求:
所寻求的市区是噪声要小，距离商业中心要近，要和各大名牌高中离的近以便小孩容易上学，离名胜古迹较近环境优雅。综合上述条件，给定一个定量的限定如下:

- 离主要市区交通要道200米之外，交通要道的车流量大，噪音产生的主要源于此; (ST 为道路类型中的主要市区交通要道)
- 距大型商业中心的影响，以商业中心的大小来确定影响区域，具体是以其属性字段 YUZHI_;
- 距名牌高中在750米之内，以便小孩上学便捷;
- 距名胜古迹500米之内。

## 基本步骤

首先对问题的各定量要求进行空间分析计算

- 数据: Lec10-2.gpkg
- 主干道噪音缓冲区
   - "network", 选择 `"TYPE"='ST'` 的路段(主干道)
   - 对选中的道路创建 200m 融合缓冲区
- 商业中心影响范围
  - "Marketplace"创建缓冲区
    - `distance`选择"YUZHI_"字段
    - 边界融合
- 名校影响范围
  - "school" 创建 750m 融合缓冲区
- 名胜古迹的影响范围
  - "famous place" 创建 500m 融合缓冲区

然后通过叠置分析获得满足所有条件的区域

- 求商业中心影响范围, 名校影响范围 和名胜古迹影响范围的交集
- 上述交集减去主干道噪声缓冲区