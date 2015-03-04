# Go 项目翻译规范

本文档描述了参与翻译的方法及注意事项。若有疑问或需补充，请向
[本站代码库](https://github.com/golang-china/golang-china.github.com)
添加 issue，在进行过讨论后请在你的 fork 中提交修改并发送 PR（即 Pull Request，下同）。

**注意：由于过去翻译的文档并未更新且仍需校对，因此请以本文档所述规范为准。**


## 包文档翻译规范

由于`godoc`只会提取**紧挨着**声明之前的注释作为文档，因此我们可利用这点进行翻译。
**请在注释符号`//`之后，文字之前插入一个制表符（Tab符号），段注释前直接插入制表符**，
这样便于跟踪官方文档的更改。注释与代码间插入一个空行，紧接着开始翻译。翻译与代码之间不要有空行。
我们以`math/abs.go`文件中的`Abs`函数为例：

```Go
// Abs returns the absolute value of x.
//
// Special cases are:
//	Abs(±Inf) = +Inf
//	Abs(NaN) = NaN
func Abs(x float64) float64
```

在**注释符内插入制表符**并在注释与代码间插入换行符后，就可以紧挨着声明进行翻译了：

```Go
//	 Abs returns the absolute value of x.
//
//	 Special cases are:
//		Abs(±Inf) = +Inf
//		Abs(NaN) = NaN

// Abs 返回 x 的绝对值。
//
// 特殊情况为：
//	Abs(±Inf) = +Inf
//	Abs(NaN)  = NaN
func Abs(x float64) float64
```

此时，由于原文与译文之间有空行，而译文与声明之间无空行，`godoc` 会忽略原文，
而将译文作为`Abs`函数的文档提取出来。文档所要说明的声明（本例为`Abs`的函数声明）
必须为第一个单词，且与后续译文之间有一空格（本例中为“Abs 返回…”）。
英文、数字及其它半角符号与中文之间要有空格（例如这里的`返回 x 的`），标点符号一律使用全角
（除了包声明前注释的第一句句末，见下。）；若英文、数字及其它半角符号的某一侧有中文标点，
则无需空格（例如“什么什么东西，x 怎样怎样”）。

注释中的关键字、声明、常量（包括 nil、true 和 false）、变量、操作符（如 >=、<< 等）、返回值
等属于源码内容的我们则不作翻译。这里以`math/bits.go`为例：

```Go
//	 Inf returns positive infinity if sign >= 0, negative infinity if sign < 0.

// Inf 返回无穷大值。若 sign >= 0，则返回正无穷大；若 sign < 0，则返回负无穷大。
func Inf(sign int) float64
```

由于`sign`属于源码内的变量，`>=` 属于操作符，因此这里未作翻译。

包声明前的注释译法同上，只是必须将包名作为第一个单词，此外，**句末以英文点号“.”结尾**。
注释的第一行应为对该包的简单描述，接着换行以继续详情的翻译。如：

```Go
//	 Package bytes implements functions for the manipulation of byte slices.
//	 It is analogous to the facilities of the strings package.

// bytes 包实现了对字节切片进行操作的函数.
// 它与 strings 包中的工具类似。
package bytes
```

由于`*_test.go`文件内可能包含`godoc`可提取的示例函数（即以`Example`开头的函数），
因此也需要对这些函数前的注释文档进行翻译（一般情况下，这些文件名会包含`example`字样，
例如`example_test.go`）。

每个源文件头的版权声明，我们则不作翻译。

