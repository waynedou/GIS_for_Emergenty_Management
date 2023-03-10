---
title: 应急管理与空间分析
subtitle: 认识数据库
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
        path: Slides/Lecture12.pdf
        pandoc_args: ["-F", "pandoc-crossref"]
      # pandoc_args: ["-d", "beamerslide"]

    custom_document:
        pandoc_args: ["-t", "latex", "-V", "beamerarticle", "-s"]
        path: Handout/Lecture12_handout.pdf

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes:
---

# 数据存储/组织的基本方式

- 文件
    - 计算机对存储在外部存储器上的二进制数据的逻辑组织方式
    - 文本文件
    - 二进制文件
- 数据库
    - 数据的集合
    - 功能/性能要求
        - CRUD(增删改查)
        - 共享、安全等

:::notes
两种基本方式，也是数据管理的两个历史阶段，跟随计算机的发展。
:::

# 基于文件系统的数据管理

* 数据以文件形式长期保存，由文件系统负责管理

:::notes 
数据以文件的组织方式，长期保存在计算机的磁盘上，可以被多次反复使用。数据文件是数据记录的集合，应用程序可对文件进行查询、修改和增删等处理。

文件系统提供了文件管理功能和文件的存取方法。文件系统把数据组织成具有一定结构的记录，并以文件的形式存储在存储设备上。
:::

* 程序与数据间有一定设备独立性，但物理模式独立性仍较低

:::notes
由于文件系统在程序与数据文件之间的存取转换作用，使得程序和数据之间具有“设备独立性”，即当改变存储设备时，不必改变应用程序。程序员也不必过多地考虑数据存储的物理细节，而将精力集中于算法设计上，从而大大减少了维护程序的工作量。

以硬盘为例，物理结构和逻辑结构

程序只与存储设备上的文件名打交道，不必关心数据的物理存储（扇区、磁道、读写头表示的存储位置、物理结构等），而由文件系统提供的存取方法实现数据的存取，从而实现了“按文件名访问，按记录进行存取”的数据管理技术。

文件的抽象级别低，底层数据结构变化对文件和程序影响严重，未能彻底体现用户观点下的数据逻辑结构独立于数据在外部存储器的物理结构要求。因此，在文件系统中，一旦改变数据的逻辑结构，必须修改相应的应用程序，修改文件结构的定义。而应用程序发生变化，如改用另一种程序设计语言来编写程序，也将引起文件的数据结构的改变。
:::

* 文件的形式多样化，不同文件之间的数据联系由程序依据文件格式和应用目的构造。数据具有一定的共享性，但不能同时访问
    - 通用的文件格式：CSV, XLS, JSON, XML
    - 特定标准的文件格式：CAD, MAT, Shapefile


:::notes
由于有了磁盘这样的数据存取设备，文件也就不再局限于顺序文件，有了索引文件、链表文件等。因此，对文件的访问方式既可以是顺序访问，也可以是直接访问。但文件之间是独立的，它们之间的联系需要通过程序去构造，文件的共享性也比较差。文件系统只是一个没有弹性的、无结构的数据集合，不能反映现实世界事物之间的内在联系。
:::

<!-- :::notes
有了文件以后，数据就不再仅仅属于某个特定的程序，而可以由多个程序反复使用。但文件结构仍然是基于特定用途的，程序仍然是基于特定的物理结构和存取方法编制的。因此，数据的存储结构和程序之间的依赖关系并未根本改变。
::: -->

* 数据冗余度大
    - 相同数据在不同文件中的重复存储、各自管理
        - 团队共同编辑修改文档
    - 数据不一致性

:::notes
这通常是由数据冗余造成的。由于相同数据在不同文件中的重复存储、各自管理，在对数据进行更新操作时，不但浪费磁盘空间，同时也容易造成数据的不一致性。
:::

# 基于数据库的数据管理

计算机技术的发展、数据管理的需求迫切性共同促进了数据库技术的诞生。

:::notes
20世纪60年代末期出现的对数据管理技术有着奠基作用的三件大事，标志着以数据库管理系统为基本手段的数据管理新阶段的开始。
:::

- 1968年，美国IBM公司推出了商品化的信息管理系统（Information Management System， IMS）。
- 1969年，美国数据系统语言协会（Conference On Data System Language，CODASYL）下属的数据库任务组（Data Base Task Group，DBTG）发布了一系列研究数据库方法的DBTG报告，建立了数据库技术的很多概念、方法和技术。
- 1970年起，美国IBM公司的研究员E. F. Codd连续发表文章，开创了数据库关系方法和关系数据理论的研究，为关系数据库的发展和理论研究奠定了基础，该模型一直沿用至今。

