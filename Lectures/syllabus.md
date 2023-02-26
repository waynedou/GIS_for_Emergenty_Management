---
title: 《应急管理与空间分析》课程大纲
author: 窦闻
Tags: #teaching

CJKmainfont: Songti SC
# mainfont: WenQuanYi Micro Hei Mono
classoption:
    - aspectratio=43
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
        path: Slides/syllabus.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/syllabus_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"
---

- 表连接[教程](https://www.osgeo.cn/qgis-tutorial/docs/performing_table_joins.html)

# Lec 8 空间叠置分析与矢量数据编辑

- 空间叠置分析
  - 

- QGIS 操作
- 创建矢量图层
  - 屏幕数字化
  - 对象编辑
- 叠置分析
- 点转坐标
- x,y 坐标生成空间对象

# 制图练习(汤 ch5)

- 加载 shapefile, 创建 `shanghai.gpkg` 并导入所有图层
- 创建新项目, 加载 `shanghai.gpkg`
- 全选图层, `Layer CRS` 设置为 `EPSG: 4326`
- `Project --> Save to --> GeoPackage`
- 修改图层名称: 选中图层, 回车
  - 点图层:QXZF(区县政府)，SZF(市政府)
  - 线图层:DTX(地铁线)，QXJX(区县界线)， DL(道路) 
  - 面图层:QXJM(区县界面)，SXH(双线河)
- "区县界面" 样式修改
  - 方案 1: `Categorized`, 按`name`分类
  - 方案 2: 
    - `Processing Toolbox --> topological coloring` 保存到 `shanghai.gpkg`
    - `Categorized`, 按`color_id`分类, `blues`色带
  - 添加标注: `name`
- "地铁线"
  - Color:深蓝色 #000053 ，Width:1.5。
- "道路", 参考 https://blog.csdn.net/QGISClass/article/details/113889129
  - `label --> Placement`, `Mode` 选择 Curved, 
- "市政府", "区县政府"
- 制图


# QGIS

## 属性查询

## 属性编辑

- 多重编辑
  - 属性表 Edit ► multiEdit Modify attributes of selected features menu.

## 连接与关联
https://docs.qgis.org/3.16/en/docs/user_manual/working_with_vector/attribute_table.html#creating-one-or-many-to-many-relations

- 定义 1 对多联系
  - Project ► Properties…. Open the Relations tab and click on signPlus Add Relation.


# Lec 

- 数据编辑与处理
  - 图形编辑
  - 属性编辑
- 数据处理
  - 数据裁切
  - 数据拼接
  - 数据提取
- 数据转换
  - 数据结构转换: 矢量-栅格转换
  - 投影转换
  - 格式转换


1. 数据编辑与处理
   - 图形与属性编辑 
2. 基于位置的查询
  - 叠置分析
2. 基于拓扑关系的查询
  - 拓扑关系表达 
  - 空间连接 http://www.osgeo.cn/qgis-tutorial/docs/3/performing_spatial_joins.html
3. 基于位置和距离的空间分析
  - 缓冲区分析
  - voronoi图
  - TIN
4. 空间分布
  - 分布中心
  - 分布范围和方向: 标准
  - 密度分析
5. 空间统计
   - [@burt2019esg]
6. 网络分析
   1. https://docs.qgis.org/3.16/en/docs/training_manual/vector_analysis/network_analysis.html
7. 栅格数据分析
   (http://www.osgeo.cn/qgis-tutorial/docs/3/multi_criteria_overlay.html)
8. 数据库基础



# Notes

- `Tin Mesh Creation` 依据属性创建三角网
  - Delaunay triangulation
- Geometry by expression
- Multi-ring buffer (constant distance)
- Overlap analysis

## Web地图服务

http://openwhatevermap.xyz/