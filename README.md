# Go语言文档翻译

## 背景介绍

Go语言自带了一个 godoc 工具, 用于浏览本地的Go文档.

但是官方的 godoc 工具并不支持多种语言的切换.
如果需要基于 官方的 godoc 来翻译Go的文档, 需要直接修改Go源码中的注释.

这是 Go-zh 之前一直采用的方式方式:
https://github.com/Go-zh/go

直接在Go源码上进行翻译的优点是完美兼容官方的 godoc 工具.

但是这种翻译方式有诸多缺点:

- 破坏了Go源码
- 翻译散落在各个go文件中, 对翻译者很不友好
- 无法支持多种翻译语言, 每种翻译语言都必须对应一个Go的修改版本
- 和Go官方的代码同步很困难

既然直接在Go源码上进行翻译有这么多缺点, 为何不能修改 godoc 工具呢?

这是我们采用的翻译思路: 改进 godoc 工具, 支持外部翻译文件的动态加载.

## golangdoc: 支持多国语言的 godoc

golangdoc 是我们改造的 godoc 版本:
https://github.com/golang-china/golangdoc

支持动态加载 doc/package/blog 等文档的翻译文件.

使用的流程如下:

1. 安装 golangdoc: `go get github.com/golang-china/golangdoc`
2. 安装 翻译文件: 下载 https://github.com/golang-china/golangdoc.translations 到 $(GOROOT)/translations 目录
3. 运行中文文档服务: `golangdoc -http=:6060 -lang=zh_CN`

打开浏览器 `http://127.0.0.1:6060/`, 就可以查看到的中文帮助了.

##  开始翻译

前面已经看到, [golangdoc.translations](https://github.com/golang-china/golangdoc.translations) 对应
golangdoc 的翻译文件, 因此翻译工作主要是在  [golangdoc.translations](https://github.com/golang-china/golangdoc.translations) 项目中进行.

[golangdoc.translations](https://github.com/golang-china/golangdoc.translations) 的目录结构:

- [`$(GOROOT)/translations/static`](https://github.com/golang-china/golangdoc.translations/tree/master/static/zh_CN): 静态文件翻译, `zh_CN` 对应简体中文版本. 原始目录在 [这里](https://github.com/golang/tools/tree/master/godoc/static).
- [`$(GOROOT)/translations/doc`](https://github.com/golang-china/golangdoc.translations/tree/master/doc/zh_CN): Go语言自带文档翻译, `zh_CN` 对应简体中文版本. 原始目录在 [这里](https://github.com/golang/go/tree/master/doc).
- [`$(GOROOT)/translations/src`](https://github.com/golang-china/golangdoc.translations/tree/master/src): Go语言包文档翻译, `builtin/doc_zh_CN.go` 对应简体中文版本. 原始目录在 [这里](https://github.com/golang/go/tree/master/src).
- [`$(GOROOT)/translations/blog`](https://github.com/golang-china/golangdoc.translations/tree/master/blog/zh_CN): Go语言博客文章翻译. `zh_CN` 对应简体中文版本. 原始目录在 [这里](https://github.com/golang/blog).

其中包文件的翻译是对应每个独立的 [`builtin/doc_zh_CN.go`](https://github.com/golang-china/golangdoc.translations/blob/master/src/builtin/doc_zh_CN.go) 文件. 翻译者只需要参考 `doc_xxx.go` 中自带的原始的注释翻译就可以了. 最早的成果 `doc_xxx.go` 中包含原始注释和翻译后的注释.

Doc/Blog 的翻译是独立的 `zh_CN` 目录, `zh_CN` 目录的结构和原始的目录结构一致.

目前 golangdoc 还不支持 Talk 和 Tour, 以后会考虑支持.

### 第三方包的翻译

如果有同学有自己的维护的包, 想提供翻译文件. 但是翻译文件不想在 [golang-china](https://github.com/golang-china/) 维护的话, 可以在自己的包里放一个翻译文档.

可以参考 [golandco/local/doc_zh_CN.go](https://github.com/golang-china/golangdoc/blob/master/local/doc_zh_CN.go)

```Go
// +build ingore

// local 包用于提供 godoc 的翻译支持.
package local

// 翻译文件所在的默认目录.
const (
	Default = "translations" // $(RootFS)/translations
)

// DocumentFS 函数返回 doc 目录对应的文件系统.
func DocumentFS(lang string) vfs.FileSystem

// DocumentFS 函数初始化本地翻译资源的环境.
func Init(goRoot, goZipFile, goTemplateDir string)
```

翻译文档在开头增加一个 `// +build ingore` 标志, 表示该文档不参与编译.

然后每个函数只写声明, 不需要写函数实现(写了也没有关系).

如果想提供繁体中文的文档, 可以添加类似的 `doc_zh_TW.go` 文件.

## 参与贡献的方式

参与的方式比较自由: 可以提交 PullRequest, 也可以申请提交权限支持在web提交.

如果有各种建议, 可以创建 ISSUE 提出来, 并在后面留言讨论.

也可以加入QQ群(368836416)先了解下情况.

## 任务认领

目前还没有统一的方式(以后也不一定有). 认领的目的主要是为了不做重复工作.

大家可以在 [golangdoc.translations](https://github.com/golang-china/golangdoc.translations) 上建立 ISSUE 标记下.

或者在 QQ群 里说下都可以.


## 更多参考

- [Go 项目翻译指南](trans-guide.md)
- [Go 项目翻译规范](trans-spec.md)
- [术语翻译](trans-terms.md)

