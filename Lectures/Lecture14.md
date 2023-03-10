---
title: 应急管理与空间分析
subtitle: 数据库设计
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
        path: Slides/Lecture14.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture14_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
---

# 关系数据库规范化理论

:::notes

一个关系数据库模式由一组关系模式组成, 一个关系模式由一组属性名组成. 数据库设计的一个最基本的问题是怎样建立合理的数据库模式, 使数据库系统无论是在数据存储方面, 还是在数据操作方面都具有较好的性能. 关系数据库的规范化理论对关系数据库结构的设计起着重要的作用. 
:::

规范化理论包括3个内容. 

1) 数据依赖, 这是核心, 主要研究数据之间的联系
2) 范式, 是关系模式的标准
3) 模式设计方法, 是自动化设计的基础

## 问题提出
:::notes

设计一个学校教学管理的数据库, 要求一个系有多名学生, 一个学生只属于一个系；一门课只有1名任课教师；一个学生可以选修多门课程, 每门课程可有多个学生选修；每个学生学习每一门课程仅有一个成绩. 
:::
采用单一的关系模式设计为 $R(U)$, 其中 $U$ 是由属性学号（StuNo）、姓名（StuName）、系名（DName）、系负责人（MName）、课程编号（CNo）、课程名（CName）、任课教师姓名（TName）、成绩（Score）组成的属性集合. 若将这些信息设计成一个关系, 则关系模式如下. 

`SCD=(StuNo, StuName, DName, MName, CNo, CName, TName, Score)`

主码为(StuNo, CNo). 

![示例关系实例](assets/demo_stud_redundant_db.png){width=80%}

### 存在的问题

1. 数据冗余: 课程信息, 学生个人信息重复存储. 
2. 插入异常: 主码不能为空, 新课程无法输入
3. 修改异常: 学生信息或课程信息变更时涉及多条记录的同步更新
4. 删除异常: 记录同步更新

:::notes
不合理的关系模式最突出的问题是数据冗余, 
关系系统当中数据冗余产生的重要原因就在于对数据依赖的处理.
解决数据间的依赖关系常常采用对关系的分解来消除不合理的部分, 以减少数据冗余, 解决插入异常、修改异常和删除异常的问题. 
:::

### 解决方法

将 SCD 分解为

- 学生基本信息S(StuNo, StuName, DName)
- 院系信息D(DName, MName)
- 课程信息C(CNo,CName,TName)
- 学生成绩SC(StuNo,CNo,Score)

## 关系模式规范化

<!-- 属性间的关联表现为一个属性子集对另一个属性子集的"依赖"关系. 数据依赖（Data Dependency）是同一关系中属性间的相互依赖和相互制约. 数据依赖包括函数依赖（Functional Dependency）、多值依赖（Multivalued Dependency）和连接依赖（Join Dependency）. 基于对这三种依赖关系在不同层面上的具体要求, 人们又将属性之间的这些关联分为若干等级, 这就形成了所谓的关系的规范化.  -->


- 数据依赖是同一关系中属性间的相互依赖和相互制约
  - 函数依赖
  - 多值依赖
  - 连接依赖
- 函数依赖是数据依赖的一种, 它反映了同一关系中属性间一一对应的约束. 
  - 函数依赖是关系规范化的理论基础. 

函数依赖
: 设 $R(U)$ 是一个属性集 $U$ 上的关系模式,  $X$ 和 $Y$ 是 $U$ 的子集. 若对于 $R(U)$ 的任意一个可能的关系 $r$ , 如果 $r$ 中不存在两个元组, 它们在 $X$ 上的属性值相等, 而在 $Y$ 上的属性值不等, 则称 "$X$ 函数确定 $Y$" 或 "$Y$ 函数依赖于 $X$", 记作 $X \to Y$ . 

:::notes
关系模式 $R(U)$ 和关系 $r$ 的关系, 相当于类和示例的关系.
:::

### 示例
在关系模式`SCD=(StuNo,StuName,DName,MName, CNo,CName,Score)`中, 存在以下函数依赖集. 

$$
\begin{aligned}
F=\{StuNo \to StuName, StuNo \to DName,
\\
DName \to MName, CNo \to CName,
\\
(StuNo,CNo) \to Score\}
\end{aligned}
$$

根据学生的学号（StuNo）, 可以唯一地查询到其对应的姓名（StuName）、系名（DName）等, 即, "学号函数确定了姓名或系名", 记作 "$StuNo \to StuName$", "$StuNo \to DName$"等. 

### 函数依赖
平凡函数依赖与非平凡函数依赖
: 在关系模式$R(U)$中, 对于$U$的子集$X$和$Y$, 如果$X \to Y$, 但$Y$不是$X$的子集, 则称 "**$X \to Y$是非平凡函数依赖**". 若$Y$是$X$的子集, 则称 "**$X \to Y$是平凡函数依赖**"  . 

