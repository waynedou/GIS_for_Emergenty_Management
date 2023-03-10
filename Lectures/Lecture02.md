---
title: 应急管理与空间分析
subtitle: 计算机基础
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
    path: Slides/Lecture02.pdf
    pandoc_args: ["-F", "pandoc-crossref"]
  custom_document:
    pandoc_args: ["-F", "pandoc-crossref", "-t", "latex", "-V", "beamerarticle", "-s"]
    path: 'Handout/Lecture02__handout.pdf'

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes: 
    - 增加对计算机程序的直观认识
    - 程序和编程，类比菜肴和菜谱，解释为何称为“设计”
    - 计算机体系层次，类比司令员指挥作战到工兵挖战壕：战略目标->战术目标->战斗指挥->单兵
---

# 认识计算机

电子计算机

: 计算机是一种以电子器件为基础的，不需人的直接干预，能够对各种数字化信息进行快速算术和逻辑运算的工具，是一个由硬件、软件组成的复杂的自动化设备。

:::notes
更严格的说，我们现在使用的“电脑”是一种 *电子数字通用计算机* 。
:::

电子计算机是人类历史上发明的最伟大的工具。

- 和其他机器设备不同
    - 并非提高力量的运用，而是记忆、计算、逻辑判断和信息处理能力
- 清楚认识计算机的工具属性
    - 特别是在人工智能蓬勃发展的今天

## 计算机基本组成

计算机系统

- 硬件（hardware）系统：计算机系统中看得见、摸得着的物理设备
- 软件（software）系统：程序和相关数据
    - 系统软件
    - 应用软件

::: notes
硬件与软件二者相互依存，分工协作，缺一不可，硬件是计算机软件运行的物质基础，软件则为硬件完成预期功能提供智力支持。
:::

### 硬件系统基本组成 --- 冯·诺伊曼结构

