---
title: 应急管理与空间分析
subtitle: 数据与文件
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
    path: Slides/Lecture03.pdf
    pandoc_args: ["-F", "pandoc-crossref"]
  custom_document:
    pandoc_args: ["-F", "pandoc-crossref", "-t", "latex", "-V", "beamerarticle", "-s"]
    path: 'Handout/Lecture03_handout.pdf'

figureTitle: "图"
tableTitle: "表"
figPrefix: "图"
eqnPrefix: "公式"
tblPrefix: "表"
loftitle: "图"
lotTitle: "表"

notes: 
    - 
---
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
:::


# 文件的类型划分

## 可执行文件 vs 数据文件

所有文件都是二进制方式表达的

- 可执行文件可以使计算机根据编码指令执行指定的任务
    - **指令**通常是指以二进制编码的微处理器指令
    - 依赖于CPU类型和操作系统
        - Windows程序不能直接在Linux中运行
- 数据文件中二进制串的含义必须由特定的程序进行解释
    - Windows中创建的word文档也可以在macOS中用 MS Word 打开

:::notes
在shell中可以通过文件名来运行一个可执行文件，但是不能运行不可执行文件。C++程序源代码`.cpp`文件是文本文件，所以不能执行。

文件路径可以采用绝对路径或相对路径，也可以通过设置`PATH`环境变量直接用文件名来启动程序，启动程序时操作系统会在`PATH`设定的所有路径中按文件名搜索，并执行找到的第一个程序。

启动程序就是shell通知内核要运行一个程序，然后内核将程序的内容（微处理器指令）载入到内存中，由CPU逐条执行。
:::

## 文本文件 vs 二进制文件
- 文本文件是 **基于字符** 编码的文件
    - 常见的编码有ASCII编码，UNICODE编码等等
    - 可以用记事本打开
    - `.txt`, `.cpp`, $\ldots$
- 二进制文件是 **基于值** 编码的文件，可以根据具体应用，指定某个值是什么意思. ^[此处主要是对数据文件的区分，实际上有时二进制文件专指可执行文件，\*nix系统中常把可执行文件存放在一个叫`bin`的目录中，bin 表示 binary.] 
    - `.dat`, `.mp3`, $\ldots$

:::notes
除了纯文本文件外，图像、视频、可执行文件等一般都被称作“二进制文件”。二进制文件如果用“记事本”程序打开，看到的是一片乱码。所以`cat a.exe`会显示无法阅读的乱码。

所谓“文本文件”和“二进制文件”，只是约定俗成的、从计算机用户角度出发进行的分类，并不是计算机科学的分类。因为从计算机科学的角度来看，所有的文件都是由二进制位组成的，都是二进制文件。文本文件和其他二进制文件只是格式不同而已。
:::


# 数据文件

## 文本文件

文本文件（text file, flat file），又称纯文本，一般指只有字符原生编码构成的二进制计算机文件，能够被最简单的文本编辑器直接读取。

- 优点
    - 结构简单，文本文件被广泛用于记录信息
    - 出现错误时往往比较容易恢复
- 缺点
    - 信息存储密度低，比较浪费空间

### 字符集和字符编码

字符集（Charset）

: 一个系统支持的所有抽象字符的集合。字符是各种文字和符号的总称，包括各国家文字、标点符号、图形符号、数字等。字符集中的每个字符对应一个编码值，表示字符在字符集中的位置。

字符编码（Character Encoding）

: 编码字符集和实际存储数值之间的转换关系。

### 常见字符集与编码

- 字符集
    - ASCII, latin1
        - 用256以内的整数表示字母、数字和符号
    - GB2312, GBK, GB18030
        - 用两个字节长度的整数表示一个汉字字符
    - Unicode
        - 统一编码了世界上大部分的文字系统
        - 已经收录超过13万个字符，包括emoji
        - 至少需要3个字节存储
- 字符编码方案
    - UFT-8：一种变长的编码方案，使用 1~6 个字节来存储；
    - UFT-32：一种固定长度的编码方案，不管字符编号大小，始终使用 4 个字节来存储；
    - UTF-16：介于 UTF-8 和 UTF-32 之间，使用 2 个或者 4 个字节来存储，长度既固定又可变。
- 编码转换练习

:::notes
练习：在vscode中创建一个文本文件，保存为不同的编码，并对比二进制形式。