## 数据库与数据库管理系统

- 数据库（Data Base，DB）
    - 数据的集合
    - 模型、方法
    - 集中、分布
- 数据库管理系统（Data Base Management System，DBMS）
    - 软件系统
    - 支持查询语言

:::notes
数据库（Data Base，DB）是存储在计算机内、有组织的、可共享的数据和数据对象（如表、视图、存储过程和触发器等）的集合，这种集合按一定的数据模型（或结构）组织、描述并长期存储，同时能以安全和可靠的方法进行数据的检索和存储。

计算机科学解决问题的法宝是抽象。通过增加抽象层，将问题分解为复杂度较低的子问题。

文件系统的数据管理方法已无法适应各种应用的需要。于是为解决多用户、多个应用程序共享数据的需求，数据库技术应运而生，出现了统一管理数据的专门软件系统，即数据库管理系统（Data Base Management System，DBMS）。
:::

## 数据库模型

- 层次模型
- 网状模型
- **关系模型**
- 面向对象模型
- 对象-关系模型

## 数据库事务

事务（transaction）包含一组数据库操作的逻辑工作单元。事务的ACID特性：

- 原子性（atomicity）
    - 在事务中包含的数据库操作是不可分割的整体，这些操作要么一起做，要么一起回滚（Roll Back）到执行前的状态
- 一致性（consistency）
    - 遵守数据库的完整性约束
- 隔离性（isolation）
    - 即使事务是并发执行的，执行效果也必须和串行执行一样
- 持续性（durability）
    - 已提交的事务对数据库的影响必须永久保持

:::notes
事务的并发性是指多个事务的并行操作轮流交叉运行，事务的并发可能会访问和存储不正确的数据，破坏交易的隔离性和数据库的一致性。
:::

## 数据库的特点

- 通用的数据模型
    - 关系模型

:::notes
结构化的数据及其联系的集合。在数据库系统中，将各种应用的数据按一定的结构形式（即数据模型）组织到一个结构化的数据库中，不仅考虑了某个应用的数据结构，而且考虑了整个组织（即多个应用）的数据结构，也就是说，数据库中的数据不再仅仅针对某个应用，而是面向全组织，不仅数据内部是结构化的，整体也是结构化的；不仅描述了数据本身，也描述了数据间的有机联系，从而较好地反映了现实世界事物间的自然联系。

此外，在数据库系统中，不仅数据是结构化的，而且存取数据的方式也很灵活，可以存取数据库中的某一个数据项、一组数据项、一个记录或一组记录。而在文件系统中，数据的最小存取单位是记录，不能细化到数据项。
:::

- 数据共享性高、冗余度低
  - 数据共享是指数据库中的一组数据集合可为多个应用和多个用户（同时）共同使用。

:::notes
由于数据库系统从整体角度看待和描述数据，数据不再面向某个或某些应用，而是全盘考虑所有用户的数据需求，面向整个应用系统，所有用户的数据都包含在数据库中。因此，不同用户、不同应用可同时存取数据库中的数据，每个用户或应用只使用数据库中的一部分数据，同一数据可供多个用户或应用共享，从而减少了不必要的数据冗余，节约了存储空间，同时也避免了数据之间的不相容性与不一致性，即避免了同一数据在数据库中重复出现且具有不同值的现象。
同时，在数据库系统中，用户和程序不像在文件系统中那样各自建立自己对应的数据文件，而是从数据库中存取其中的数据子集。该数据子集是通过数据库管理系统从数据库中经过映射而形成的逻辑文件。同一个数据可能在物理存储上只存一次，但可以把它映射到不同的逻辑文件里，这就是数据库系统提高数据共享、减少数据冗余的根本所在。
:::
<!-- 
（3）数据独立性高。所谓数据的独立性是指数据库中的数据与应用程序间相互独立，即数据的逻辑结构、存储结构以及存取方式的改变不影响应用程序。
在数据库系统中，整个数据库的结构可分成三级：用户逻辑结构、数据库逻辑结构和物理结构。数据独立性分为两级：物理独立性和逻辑独立性，如图1-5所示。
数据的物理独立性是指当数据库物理结构（如存储结构、存取方式、外部存储设备等）改变时，通过修改映射，使数据库逻辑结构不受影响，进而用户逻辑结构以及应用程序不用改变。例如，在更换程序运行的硬盘时，数据库管理系统会根据不同硬件，调整数据库逻辑结构到数据库物理结构的映射，保持数据库逻辑结构不发生改变，因此用户逻辑结构无需改变。
[插图]
图1-5 数据库的三级结构及其映射关系示意图
数据的逻辑独立性是指当数据库逻辑结构（如修改数据定义、增加新的数据类型、改变数据间的关系等）发生改变时，通过修改映射，用户逻辑结构以及应用程序不用改变。例如，在修改数据库中数据的内容时，数据库管理系统会根据调整后的数据库逻辑结构，调整用户逻辑结构到数据库逻辑结构的映射，保持用户逻辑结构访问的数据逻辑不改变，因此用户逻辑结构无需改变。
数据独立性把数据的定义从程序中分离出去，加上数据的存取是由DBMS负责，从而简化了应用程序的编写，大大减轻了应用程序的维护和修改的代价。
（4）有统一的数据管理和控制功能。在数据库系统中，数据由数据库管理系统进行统一管理和控制。数据库可为多个用户和应用程序所共享，不同的应用需求可以从整个数据库中选取所需要的数据子集。另外，对数据库中数据的存取往往是并发的，即多个用户可以同时存取数据库中的数据，甚至可以同时存取数据库中的同一个数据。为确保数据库数据的正确、有效和数据库系统的有效运行，数据库管理系统提供下述4个方面的数据控制功能。 -->