完全函数依赖与部分函数依赖
: 在关系模式$R(U)$中, 如果$X \to Y$, 并且对于$X$的任何一个真子集$X'$, 都有$X' \not \to Y$, 则称 "**$Y$ 完全函数依赖于 $X$**", 记作$X \stackrel{F}{\longrightarrow} Y$. 若$X \to Y$, 但$Y$不完全函数依赖于$X$, 则称 "**$Y$部分函数依赖于$X$**", 记作$X \stackrel{P}{\longrightarrow} Y$

:::notes

例如, 在关系模式SCD中, $(StuNo,CNo) \to Score$是完全函数依赖, 而$(StuNo,CNo) \to DName$是部分函数依赖. 
:::

传递函数依赖
: 在关系模式$R(U)$中, 如果$X \to Y, Y \to Z$, 且$Y \not \to X$, 则称$Z$传递函数依赖于$X$, 记作$X \stackrel{T}{\longrightarrow} Z$

:::notes

传递函数依赖定义中之所以要加上条件 $Y \not \to X$, 是因为如果 $Y \to X$, 则 $X \leftrightarrow Y$, 这实际上是 $Z$直接依赖于$X$, 而不是传递函数依赖了. 
:::

### 实体完整性

候选码与主码
: 在关系模式$R(U)$中, $K$ 为 $U$ 的子集, 若$K \stackrel{F}{\longrightarrow} U$, 则称 $K$ 为 $R$ 的一个候选码. 若关系模式 $R$ 有多个候选码, 则选定其中一个作为主码 (Primary Key)

外码
: 关系模式R中属性或属性组$X$并非$R$的码, 但$X$是另一个关系模式的码, 则称$X$是$R$的外部码, 也称为外码 (Foreign Key)


码是由一个或多个属性组成的可唯一标识元组的最小属性组。码在关系中总是唯一的，即码函数决定关系中的其他属性。因此，一个关系，码值总是唯一的 (如果码的值重复，则整个元组都会重复); 否则，违反实体完整性规则。

### 关系模式分解 {.allowframebreaks}
设有关系模式$R(U, F)$, 其中

- $U ＝ \{StuNo, StuName, DName, MName\}$, 
- $F＝ \{StuNo \to StuName, StuNo \to DName, DName \to MName\}$.

系主任 (MName) 与学号 (StuNo) 之间存在传递依赖. 分解为两个关系模式

- $R1(\{StuNo,StuName,DName\},$ $\quad \quad \{StuNo \to StuName,StuNo \to DName\})$
- $R2(\{DName,MName\}, \{DName \to MName\})$

\framebreak

![原关系模式R的实例](assets/r_trans_dep.png){width=70%}

![分解关系模式R1](assets/r_sep_1.png){width=70%}

![分解关系模式R2](assets/r_sep_2.png){width=70%}

:::notes

$$R = R1 \bowtie R2$$
是一个无损分解. 
:::

### 范式: 关系模式的规范化
:::notes

范式是符合某一种级别的关系模式的集合，是衡量关系模式规范化程度的标准，达到的关系才是规范化的。目前主要有6种范式：第一范式、第二范式、第三范式、BC范式、第四范式和第五范式。满足最低要求的称为第一范式，简称1NF。在第一范式基础上进一步满足一些要求的为第二范式，简称为2NF。其余以此类推。各种范式之间的关系如下: 

1NF $\supset$ 2NF $\supset$ 3NF $\supset$ BCNF $\supset$ 4NF $\supset$ 5NF

一般了解前三个范式即可. 
:::

关系模式的规范化主要解决的问题是关系中数据冗余及由此产生的操作异常。而从函数依赖的观点来看，即是消除关系模式中产生数据冗余的函数依赖。

- 第一范式
  - 如果关系模式$R$中每个属性值都是一个不可分解的数据项，则称该关系模式满足第一范式，简称 1NF，记为 $R \in \text{1NF}$. 
  - 数据项的原子性要求. 
- 第二范式
  - 如果一个关系模式 $R \in \text{1NF}$, 且它的所有非主属性都完全函数依赖于$R$的任一候选码，则称R符合第二范式，记为 $R \in \text{2NF}$. 
  - 不存在部分依赖
- 第三范式
  - 如果一个关系模式 $R \in \text{2NF}$，且所有非主属性都不传递函数依赖于任何候选码，则称R符合第三范式，记为$R \in \text{3NF}$
  - 不存在传递依赖

# 数据库设计
## 数据库设计的任务
- 广义的数据库设计是指建立数据库及其应用系统，包括选择合适的计算机平台和数据库管理系统、设计数据库以及开发数据库应用系统等。
  - 数据库
  - 以数据库为基础的应用系统
- 狭义的数据库设计是指根据一个组织的信息需求、处理需求和相应的数据库支撑环境（主要是DBMS），设计出数据库，包括概念结构、逻辑结构和物理结构。

## 数据库设计的方法

- 手工试凑法
- 规范化设计方法
  - 新奥尔良方法: 需求分析、概念结构设计、逻辑结构设计、物理结构设计4个阶段。
- 数据库设计的基本思想是过程迭代和逐步求精

### 数据库设计的步骤