1. 选择菜单项 "File" -> "New File"，或使用快捷键 "Ctrl + N"^[macOS下 为 "⌘ + N"]
1. 输入一些中文和英文字符，例如“Hello, 中文输入!”
1. 选择菜单项 "File" -> "Save"，或使用快捷键 "Ctrl + S"^[macOS下 为 "⌘ + S"]，保存文件。文件名为 `t_u8.txt`
1. 选择菜单项 "View" -> "Terminal"，或使用快捷键 "Ctrl + \`"^[重音符号 \` 在键盘左上角，`esc`键下面]，打开一个命令行终端
1. 在终端中键入 `ls` 查看当前目录内容，确认存在 `t_u8.txt` 文件
1. 在终端中键入`cp t_u8.txt t_u16l.txt`，为 `t_u8.txt` 文件创建一个副本并命名为`t_u16l.txt`
1. 在终端中键入`cp t_u8.txt t_u16b.txt`，为 `t_u8.txt` 文件创建一个副本并命名为`t_u16b.txt`
1. 将 t_u16l.txt 文件改为 “UTF-16 LE” 编码
    - 在侧边栏中单击打开 t_u16l.txt 文件，并点击窗口右下角显示 `UTF-8` 的位置
    ![](assets/2021-09-10-01-54-37.png)
    - 在弹出的菜单中选择 "Save with Encoding"，然后选择“UTF-16 LE”
1. 同样方式将 t_u16b.txt 文件改为 “UTF-16 BE” 编码
1. 用Hex Editor打开这三个文件并对比
    - 在侧边栏中右键点击要打开的文件
    - 选择 "Open With ..."
    - 选择 "Hex Editor"
1. 尝试在 Hex Editor 中修改文件内容并保存。
:::


## 富文本

格式化文本（英文：formatted text、styled text、rich text），与纯文本（plain text）相对，具有风格、排版等信息，如颜色、式样（黑体、斜体等）、字体尺寸、特性（如超链接）等。

- 特定文本格式：rtf
- 标记语言：html, xml
- 二进制格式：doc/docx

rtf文件示例：

```
{\rtf1\ansi
Hello!\par
This is some {\b bold} text.\par
}
```

:::notes

练习：新建一个文件并保存为`test.rtf`，将上述代码输入后保存。用word或写字板软件查看文件内容。

在浏览器中可以直接查看网页文件的源代码，也可以保存下来用编辑器打开。

docx是一种二进制格式的富文本，本质上是一个压缩文件。Windows下将文件后缀改为`.zip`后可解压查看; macOS 可直接使用 `unzip` 命令解压.
:::

## 多媒体文件

- 图片文件
    - 图像：.bmp, .tiff/.tif, .gif, .jpeg/jpg
    - 图形：.ps, .eps, .pdf, .svg
- 视频文件
    - .mp4, .mov, .rm, .mpeg, .avi
- 音频文件
    - .wav, .mp3, .aac

多媒体文件记录的不是文字或记录的数字，而是经过离散化的某种测量值。图像中称为 DN 值(Digital Number)

### 计算机如何存储图像

每个图像的像素通常对应于二维空间中一个特定的位置，并且有一个或者多个与那个点相关的采样值组成数值。根据这些采样数目及特性的不同数字图像可以划分为：

- 二值图像：图像中每个像素的亮度值(Intensity)仅可以取自0或1的图像，因此也称为1-bit图像。
- 灰度图像：图像中每个像素可以由0(黑)到255(白)的亮度值(Intensity)表示。0-255之间表示不同的灰度级
- 彩色图像：常采用RGB模型，即彩色图像是由红、绿、蓝三种颜色成分组合而成。通常一个像素由三个字节组成，分别代表红、绿、蓝三种颜色的亮度。

### 探索 BMP 文件

![BMP 头文件](assets/bmp_header.png)

典型的应用程序会首先普通读取这部分数据以确保的确是位图文件并且没有损坏。所有的整数值都以小端序存放。

:::notes
修改BMP文件数据区的一个字节只会改变一个像元，而jpg文件则会改变一片，原因在于jpg采用的图像编码方式不同。
:::

# 空间数据

空间数据类型

- 矢量数据
- 栅格数据

![](assets/demo_vec_ras.png){width=75%}

## 常见矢量文件格式

### shapefile 格式
:::{.columns align=center}
:::{.column width="40%" }
应用最广泛的文件格式

- 多文件组成
  - *.shp：主文件用于存储地理要素的几何图形
  - *.shx：索引文件用于存储图形要素和属性信息索引
  - *.dbf：dBase 表文件用于存储要素的一般属性信息
  - (可选): *.prj, *.sbn/sbx 等
- 存储上限 2G
- 不支持拓扑
- 不支持栅格

![](assets/shpFiles.png){width=2cm}
:::
:::{.column width="60%"}

![shapefile 文件模型](assets/shapefile_model.png)
:::
:::

### geodatabase

ArcGIS 的原生数据结构，是用于保存数据集集合的“容器”。有以下三种类型：

- 文件地理数据库 - 在文件系统中以文件夹形式存储。每个数据集都以文件形式保存，该文件大小最多可扩展至 1 TB。建议使用文件地理数据库而不是个人地理数据库。
- 个人地理数据库 - 所有的数据集都存储于 Microsoft Access 数据文件内，该数据文件的大小最大为 2 GB。
- 企业级地理数据库 - 也称为多用户地理数据库，在大小和用户数量方面没有限制。这种类型的数据库使用 Oracle、Microsoft SQL Server、IBM DB2、IBM Informix 或 PostgreSQL 存储于关系数据库中。

### GeoPackage

:::{.columns align=center}
:::{.column width="45%" }
GeoPackage 是由 OGC 制定的存储地理信息的开放数据格式

- 存储形式: 独立于平台的 SQLite 数据库文件(单文件)
  - 轻量
  - 开源
- 既可存储矢量要素数据，也可存储遥感影像金字塔、地图瓦片矩阵集等栅格瓦片数据。
- 存储上限同 SQLite(理论上限 140T)
:::
:::{.column width="50%"}
![GeoPackage 数据模型](assets/geopkg_model.png)

:::
:::

### 交换格式

- GeoJSON 是一种基于JSON的开源标准格式
  - 数据结构简单
  - 可读性强，前后端兼容性好
  - 特别适合 Web 应用
- E00: Esri的一种通用交换格式文件
  - 通过明码的方式表达了几乎所有的矢量格式以及属性信息，广泛应用于与其他软件之间进行数据交换。

