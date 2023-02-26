---
title: 应急管理与空间分析
subtitle: 点集空间分布与距离统计量
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
        path: Slides/Lecture11.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture11_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
---
# 空间分布表达及检验
空间分布主要通过度量一组要素的分布来计算各类用于表现分布特征的值，例如中心、密度或方向。

* 分布中心
* 分布轴线与离散度
  * 标准距离偏差与标准距离椭圆
* 分布密度

## 位置: 分布中心
:::{.columns align=center}
:::{.column width="40%" }
![](assets/center_ptSet.png){width=6cm}

:::
:::{.column width="60%"}

* 平均中心 $argmin \sum D_i^2$
  * 对点集而言就是点集的质心。
* 中位中心 $argmin\sum D_i$
* 极值中心 $argmin \max(D_i)$, 即最小外接圆圆心

:::
:::


## 标准距离与标准差椭圆
:::{.columns align=center}
:::{.column width="60%"}

- 标准距离偏差
  - 对点集空间分布进行描述的单指标度量
  从形式上看相当于标准差的概念 $\sqrt{\frac{\sum_{i=1}^n d_{iC}^2}{N}}$
  - 通常以点集的分布中心为圆心，标准差距离为半径作圆，表示点集的空间分布范围
- 标准差椭圆不仅可以反映点集分布的范围, 还可以表达方向
  - 长轴：方差最大的方向
  - 短轴：与长轴垂直方向
:::
:::{.column width="40%" }
![](assets/pt_stdDist.png){width=3cm}

![](assets/pt_stdEllips.png){width=3cm}

:::
:::

## 分布密度

- 密度的维度
  - 分布对象（点、线、面）
  - 分布范围（线、面）
  - 分布方式（连续、离散）
- 点密度估计的动机
  - 依靠分区的密度计算不能很好地反映密度的空间分布
  - 标准距离椭圆的隐含假设是正态分布，实际的空间分布可能是不同的模式，如何对两个点集的分布模式进行比较？
- 密度估计的方法
  - 规则网格划分
  	- 缺点：不满足平移不变性
  - 核密度估计
  	- 点密度估计的一个重要作用是从空间中离散的点事件，推测在空间中事件发生的概率，并提取热点(heatmap)

### 核密度估计

![](assets/kde_demo.png){width=70%}

# 距离分析
距离制图根据每一栅格相聚其最近邻要素的距离分析制图, 从而反映每一栅格与其最近邻源的相互关系

- 资源的合理规划和利用
- 设施/服务的毕设和服务区域的分析


<!-- 最小成本距离案例 https://dges.carleton.ca/CUOSGwiki/index.php/Cost_Distance_Analysis_in_QGIS_-_Ottawa_Route_Planer -->

## 直线距离制图

![基于距离变换的直线距离制图](assets/dist_transform.png){height=2.5cm}
![有障碍的距离变换](assets/dt_obstacle.png){height=2.5cm}

<!-- ![蓝色的网格范围是搜索范围，亮度表示到起点的最小距离](assets/cost_dist_raster.png){width=70%} -->

## 累积成本距离

![ACS 源](assets/acs_src.png){width=25%}
![成本表面](assets/acs_cost.png){width=25%}
![累积成本表面](assets/acs_result.png){width=25%}

---

![成本表面发生改变必然影响最短路径](assets/cost_surface.png){width=70%}

- 左图的最短路径为什么不是直线?

# QGIS 操作

## 旅游景点的空间聚集分析

- 数据
- 加载csv文件
  - `Data Source Manager` - `Delimited Text` 选择 '上海市3A级及以上旅游景区名录.csv'
  - 编码: `GBK`, xy坐标分别选择 `"经度" "纬度"` 字段, CRS 为 4326
  - 按级别分类显示
  - 热力图显示
    - 红色渐变
    - 5000m 半径
    - 行政区图层移动到最上层, 样式无填充
  <!-- - 按级别加权
    - `to_int(left("级别",1))` -->

### 集聚区域提取

<!-- - 将'上海市3A级及以上旅游景区名录.csv'导出为'SH_3A.shp' -->
- 将'上海市3A级及以上旅游景区名录.csv'导出为'Lec11.gpkg'库中的"scenic_spot"表
  - SRID: 2385/3857
- 核密度分析: `Heatmap (kernel density estimation)`
  - 半径: 5000m
  - 像元尺寸: 10m
  - 尝试使用不同的核
  - 调整显示样式`Singleband psudocolor`
- 提取集聚区域
  - 提取等值线 `Contour`
  - 间隔为1, 字段名 `dens`
  - 从属性表选择等值线为1的等值线
  - `Lines to polygons` 将选中的要素转为面状对象
  - 调整样式为纹理
  - "SH_Boundary2000" 样式调整为 `gray 1 fill`
- 进一步分析练习
  - 统计景点聚集区面积
  - 统计集聚区范围内的旅游景点和地铁站数量: `Count points in polygon`
  - 密度计算

## 距离分析

数据: SH_SubwayStation, scenic_spot

- 直线距离分析
  - `Rasterize`, 尺寸 10m, byte
    - 注意, QGIS项目的显示投影尽量与图层的投影一致; `extent`选用画布范围
- 邻近性分析
  - `Proximity`

<!-- gdal_rasterize -l substation -burn 1.0 -tr 10.0 10.0 -a_nodata 0.0 -te 635490.4724 3455827.7678 639334.1632 3459049.8159 -ot Int16 -->

### 栅格计算与转换
- `Raster Calculator...`
  - 将以上两个邻近性分析结果相加, 可以得到每个位置到最近的地铁站和最近的景点的总距离不超过6000m的像元, 保存为'tmp.tiff'
  - 图层渲染设为`Multiply`
- `Polygonize (raster to vector)`
  - `Fix geometry`
  - 选择所有DN为1的多边形
- 图形简化
  - 直接利用
  - 利用`Buffer`模拟形态学操作消除锯齿和毛刺, 依次创建-100m和100m缓冲区

### 创建model

![数学形态学开运算模型](assets/qgis_modeler_mmopen.png){width=70%}

---

![](assets/modeller_mod1.png){height=5cm}
![](assets/modeller_mod2.png){height=5cm}
![](assets/modeller_mod3.png){height=5cm}
![](assets/modeller_mod4.png){height=5cm}

### 计算旅游景点最近地铁站的距离

- `Distance matrix`
- `Distance to nearest hub (line to hub)`
  - 创建点到最近邻hub(点)的连线