## 数据库系统的组成
<!-- 数据库系统（Data Base System，DBS）是指在计算机系统中引入数据库后的系统。它主要由数据库、数据库用户、计算机硬件系统和计算机软件系统等几部分组成。有时人们将数据库系统简称为数据库，它可用图1-7表示。
1.数据库
数据库（Data Base，DB）是存储在计算机内、有组织的、可共享的数据和数据对象（如表、视图、存储过程和触发器等）的集合，这种集合按一定的数据模型（或结构）组织、描述并长期存储，同时能以安全和可靠的方法进行数据的检索和存储。 -->

![数据库系统的组成](assets/db_arch.png){width=50%}

:::notes
用户是指使用数据库的人，他们可对数据库进行存储、维护和检索等操作。用户分为以下三类。

（1）第一类用户：即最终用户（End User）。最终用户主要是使用数据库的各级管理人员、工程技术人员和科研人员，一般为非计算机专业人员。他们主要利用已编写好的应用程序接口使用数据库。

（2）第二类用户：即应用程序员（Application Programmer）。应用程序员负责为最终用户设计和编写应用程序，并进行调试和安装，以便最终用户利用应用程序对数据库进行存取操作。

（3）第三类用户：即数据库管理员（Data Base Administrator，DBA）。数据库管理员是负责设计、建立、管理和维护数据库以及协调用户对数据库要求的个人或工作团队。DBA应熟悉计算机的软硬件系统，具有较全面的数据处理知识，熟悉最终用户的业务、数据及其流程。
:::

- - -

![数据库在计算机系统中的位置](assets/db_os.png){width=50%}

## 数据库系统模式
<!-- 1.数据库系统模式的概念
数据库中的数据是按一定的数据模型（结构）组织起来的，而在数据模型中有“型”（Type）和“值”（Value）的概念。“型”是指对某一类数据的结构和属性的说明，而“值”是“型”的一个具体赋值。例如，在描述学生基本情况的信息时，学生基本情况可以定义为（学号，姓名，性别，年龄，系别），称为学生的型，而（001101，张立，男，20，计算机）则是某一学生的具体数据。 -->

- 模式（Schema，或称架构）是数据库中全体数据的逻辑结构和特征的描述，它仅涉及型的描述，而不涉及具体的值。
- 模式的一个具体值称为模式的一个实例（Instance）。同一个模式可以有很多实例。
- 模式反映的是数据的结构，而实例反映的是数据库某一时刻的状态。

<!-- 例如，描述学生基本情况的数据库中，包含了学生的基本情况，则2012级和2013级的所有学生的基本情况就形成了两个年级学生基本情况的数据库实例。显然，这两个实例的模式是相同的，都是学生基本情况，相关的型都是（学号，姓名，性别，年龄，系别）；但两个实例的数据是不同的，因为2012级学生的基本情况信息与2013级学生的基本情况信息肯定是不相同的。同时，当学生在学习过程中出现转系、退学等情况时，以上两个实例可能随时发生变化，但它们的模式不变。 -->

### 数据库系统的三级模式结构