![计算机硬件系统基本组成](assets/computer_arch.png){#fig:computer_arch width=80%}

<!-- ![冯·诺伊曼结构](assets/Von_Neumann_architecture.png) -->

:::notes
冯·诺伊曼结构（英语：Von Neumann architecture），也称冯·诺伊曼模型（Von Neumann model）或普林斯顿结构（Princeton architecture），是一种将程序指令存储器和数据存储器合并在一起的电脑设计概念结构。依本结构设计出的计算机又称存储程序计算机。
存储程序计算机在体系结构上主要特点有：

* 以运算单元为中心
* 采用存储程序原理
* 存储器是按地址访问、线性编址的空间
* 控制流由指令流产生
* 指令由操作码和地址码组成
* 数据以二进制编码

:::

### 计算机体系层次

<!-- ![](assets/comp_sys_hiarch.png) -->

<!-- :::{.columns align=center}
::: column

![计算机体系层次](assets/comp_sys_hiarch.png){#fig:comp_sys_hiarch width=40%}

:::

:::column

![大脑皮层](assets/cortex.png){#fig:cortex width=60%}

:::
::: -->

:::{.columns align=center}
:::{.column width="40%" }
![计算机体系层次](assets/comp_sys_hiarch.png){#fig:comp_sys_hiarch width=3cm}
:::
:::{.column width="60%"}
![大脑皮层](assets/cortex.png){#fig:cortex width=80%}

:::
:::

:::notes
\small

0层：着重体现实现计算机硬件的最重要的物质材料——电子线路，能直接处理离散的数字信号。解决的基本问题包括：使用何种器件存储信息，使用何种线路传送信息，使用何种器件运算与加工信息。

1层：为了执行指令而设置的各种功能部件（例如，存储、运算、输入输出等），每个部件如何组成和运行，部件间如何实现相互连接并协同工作。【计算机硬件系统通常由运算器部件、控制器部件、存储器部件、输入设备和输出设备5部分组成】

2层：介于软硬件之间，涉及确定提供哪些指令（包括指令能够处理的数据类型及可执行的运算，指令的格式和实现的功能），是计算机硬件实现的最基本和最重要的依据（指导硬件的运行），同时与计算机软件关系密切。

<!-- 【指令系统的设计 属于 计算机系统结构 范畴，合理选择电子元件和线路来实现每一条指令 则是 计算机组成 的主要任务】 -->

3层：计算机系统中最重要的系统软件。负责计算机系统中资源管理和分配，以及提供简单、高效、方便的服务（例如编程支持）。操作系统是依据指令系统提供的指令设计的程序。

4层：可看做是对计算机机器语言（即指令）符号化处理的结果，再增加一些为方便程序设计而实现的扩展功能。

5层：着重面向解决实际问题所用的算法，更多考虑如何方便程序设计人员和开发。通常需要经过编译程序编译成机器语言或汇编（再经过汇编程序得到机器语言）
\normalsize
:::



# 电路为什么能进行运算? --- 数字逻辑电路

- 开关状态对应逻辑真假
- 通过一系列开关状态的组合表达复杂的逻辑
- CPU 本质上就是一堆开关

## 逻辑门电路
### 电子开关 --- 继电器 
:::{.columns align=center}
:::{.column width="30%" }

![电磁继电器](assets/jdq.jpg)
:::
:::{.column width="60%"}

继电器原理就是利用电磁铁控制开关。继电器的一个很大用处在于可以通过电流控制而非人工控制。利用多个继电器可以实现多种逻辑门电路。实际上, 现代计算机中使用晶体管/CMOS等电子器件作为控制开关. 
:::
:::

<!-- ### 逻辑门 {.allowframebreaks} -->

### 逻辑与门

:::{.columns align=center}
:::{.column width="40%" }

| AND  | 0    | 1    |
| :--- | :--- | :--- |
| 0    | 0    | 0    |
| 1    | 0    | 1    |

<!-- 与门的简单符号： -->

![与门的电路符号](assets/yu.jpeg)
:::
:::{.column width="60%"}

两个继电器串联：

![与门](assets/yu_detail.jpeg){width=50%}

:::
:::

<!-- 只有当两个开关都关闭的时候，灯泡才能亮。这就是与门。 -->

### 逻辑或门

:::{.columns align=center}
:::{.column width="40%" }

| OR   | 0    | 1    |
| :--- | :--- | :--- |
| 0    | 0    | 1    |
| 1    | 1    | 1    |

![或门的电路符号](assets/huo.jpeg)
:::
:::{.column width="60%"}
两个继电器并联：

![继电器实现或门](assets/huo_detail.jpeg)

:::
:::

<!-- 关闭一个或者两个都能让灯泡变亮。这就是或门。 -->



### 逻辑非门

:::{.columns align=center}
:::{.column width="40%" }

| NOT   |     |
| :--- | :--- |
| 0    | 1    |
| 1    | 0    |

![非门的电路符号](assets/not.jpeg)
:::
:::{.column width="40%"}

![非门](assets/not_detail.jpeg)
:::
:::
<!-- 开关断开，灯泡亮；关闭开关后，灯泡就灭了。 -->



<!-- 这种继电器就是反向器。（反向器不是逻辑门，一个逻辑门通常有两个或多个输入）。 -->

### 其他门电路

:::{.columns align=center}
:::{.column width="30%" }
![或非门](assets/huofei.jpeg)

![与非门](assets/yufei.jpeg)

![异或门](assets/yihuo.jpeg)
:::
:::{.column width="60%"}

异或门 是 或门 器件并联 与非门 器件，再串联到 与门 器件

$$(A+B)(\bar A + \bar B) = (A+B) \overline{AB}$$

![异或门](assets/yihuo_detail.jpeg)
:::
:::


<!-- 
> 或非门

| NOR  | 0    | 1    |
| :--- | :--- | :--- |
| 0    | 1    | 0    |
| 1    | 0    | 0    |

两个开关均断开，灯泡亮。闭合任一个或者都闭合，灯泡灭。 这就是或非门。

![img](assets/huofei_detail.jpeg)

或非门的简单符号：或门加一个取反器标识

![img](assets/huofei.jpeg)

> 与非门

| NAND | 0    | 1    |
| :--- | :--- | :--- |
| 0    | 1    | 1    |
| 1    | 1    | 0    |

闭合一个或者都断开，灯泡亮；两个开关均闭合，灯泡灭。这就是与非门。

![img](assets/yufei_detail.jpeg)

与非门的简单符号：与门加一个取反器标识

![img](assets/yufei.jpeg)

还有一个异或门，我们在加法器中介绍。 -->

## 计算机的基础运算: 二进制加法 {.allowframebreaks}

### 1位二进制数相加
:::{.columns align=top}
:::{.column width="30%" }
> 1 bit 加法

| +    | 0    | 1    |
| :--- | :--- | :--- |
| 0    | 00   | 01   |
| 1    | 01   | 10   |

**把低位叫做加法位（sum bit），高位叫进位位(carry bit)**。

:::
:::{.column width="30%"}
> 进位位

| 进位位 | 0    | 1    |
| :----- | :--- | :--- |
| 0      | 0    | 0    |
| 1      | 0    | 1    |

与门实现

:::
:::{.column width="30%"}
> 加法位

| 加法位 | 0    | 1    |
| :----- | :--- | :--- |
| 0      | 0    | 1    |
| 1      | 1    | 0    |

异或门实现
:::
:::

### 半加器与全加器

:::{.columns align=center}
:::{.column width="40%" }
![半加器(Half Adder)](assets/halfadder.jpeg)

<!-- 这个被称作**半加器(Half Adder)**。

因为目前它还只是实现单个bit相加。如果多个bit相加，需要多个半加器连接。

> 全加器 -->

<!-- 如图是两个半加器相连组成的**全加器（Full Adder）**： -->

:::
:::{.column width="40%"}
![二进制加法](assets/bin_add.png)

:::
:::



![半加器构成全加器（Full Adder）](assets/fulladder_detail.jpeg){width=60%}

<!-- 半加器A中的加法位，和进位输入，连到半加器B。**最终的进位输出是利用或门**，这里比较有趣。这是因为两个半加器中的进位位不能同时为1。

半加器输出的进位位和加法位不会同时为1（只有输入A和输入B都是1，进位位才是1，并且此时加法位是0）。因此假设半加器A中的CO是1，那么S一定是0，这样半加器B的CO也只能是0，所以两个半加器中的CO同样不可能同时为1。**因此一个或门就可以表示最终的进位输出了~**

全加器的简单表示图： -->

### 加法器

![全加器的电路符号](assets/fulladder.jpeg){width=4cm}

<!-- 下面是8位的加法器，利用8个全加器实现如图： -->

![8 位加法器](assets/8fulladder.jpeg){width=60%}

同理, 两个8位加法器级联构成 16 位加法器。
<!-- 
好了，现在我们再来看看，实现一个8bit的加法器需要多少个继电器元件？

一个半加器需要一个加法位和进位位：加法位是异或门（或门、与非门、与门），需要`2*3=6`个继电器；进位位是一个与门，需要2个继电器。所以**一个半加器需要8个继电器元件**。一个全加器是两个半加器，就是16个，8bit的全加器就是`16*8=144`个继电器元件。 -->

# 计算机如何表达和存储数据？

- 数值：二进制
    - 定点数和浮点数
- 符号：字符编码
    - ASCII码
    - Unicode码

## ASCII

:::notes
ASCII(American Standard Code for Information Interchange,美国信息交换标准代码)是基于拉丁字母的一套计算机字符编码系统，主要用于显示现代英语。
:::

![1968年版ASCII编码速查表](assets/ASCII.png){#fig:ascii width=65%}

## 一切皆文件

- 冯·诺依曼结构中，程序和数据都存储在计算机系统中。
- 操作系统中的文件是一种抽象的机制，提供了一种在磁盘上保存信息而且方便以后读取的方法。
    - Linux 系统中，设备也是通过文件来进行访问的。
- 路径：在存储器中文件/目录的唯一位置
    - 绝对路径：以根目录为起点的路径，完整路径
    - 相对路径：以当前工作目录为起点的路径
- 文件名： `文件主名.文件扩展名`
    - 扩展名，又称后缀，提示文件的格式/类型
        - Windows中的可执行文件一般以`.exe`为后缀
        - *nix系统中可执行文件一般无后缀

### 路径

- 路径(path)是由一系列目录连接起来的，目录之间用路径分隔符进行分隔，*nix系统采用斜线(slash)`/`，Windows则使用反斜线(backslash)`\`
- 绝对路径和相对路径
    - *nix系统的根目录为`/`
    - Windows的最高层次为盘符+冒号，如`C:`表示C盘
- Powershell和*nix都支持波浪线(tilda)`~`表示home目录
- 两个特殊的目录：当前目录`.`和上一级目录`..`

:::notes
文件是对磁盘上信息存取的一种逻辑形式，而非物理形式。相比较而言，档案室中的一份文件，用订书针装订起来，或装在一个文件盒里，就是一种物理形式。

路径（path）是一种电脑文件或目录的名称的通用表现形式，它指向文件系统上的一个唯一位置。指向一个文件系统位置的路径通常采用以字符串表示的目录树分层结构，首个部分表示文件系统位置，之后以分隔字符分开的各部分路径表示各级目录，最后是该文件/文件夹。分隔字符最常采用斜线（/）、反斜线（\）或冒号（:）字符，不同操作系统与环境可能采用不同的字符。对一个文件来说，文件名是这个文件路径的最后一个部分。

一般来说，文件可分为文本文件、视频文件、音频文件、图像文件、可执行文件等多种类别，这是从文件的功能进行分类的。从数据存储的角度来说，所有的文件本质上都是一样的，都是由一个个字节组成的，归根到底都是 0、1 比特串。不同的文件呈现出不同的形态（有的是文本，有的是视频等等），这主要是文件的创建者和解释者（使用文件的软件）约定好了文件格式。
:::

<!-- 
#  进位制

在采用进位**计数**的数字系统中，如果只用N个基本符号表示数值，则称为**N进制**，N称为该数制的**基数**

- 包含 N 个符号的固定的符号集
    - 十进制: `0,1,2,3,4,5,6,7,8,9`
    - 二进制: `0,1`
    - 十六进制: `0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F`
- 位置表示法，即处于不同位置的数符所代表的值不同，与它所在位的**权值**有关。
    - 对于整数部分，从右往左看，第 $i$ 位的位权等于$N^{i}$. ^[整数部分最低位为第0位]
    - 对于小数部分，恰好相反，要从左往右看，第 j 位的位权为$N^{-j}$
    - **逢N进一**

## 基与权：向十进制转换

十进制的基为10，因此十进制数 1357 的值等于 
$$1 \times 10^3 + 3 \times 10^2 + 5 \times 10^1 + 7 \times 10^0 = 1357 \text{(DEC)}$$

八进制的基为8， 八进制的 1357 则等于 
$$1 \times 8^3 + 3 \times 8^2 + 5 \times 8^1 + 7 \times 8^0 = 751 \text{(DEC)}$$

对任意一个N进制数 $a_{i}a_{i-1} \ldots a_{0} . a_{-1} \ldots a_{-j}$，表示的数值为 $$a_{i} \times N^i + a_{i-1} \times N^{i-1} + \ldots + a_{0} \times N^0 + a_{-1} \times N^{-1} + \ldots + a_{-j} \times N^{-j}$$

## 任意进制之间转换
若一个整数$X$的$N$进制表示为 $a_{i} a_{i-1} \ldots a_{0}$， 则 

$$X = a_{i} \times N^i + a_{i-1} \times N^{i-1} + \ldots + a_{0} \times N^0$$

显然，除最后一项外其他项都可以被 $N$ 整除，所以用 $N$ 去除这个整数所得到的余数就是这个数在N进制表达下的 $a_{0}$，商为 $a_{i} \times N^{i-1} + a_{i-1} \times N^{i-2} + \ldots + a_{1} \times N^0$. 依据上面的规律，商除以$N$的余数即为$a_1$. 以此类推，就可以确定$X$在$N$进制下表示的各位的数值了。

**思考：**

* 小数如何转换？
* 二进制和八进制、十六进制如何相互转换？

## 二进制

以 2 为基的计数系统称为二进制。每个数字(digit)称为一个*位*或*比特*（Bit，Binary digit 的缩写）

![十进制-二进制对照](assets/dec_bin.png)

### 二进制算术运算

![二进制加法](assets/binary_add.png){#fig:bin_add height=30%}

![二进制减法](assets/binary_sub.png){#fig:bin_sub height=30%}

:::notes
对于算术运算，任何进制列竖式计算的方法都是一样的。
二进制数的乘法和除法也是一样。但以乘法来看，由于二进制只有0和1，所以分解到每一位相乘的时候无需做实际的乘法，只要判断乘数是0还是1就可以了，也就是说，二进制数相乘不需要乘法，只需要移位和相加两种运算。
::: -->

### 计算机存储单位

位（bit）是最小的信息计量单位。
字节（Byte）是计算机中常用的信息计量单位，也是内存模型中的基本存储单位。一个字节代表八个比特。

* 1KB = 1,000 B 或 1,024 B
* 1MB = 1,000 KB 或 1,024 KB
* 1GB = 1,000 MB 或 1,024 MB
* 1TB = 1,000 GB 或 1,024 GB
* 1PB = 1,000 TB 或 1,024 TB

:::notes
信息传输速率通常使用的波特率是对符号传输速率的一种度量，单位为bps (bit per second)。例如通常所说的100M宽带，指波特率为100Mbps. 而在计算机中使用的传输速率往往是Bps(Byte per second)，例如10M/s的下载速度是指每秒下载10MB数据。因此100Mbps宽带的最大下载速度为12.5MBps.
:::


# 操作系统与软件

- 什么是操作系统？操作系统有什么作用？
- Windows 和 Linux 有什么不同？
- Linux 发行版本是什么？

## 起源

- 计算机是一个计算机器，可以按顺序执行一系列运算操作。系统管理工具以及简化硬件操作流程的程序就是最基本的操作系统。
- 批处理系统：自动化调度和运行系列程序的作业。
- 分时处理：将运行时间分割成多个时间段分配给多个用户、多个任务，实现计算资源共享。

:::notes
我国港台地区将 Operating System 翻译为“作业系统”，就是侧重于表现操作系统的调度功能。
:::

## 核与壳

![操作系统层次体系](assets/OS_Layers.jpg){#fig:os_layers width=60%}

### 内核

内核（Kernel，又称核心）是用来管理软件发出的输入与输出请求的程序，提供设备驱动、文件系统、进程管理、网络通信等功能。

- 将系统请求翻译为指令交由中央处理器（CPU）及其他电子组件进行处理；
- 为应用程序提供对计算机硬件的安全访问；
- 控制一个程序/进程使用硬件资源的时间和时机，以及进程间的通讯等；
- 狭义的操作系统专指内核，如Linux.
- 内核不提供和用户的交互功能。

:::notes
什么叫“对硬件的安全访问”呢？我们可以用七段式数字显示器来类比。七段式数字显示器是由七个灯管组成，如果每个灯管对应一个开关，则可以有128种组合，实际使用的合法组合只有10种。如果开关并不直接控制灯管，而是在开关和灯管之间存在某种装置，可以使得不合法的开关组合都不起作用，那么这种装置就是提供了*安全访问*。
:::

### 外壳
外壳（Shell）是指操作系统中提供访问内核所提供之服务的程序，为用户提供用户界面进行交互。

- shell是一个命令解释器，处于内核和用户之间，负责把用户的指令传递给内核并且把执行结果回显给用户.
- 狭义的shell 通常指的是**命令行界面**（Command Line Interface, **CLI**）的解析器
    - 可以作为一门强大的编程语言
- 广义的 shell 也包括**图形用户界面**(Graphic User Interface, **GUI**)

:::notes
Linux的Shell种类众多，常见的有：

- Bourne Shell（/usr/bin/sh或/bin/sh）
- Bourne Again Shell（/bin/bash）
- C Shell（/usr/bin/csh）
- K Shell（/usr/bin/ksh）
- Shell for Root（/sbin/sh）
:::

## 命令行

- 命令行界面(Command Line Interface, CLI)是在图形用户界面得到普及之前使用最为广泛的用户界面，它通常不支持鼠标，用户通过键盘输入指令，计算机接收到指令后，予以执行。也有人称之为字符用户界面（character user interface, CUI）。
- 一般来说服务器都不配备GUI以节省资源，在某些特定情况下（如操作系统故障）也只能使用CLI. 



## 程序与计算机语言

- 计算机程序是机器指令的有序集合，可以完成一定的任务
    - 机器指令是计算机的设计者通过计算机的硬件结构赋予计算机的操作功能
    - 指令以二进制形式表示
    - 一条指令包含操作码、操作对象等信息
- 执行程序的过程就是逐条执行指令的过程
- 计算机语言是人与计算机交流信息的工具
    - 机器语言
    - 汇编语言
    - 高级语言

:::notes
机器语言是用二进制代码表示的计算机能直接识别和执行的一种机器指令的集合，因此也紧密依赖于硬件，程序可移植性差。计算机发展早期只能使用机器语言编写程序，编程人员要熟记所用计算机的全部指令代码和代码的涵义，处理每条指令和每一数据的存储分配和输入输出，并且记住编程过程中每步所使用的工作单元处在何种状态，开发难度非常大。

汇编语言是一种用于电子计算机、微处理器、微控制器或其他可编程器件的低级语言，亦称为符号语言。在汇编语言中，用助记符代替机器指令的操作码，用地址符号或标号代替指令或操作数的地址。在不同的设备中，汇编语言对应着不同的机器语言指令集，通过汇编过程转换成机器指令。普遍地说，特定的汇编语言和特定的机器语言指令集是一一对应的,不同平台之间不可直接移植。汇编语言实际上就是用简短的英文缩写来表示机器语言中的相应指令。由汇编器和链接器处理后，汇编语言就被翻译为机器语言，可由机器来执行。虽然只做了简单的抽象，这已经大大提高了程序的可读性。

高级语言是相对于机器语言、汇编语言而言的，它是较接近自然语言和数学公式的编程，基本脱离了机器的硬件系统，用人们更易理解的方式编写程序。高级编程语言的语言结构和计算机本身的硬件以及指令系统无关，它的可阅读性更强，能够方便的描述算法，实现程序的功能。高级语言为大规模软件开发提供了可能。
:::

# 计算机发展历程

## 第一台电子计算机

1946年在美国宾夕法尼亚大学研制成功世界上第一台真正的全自动电子数字式计算机 ENIAC（Electronic Numerical Integrator and Computer）

- 共用了18000多个电子管
- 占地约 170 m$^2$
- 总重量约为30吨
- 耗电量超过140kw
- 每秒能做5000次加减运算．

:::notes
笨重的蒸汽机开启了工业时代，笨重的电子管计算机开启了信息时代。

1947年，著名的贝尔实验室成功地研制了晶体管。自此，电子学的研究方向从真空管转向到了固态电子器件。

像计算机主板这样复杂的电路，往往对于响应速度有较高的要求。如果计算机的组件过于庞大，或者不同组件之间的导线太长，电信号就不能够在电路中以足够快的速度传播，这样会造成计算机工作缓慢，效率低下，甚至引起逻辑错误。

1958年，德州仪器的杰克·基尔比找到了上述问题的解决方案。他提出，可以把电路中的所有组件和芯片用同一半导体材料块制成。1958年9月，第一个集成电路研制成功。

集成电路在电子学史上是个重要的创新。通过在同一材料块上集成所有组件，并通过上方的金属化层连接各个部分，就不再需要分立的独立组件了，避免了手工组装组件、导线的步骤。此外，电路的特征尺寸大大降低。

小规模集成电路（Small Scale Integration, SSI）时代始于1960年代早期，后来历经中规模集成电路（Medium Scale Integration, MSI，1960年晚期）、大规模集成电路和超大规模集成电路（1980年早期）。超大规模集成电路的晶体管数量可以达到10,000个（现在已经高达1,000,000个）。
:::

## 摩尔定律

摩尔定律（Moore's law）

- 英特尔（Intel）创始人之一戈登·摩尔提出的经验规律
- 其内容为：集成电路上可容纳的晶体管数目，约每隔两年便会增加一倍
- 经常被引用的“18个月”，则是由英特尔首席执行官大卫·豪斯（David House）提出

![晶体管数量与引入日期的图表。根据摩尔定律，曲线显示每两年增加一倍。](assets/transCount.png){width=60%}

## 发展阶段

#### 第一代：第一台计算机ENIAC问世 --- 50年代末

\only<+>{

- 使用电子管作为电子器件
    - 计算机体积大，运算速度低，存储容量小
- 使用机器语言与汇编语言编制程序
    - 编制程序很复杂，主要被用于科学计算．
}


#### 第二代：从20世纪50年代末 --- 60年代初

\only<+>{

- 使用晶体管
    - 体积大大减小，运算速度加快，存储容量提高
- 开始使用计算机高级语言，降低了学习和使用的难度．
    - 开始用于数据处理和事务处理，并逐渐用于工业控制．

}

#### 第三代：20世纪60年代中期 --- 70年代初

\only<+>{

- 中、小规模集成电路（MSI, SSI）
- 小型化、微型化
- 操作系统
- 文字处理、管理信息系统．
}

#### 第四代：20世纪70年代 --- 20世纪90年代初
\only<+>{

- 大规模与超大规模集成电路（LSI, VLSI）
    - 性能大幅度的提高
- 应用软件也越来越丰富，应用涉及到国民经济的各个领域
- 微型计算机飞速发展
}

#### 第五代：20世纪90年代至今
\only<+>{

- 甚大规模集成电路（ULSI）
- 全面普及，广泛应用．
}

# 南太平洋小岛上的神秘仪式 --- 一点建议

:::notes
物理顽童费曼（Richard Feynman）在他的自传《别闹了，费曼先生》中讲过一个故事。

> 二战结束后，南太平洋某地土著中出现了一种奇特的仪式。他们在废弃的美军机场旁盖了间小茅屋，屋顶插着几根竹子，还有人坐在屋里，头上绑着两块木头。大概还会有人手举小旗在机场上跑来跑去，不停地仰望蓝天。这个场面一定让人类学家感到兴奋，而谜底却让人啼笑皆非。他们是在等待飞机。他们在战时看惯了美军飞机降落的场景，也常能分到机舱里卸下的东西。美军撤离后，这些好处便再也没有了。于是他们用木块来模拟耳机，用竹竿来模拟天线，重复他们所观察到的美军的操作过程，期待轰隆隆的飞机从天而降。

<!-- 飞机当然是不会来的。但是他们相信，如果飞机不来，那是因为他们模拟得不够像。他们之中的聪明人就会提出改进的方案。不过我想我们都会同意，即使把真的天线和耳机给他们装备上，飞机还是不会来。 -->

直到今天，仍然有一些小岛上的岛民们还在信奉着这样的宗教。其中比较有名的是在一个叫做塔纳（Tanna）岛上一个名为“John Frum”的宗教。
:::

:::columns
:::column

![木头做的枪支模型](https://pic1.zhimg.com/80/v2-6224f98fae69b4697bbe6524e052fc94_1440w.jpg){width=60%}

![正在模仿美国大兵行军的岛民们](https://pic4.zhimg.com/80/v2-aa6fe7eab2f8e68b5f85af2d96cd5fdb_1440w.jpg){width=60%}

:::
:::column

![岛民用木头扎的飞机](https://pic2.zhimg.com/v2-5e65aae3fda6a304bd6c95a4489d8e85_r.jpg){width=60%}

<!-- *如果不试图理解计算机语言背后的逻辑，而只是简单的“模拟”教材，其结果往往是把程序设计工作神秘化。* -->
:::
:::

