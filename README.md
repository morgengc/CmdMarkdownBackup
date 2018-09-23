# CmdMarkdownBackup

此项目实现两个目的：
 1. 建立一套一键打包体系，将 AutoHotkey 生成的 exe 及其资源文件打包整体发布。
 2. 备份 [Cmd Markdown 编辑阅读器](https://www.zybuluo.com/mdeditor) 编写的 *.md 文件和其中引用的图片、资源。

## 使用方法

### CmdMarkdown 高级版
 1. 使用编辑器的“一键导出所有文稿”功能，导出zip文件
 2. 运行 `release\CmdMarkdownBackup.exe`
 3. 将zip文件（或者zip文件解压缩目录）拖动到 "CmdMarkdownBackup.exe" 界面中
 4. 等待，直到所有资源下载完毕
 5. 备份内容位于zip文件同级同名目录
 
### CmdMarkdown 免费版
 1. 使用编辑器的“导出Markdown”功能，依次导出 .md 文件，并将这些文件放入一个新建目录中
 2. 运行 `release\CmdMarkdownBackup.exe`
 3. 将新建目录拖动到 "CmdMarkdownBackup.exe" 界面中
 4. 等待，直到所有资源下载完毕
 5. 备份内容位于新建目录

## 开发者

> 你可以试试将 `release` 目录下的文件后缀由 .exe 改为 .rar，观察打包后的目录结构。 

此项目提供了一个打包框架可用于发布应用程序，并将应用程序依赖的所有资源放进 .exe 中。你可以将你的应用程序脚本放入 `source\scripts`，确保该目录只有一个应用程序脚本。如果应用程序脚本引用了其他库，可以创建 `source\lib` 目录，并将库置于 `source\lib`下。然后修改 `Package.ahk` 相应参数编译，双击 `Package.ahk`，一键生成 SFX 自解压文件，位于 `release` 目录。紧接着就可以运行它了。

**注**：本步骤要求已经安装了 AutoHotkey，具体安装步骤见 [AhkScriptManager](https://github.com/morgengc/AhkScriptManager)。该功能最早实现于 [AhkScriptManager](https://github.com/morgengc/AhkScriptManager/blob/master/scripts/%2B16.%20%E6%B1%87%E6%80%BBmd%E6%96%87%E4%BB%B6.ahk)，为了能够单独使用，特将该功能剥离出来。