- 美国国家标准学会（American National Standards Institute，ANSI）所属标准计划和要求委员会在1975年公布的研究报告中，把数据库系统内部的体系结构从逻辑上分为外模式、模式和内模式三级抽象模式结构和二级映像功能，即ANSI/SPARC体系结构。
- 对用户而言，外模式、模式和内模式分别对应一般用户模式、概念模式和物理模式. 它们分别反映了看待数据库的三个角度. 

- - -

![数据库系统的三级模式结构](assets/db_3layer_schema.png){width=30%}

:::notes
（1）模式。模式也称为概念模式，是数据库中全体数据的逻辑结构和特征的描述，处于三级模式结构的中间层，不涉及数据的物理存储细节和硬件环境，与具体的应用程序、所使用的应用开发工具及高级程序设计语言（如C、FORTRAN等）无关。
一个数据库只有一个模式，因为它是整个数据库数据在逻辑上的视图，即是数据库的整体逻辑。也可以认为，模式是对现实世界的一个抽象，是将现实世界某个应用环境（企业或单位）的所有信息按用户需求而形成的一个逻辑整体。

（2）外模式。外模式（External Schema）又称为子模式（Subschema）或用户模式（User Schema），外模式是三级结构的最外层，是数据库用户能看到并允许使用的那部分数据的逻辑结构和特征的描述，是与某一应用有关的数据的逻辑表示，也是数据库用户的数据视图，即用户视图。

（3）内模式。内模式（Internal Schema）又称存储模式（Storage Schema）或物理模式（Physical Schema），是三级结构中的最内层，也是靠近物理存储的一层，即与实际存储数据方式有关的一层。它是对数据库存储结构的描述，是数据在数据库内部的表示方式。例如，记录以什么存储方式存储（顺序存储、B+树存储等）、索引按照什么方式组织、数据是否压缩、是否加密等，它不涉及任何存储设备的特定约束，如磁盘磁道容量和物理块大小等。
:::

<!-- 可见，外模式一般是模式的子集，一个数据库可以有多个外模式。由于不同用户的需求可能不同，因此，不同用户对应的外模式的描述也可能不同。另外，同一外模式也可以为多个应用系统所使用。
因此，各个用户可根据系统所给的外模式，用查询语言或应用程序去操作数据库中所需要的那部分数据，这样每个用户只能看到和访问所对应的外模式中的数据，数据库中的其余数据对他们来说是不可见的。所以，外模式是保证数据库安全性的一个有力措施。

通过对数据库三级模式结构的分析可以看出，一个数据库系统，实际存在的只是物理级数据库，即内模式，它是数据访问的基础。概念数据库只不过是物理级数据库的一种抽象描述，用户级数据库是用户与数据库的接口。用户根据外模式进行的操作，通过外模式到模式的映射与概念级数据库联系起来，又通过模式到内模式的映射与物理级数据库联系起来。事实上，DBMS的中心工作之一就是完成三级数据库模式间的转换，把用户对数据库的操作转化到物理级去执行。
在数据库系统中，外模式可有多个，而模式、内模式只能各有一个。内模式是整个数据库实际存储的表示，而模式是整个数据库实际存储的抽象表示，外模式是逻辑模式的某一部分的抽象表示。 -->

# 一个（拙劣的）类比 {.allowframebreaks}

#### 有一个小餐馆。。。

有一个小餐馆，菜品和价格每天都发生变化。

健忘的老板（owner）只准备了一份表格式的菜单（file），以方便随时修改。

顾客（client）点餐后老板根据菜单上的价格进行结算。

这个方法有个缺点，就是一个顾客看（read）菜单时是独占这份菜单的，此时其他顾客想看菜单，或是老板要修改（write）菜单，都只能等这位顾客交回菜单；同样的，老板在修改菜单时，其他人也没法拿到菜单。

这样的效率很低，但至少餐馆还算正常运转。

#### 但是。。。

日子久了就出问题了。

有爱贪便宜的顾客在独占菜单期间私自修改菜单上的菜品价格，小餐馆损失很大。

老板此时很为难：放任下去迟早倒闭，但如果把菜单塑封起来防止客人修改，自己也没法修改了。老板为此很苦恼。

#### 忠诚的服务员

这时一个既稳重又忠心的服务员（server）提出了一个解决方案：菜单由他一人来保管，客人点餐时向他询问（query）菜品及价格；老板需要修改菜单时也向他提出要求（request），由他来修改菜品及价格。