![规范化设计的基本步骤](assets/DB_design_steps.png){width=40%}

:::notes

1. 需求分析阶段. 需求分析阶段主要是准确收集用户信息需求和处理需求，并对收集的结果进行整理和分析，形成需求分析报告。需求分析是整个设计活动的基础，也是最困难和最耗时的一步。如果需求分析不准确或不充分，可能导致整个数据库设计的返工。
2. 概念结构设计阶段. 概念结构设计是数据库设计的重点，对用户需求进行综合、归纳、抽象，形成一个概念模型（一般为E-R图），形成的概念模型是与具体的DBMS无关的模型，是对现实世界的可视化描述，属于信息世界，是逻辑结构设计的基础。
3. 逻辑结构设计阶段. 逻辑结构设计是将概念结构设计的概念模型转化为某个特定的DBMS所支持的数据模型，建立数据库逻辑模式，并对其进行优化，同时为各种用户和应用设计外模式。
4. 物理结构设计阶段. 物理结构设计是为设计好的逻辑模型选择物理结构，包括存储结构和存取方法，建立数据库物理模式（内模式）。
5. 数据库实施阶段. 实施阶段就是使用DLL语言建立数据库模式，将实际数据载入数据库，建立真正的数据库；在数据库上建立应用系统，并经过测试、试运行后正式投入使用。
6. 运行与维护阶段. 运行与维护阶段是对运行中的数据库进行评价、调整和修改。
:::

## 需求分析


:::{.columns align=top}
:::{.column width="35%" }
![需求分析流程](assets/dbDesignNeedAnalysis.png){width=80}

:::
:::{.column width="60%"}
- 信息需求
  - 用户在数据库中需要哪些数据，这些数据的性质是什么，数据从哪儿来。由信息要求导出数据要求
  - 确定数据库中需要存储哪些数据，形成数据字典
- 处理需求
  - 用户完成哪些处理，处理的对象是什么，处理的方法和规则，处理有什么要求
  - 使用数据流图进行描述
- 性能需求
  - 用户对新系统性能的要求
:::
:::

### 数据流图

数据流图要表述出数据来源、数据处理、数据输出以及数据存储，反映了数据和处理的关系。

![数据流图(Data Flow Diagram)语法](assets/dbDesign_DFD.png){width=50%}

![数据流图示例](assets/DFD_demo.png){width=50%}

### 数据字典
- 数据字典是关于数据库中数据的描述，是元数据，而不是数据本身。数据字典通常包括数据项、数据流、数据存储和处理4个部分
- 数据项描述: {数据项的名称、数据项含义、别名、数据类型、数据长度、取值范围、说明、与其他数据项之间关系等}。

![数据字典示例](assets/DataDict_demo.png)

## 概念结构设计

- 概念结构设计的目的是获取数据库的概念模型，将现实世界转化为信息世界，形成一组描述现实世界中的实体及实体间联系的概念
- ER图
  - 矩形表示实体
  - 菱形表示联系
  - 椭圆形表示属性
  - 实体-联系之间用线段连接

### E-R图

![ER 图示例](assets/ERD_demo.png){width=70%}


### 局部 ER 图
- 确定范围
  - 可以按业务部门或业务主题划分
  - 与其他范围界限比较清晰，相互影响比较小
  - 范围大小要适度，实体控制在10个左右。
- 识别实体
  - 例如, 教学管理系统中的实体应包含系、教师、课程、学生。
- 定义属性
  - 属性是描述实体的特征和组成，也是分类的依据。

- 确定联系。对于识别出的实体，进行两两组合，判断实体之间是否存在联系，联系的类型是 1:1, 1:n, m:n

:::notes
需要注意的是, 实体和属性之间没有截然的划分，能作为属性对待的，尽量作为属性对待. 属性是不可再分的数据项，属性中不能包含其他属性；属性不能与其他实体有联系，联系是实体之间的联系。
:::

### 全局 ER 图

将所有的局部ER图集成起来，形成一个全局ER图

- 合并局部ER图，消除冲突
  - 属性冲突: 包括属性域冲突和属性取值单位冲突
  - 命名冲突: 实体名、属性名、联系名之间存在同名异义或异名同义的情况
  - 结构冲突: 实体 or 属性? 联系的类型? 属性的数量?
- 修改与重构ER图，消除冗余

## 逻辑结构设计
逻辑结构设计的任务就是将概念结构设计阶段产生的E-R图转化为选用的DBMS所支持的数据模型相符的逻辑结构，形成逻辑模型

- 逻辑数据模型
- 关系模型优化
- 外模式设计

### 概念模型转换为关系数据模型
- 实体的转换
  - 一般将E-R图中的一个实体转换为一个关系模式（表），实体的属性转换为关系的属性，实体的码转换为关系的主键。
- 联系的转换
  - 1:1, 1:n 联系: 在n端关系中加入1端关系的主键（作为其外键）
  - m:n 联系: 一个 m:n 的联系转换为一个关系模式，与该联系相连的两个实体的码以及联系本身的属性均转换成关系的属性，同时关系的主键为两个实体码的组合