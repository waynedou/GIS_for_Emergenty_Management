---
title: 应急管理与空间分析
subtitle: 集合操作
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
        path: Slides/Lecture09.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture09_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
- 提取所有图片 `grep -Eo "[^(]*\.(jpg|png|gif)" Lecture09.md |xargs -I{} cp "{}" /Users/wayne/Documents/Teaching/Spatial_Temporal_Big_Data/Lectures/assets`
- 查找的正则表达式 `(?<=!\[.*\]\().*?(?=\))`
---
<!-- # 合并查询结果 -->

# 空间关系

<!-- ![](assets/sptial_relation.png)   -->

:::{.columns align=center}
:::{.column width="40%" }
空间关系是空间查询的重要部分, 用于帮助回答"事件发生在哪个辖区"/"这个小区的隔壁是哪些单位"之类的问题. GIS中常用拓扑关系包括

- Disjoint
- Touch
- Overlap
- Contain
- Be within
- Equal
- Cross
- **Intersect**
:::
:::{.column width="60%"}
![面对象之间的拓扑关系](assets/fig_topo_rel.png)

:::
:::



:::notes
overlap 和 intersect的主要区别是, overlap的重叠部分应该与对象的维度相同. intersect是使用最广泛的拓扑关系. 
:::

## 9交模型

<!-- ![9交模型的基本概念](assets/fig_topo_concept.png) -->

![面对象](assets/9im1.png){width=40%}  ![线对象](assets/9im2.png){width=40%} 

$$
R(A, B)=\left(\begin{array}{ccc}A^{\circ} \cap B^{\circ} & A^{\circ} \cap \partial B & A^{\circ} \cap B^{-} \\ \partial_{A} \cap B^{\circ} & \partial A \cap \partial B & \partial A \cap B^{-} \\ A^{-} \cap B^{\circ} & A^{-} \cap \partial B & A^{-} \cap B^{-}\end{array}\right)
$$

### DE-9IM
维度拓展的9交模型和9交模型相比, 将9交矩阵的元素从bool值改为相交部分的维度.

:::{.columns align=center}
:::{.column width="40%" }
![DE-9IM 示例](assets/demo-9im.png){height=6cm}

:::
:::{.column width="40%"}

![水体和码头](assets/demo_topo_check.png){width=6cm} 
:::
:::



# 叠置分析

- 空间数据的叠置在图层间进行，被叠置的图必须是同一地区、同一比例尺、同一投影方式，且各图均已进行了配准
- 在 GIS 出现之前, 地理学家在透明的塑料片上创建地图，然后在看版台上将这些塑料片叠加到一起以创建叠加数据的新地图。
- 矢量数据的叠置分析又称拓扑叠加

## Intersection {.shrink}

![求交运算](assets/qgis_intersection.png){width=5cm}

![裁剪](assets/qgis_clip.png){width=5cm}

如何计算长江在江苏省内流经的长度?

## Union {.shrink}

![图层内求并运算](assets/qgis_union.png){width=5cm}

![图层间求并运算](assets/qgis_union_cross_layers.png){width=5cm}

- GIS中主要是对图层间进行Union运算
- 如果仅仅计算图形的并集的运算称为边界消融(Dissolve)

## Difference

![求差运算](assets/qgis_difference.png){width=7cm}

## Symmetrical difference

![对称差运算](assets/qgis_symdiff.png){width=7cm}

# QGIS 操作

- 数据集: qgis-sample-data.gpkg
  - regions
  - airports
  - majrivers
- 主要功能
  - 按位置查询
  - 聚合统计
  - 可视化建模

## 根据位置的查询

- 提取 'Yukon-Koyukuk' 周边区域的所有机场
- `Select by attribute`: name2 = Yukon-Koyukuk
- `Select by location`: 'regions', `touch`, 勾选 `Selected features only`
- `Extract by location`: 'airports', `are within`, 'regions', `Selected features only`
- 创建 model

## 根据位置聚合统计

### 计算 Alaska 各区的机场密度
- `Count points in polygon`
- `Field calculator`
  - 为regions添加"airport_dens"字段
  - `"NUMPOINTS"/($area/1e10)` 每1万平方公里的机场数量

### 统计各区的建成区面积(平方米)
- 计算各建成区面积
  - `Add geometry attributes`: 根据椭球体计算面积
  - 将临时图层更名为'buildup_tmp'
- 也可采用 `Field calculator`增加字段
- 空间连接并聚类统计: `Join attributes by location (summary)`
  - input layer: regions
  - Join layer: buildup
  - Geometric predicts: intersects
  - 统计字段: area
  - 统计方法: sum
- 对"area_sum"字段进行 `Graduated` 显示
- 更新"area_sum"字段
  - `coalesce("area_sum" , 0)`

## 统计区内主要河流长度
- 比较`clip`和`intersection`
- 从 'region' 中选择几个区域(减少运算量)
- `intersection`, 'majrivers', 'region', `Selected features only`
- `Add geometry attributes`
- `Aggregate`, 'Added geom info', 分组 "name_2", 聚合 "name_2", `first-value`, "length_2", `sum`
  - 或 `Join attributes by location (summary)`

:::notes
这里主要是为了演示空间聚类, 实际计算应先对`majrivers` 按 "description"字段(河流名称)进行对象合并(`Dissolve`), 然后求交, 即可获得各主要河流流经各区的部分. 
:::