这样一来，问题就得到了解决：除了服务员其他所有人都不直接接触菜单，客人想知道什么就问服务员，服务员都可以告诉他，但是修改菜单的要求就别指望服务员会答应了；老板对这个老伙计很信任，有什么事交代给他跟自己亲力亲为是一样的；而且大家不用再等着拿菜单，有什么事随时招呼服务员。所以不但解决了问题，还提高了效率。

服务员发现老板原来的菜单记录的方式不太合理，查找或者修改效率很低，于是服务员就按照自己的习惯制作了一个新的模板（schema），还编写了一个目录（index），效率进一步得到提高。

在这一过程中，老板和顾客都没有发觉菜单的记录方式发生了改变，只是感觉到速度提高了。

#### 又过了一段时间。。。

老板发现店里客人增加了不少。他感觉很纳闷：后厨并没有什么变化，为什么客人会变多了呢？

这时刚好有一个最近才开始经常来店里吃饭的客人要结账。老板热情地招呼他，问他好不好吃，客人说很好吃。老板就问他为什么以前不来吃呢？客人不好意思地说：我不识字，看不懂菜单，所以以前一个人来就没法点菜。

老板恍然大悟：虽然还是那些信息，但是客人获取的方式不同了，更好理解了。

#### 就这样。。。

生意越来越好，备选的菜品也越来越多，菜单的修改靠老板一个人也忙不过来，于是老板就交待服务员：以后老板娘和厨师们也可以来修改菜单，但是厨师只能修改菜品，老板娘只能修改价格。因为有好几个厨师，各自负责不同类型的菜，所以每个厨师也只允许修改他所负责的那个类型的菜品。

这下老板总算轻松了。


# SQL基础



:::{.columns align=center}
:::{.column width="40%" }
SQL (Structured Query Language: 结构化查询语言) 是用于管理关系数据库管理系统（RDBMS）的计算机语言

* DDL – Data Definition Language
* DQl – Data Query Language
* DML – Data Manipulation Language
* DCL – Data Control Language

:::
:::{.column width="60%"}
![](assets/sql_category.png){height=8cm}

:::
:::

<!-- ## PostGreSQL

- 文件操作和数据库操作
    - 人 -> 应用程序（excel）-> 文件（xxx.xls）
    - 人 -> 客户端程序（psql）-> 服务器进程（postgres） -> 数据文件（xxx.001）
        - 指令明确（SQL命令，数据库登录时的各种输入等，程序员买包子）
- 计算机硬件 -> kernel -> shell (terminal) -> 操作系统
    - 简单的shell命令演示
    - shell命令（createdb）是操作计算机
    - SQL命令操作数据库 -->

# 基本SQL命令

- `SELECT` - 从数据库中提取数据
- `UPDATE` - 更新数据库中的数据
- `DELETE` - 从数据库中删除数据
- `INSERT INTO` - 向数据库中插入新数据
- `CREATE DATABASE` - 创建新数据库
- `ALTER DATABASE` - 修改数据库
- `CREATE TABLE` - 创建新表
- `ALTER TABLE` - 变更（改变）数据库表
- `DROP TABLE` - 删除表
- `CREATE INDEX` - 创建索引（搜索键）
- `DROP INDEX` - 删除索引

## `SELECT`语句

- 典型的查询语句结构
- QGIS 的 `Database Manager` 中可使用 `SQL Query Builder` 辅助编写 SQL 查询.

#### 查询所有可用于军事的机场
```sql
-- qgis-sample-data.gpkg
SELECT name, fk_region, use -- 选择查询结果的字段
FROM airports -- 查询的表
WHERE use Like('%Military%');-- 查询条件
                         -- 分号表示查询结束
ORDER BY name;
```

### 表连接

#### 查询所有机场所在的地区
```sql
SELECT a.name, r.name_2, a.use
FROM airports a
JOIN regions r on (a.fk_region = r.id)
WHERE a.use Like('%Military%');
ORDER BY a.name;
```

#### 利用`where`子句进行表连接
```sql
SELECT a.name, r.name_2, a.use
FROM airports a, regions r
WHERE a.use Like('%Military%') 
  AND a.fk_region = r.id;
```

### 聚合统计

#### 统计每个地区的机场数量
```sql
SELECT r.name_2, 
    count(a.name) as airports_counts -- 设置别名
FROM airports a, regions r
WHERE a.fk_region = r.id
GROUP BY r.name_2;
```

---

#### 查询机场数量最多的三个地区
```sql
SELECT r.name_2, count(a.name) as airports_counts
FROM airports a, regions r
WHERE a.fk_region = r.id
GROUP BY r.name_2
ORDER BY airports_counts DESC
LIMIT 3;
```