# PPT Crop for Papers

这是一个用于论文写作的工作流程自动化脚本，可以从 PowerPoint 导出 PDF，进行图像裁剪，并自动同步到 Google Drive 和其他位置。

## 功能特性

- **自动导出 PDF**: 从 Microsoft PowerPoint 自动导出 PDF 文件
- **图像裁剪**: 调用外部脚本对 PDF 进行白边裁剪处理
- **文件同步**: 自动将处理后的文件同步到 Google Drive
- **时间戳命名**: 生成的文件带有时间戳，便于版本管理

## 使用方法

### 1. 前置要求

- macOS 系统
- Microsoft PowerPoint
- Alfred（用于工作流自动化）
- pdfcropmargins 和 pdfcrop 工具（用于 PDF 裁剪）
- Google Drive（用于文件同步）

### 安装依赖

```bash
# 安装 PDF 裁剪工具 (macOS)
brew install pdfcropmargins
brew install pdfcrop

# 或者使用 conda
conda install -c conda-forge pdfcropmargins
```

### 2. 配置脚本变量

在 `for_alfred.applescript` 中修改以下路径：

```applescript
# 修改这行中的路径：
# /path/to/crop_pdf.sh - 替换为 crop_pdf.sh 的实际路径
# /path/to/pdf - 替换为 PDF 输出目录路径
# /path/to/google_drive/ - 替换为 Google Drive 目录路径
# /path/to/pptx/ - 替换为 PPTX 文件目录路径

set commandString to "/path/to/crop_pdf.sh /path/to/pdf" & pdfName & ".pdf /path/to/google_drive/MMCL3.pdf; rsync -av /path/to/pptx/MMCL32.pptx /path/to/google_drive/; "
```

### 3. PowerPoint 快捷键设置

PowerPoint 需要设置导出 PDF 的快捷键：
1. 打开 Settings -> Keyboard Shortcuts -> App Shortcuts
3. 设置快捷键为 `Command + Shift + E`

### 4. 运行脚本

在 Alfred 中创建工作流，调用 `for_alfred.applescript` 即可一键完成整个流程。
![alt text](<assets/Alfred workflow.png>)
![alt text](<assets/Alfred example.png>)

## 文件说明

- `for_alfred.applescript`: 主要的自动化脚本，通过 AppleScript 控制 PowerPoint 和终端操作
- `crop_pdf.sh`: PDF 裁剪脚本，包含两步裁剪逻辑（白边移除 + 灰色框裁剪）
- `Placeholder.pptx`: PowerPoint 模板示例，展示了正确的灰色框设计

## 工作流程

1. 激活 PowerPoint 并导出当前文档为 PDF（最佳打印质量）
2. 调用裁剪脚本处理 PDF 白边
3. 将处理后的 PDF 同步到 Google Drive
4. 将原始 PPTX 文件同步到 Google Drive
5. 激活 Firefox（用于后续操作，比如 overleaf 页面）

## 注意事项

- 请确保所有路径配置正确，避免文件操作失败
- 脚本中包含延时操作，确保应用程序有足够时间响应
- 如果 Google Drive 路径较长，可能需要调整字符串拼接逻辑

## 故障排除

### PDF 导出失败
- 检查 PowerPoint 中是否正确设置了快捷键 (Command + Shift + E), Mac中需要手动设置
- 确保当前有打开的 PowerPoint 文档

### 裁剪脚本报错
- 确认已安装 `pdfcropmargins` 和 `pdfcrop` 工具
- 检查输入文件路径是否存在
- 验证输出目录权限

### Google Drive 同步失败
- 检查 Google Drive 路径配置是否正确
- 确认有足够的磁盘空间
- 验证网络连接

### 脚本无响应
- 检查是否所有应用程序都已正确安装
- 尝试增加脚本中的延时时间
- 查看系统日志了解具体错误

## PPT 模板说明

项目包含一个示例文件 `Placeholder.pptx`，展示了如何设计适合裁剪的 PPT 模板：

### 模板设计要点

- **外层灰色框**: 表示会被裁剪掉的区域边界
- **内层灰色框** (可选): 表示图片的具体内容区域
- **颜色选择**: 使用灰色框不会太醒目，也不会干扰绘图
- **颜色要求**: 避免使用太浅的颜色，否则裁剪脚本可能检测不到

### 裁剪逻辑

1. **第一次裁剪**: 使用 `pdfcropmargins` 移除所有白色边距，裁剪到遇到有色区域为止
2. **第二次裁剪**: 使用 `pdfcrop` 进一步裁剪灰色边框（-3 点边距）
3. **多页对齐**: PPT 支持多页内容，可以将灰色框复制到每一页确保精确对齐

### PPT 模板设计详解

项目提供了一个 `Placeholder.pptx` 示例文件，展示了如何设计适合自动裁剪的 PPT 模板：

**模板结构说明**：
- 外层灰色框表示将被裁剪掉的区域边界
- 内层灰色框（可选）代表图片的具体内容区域
- 颜色可以根据个人喜好调整，但应避免过浅的颜色以确保裁剪脚本能够正确识别

**裁剪原理**：
第一次裁剪会移除所有白色边距，直到遇到有色区域为止。如果颜色过浅，脚本可能无法准确检测到边界。我选择灰色是因为它既不会过于醒目，也不会干扰绘图创作。

第二次裁剪会进一步移除灰色边框（3点边距），最终保留内部完整图片。由于 PPT 支持多页对齐，您可以将灰色框复制到每一页并精确对齐位置，这样就能轻松创建由多个图片组成的大图。

**自动化流程**：
脚本首先自动将 PPT 导出为 PDF（需要预先设置快捷键），导出的文件名会自动添加时间戳，确保每次修改都能生成唯一版本。然后执行裁剪脚本处理 PDF，最后将结果同步到 Google Drive。在 Overleaf 中，您可以通过外部 URL 链接到这些 PDF 文件，每次更新后刷新页面就能看到论文中的图片自动更新。

正是因为每次手动裁剪都过于繁琐，我开发了这个自动化脚本，希望能为大家的论文写作提效助力。

## 详细工作流程

1. **自动导出 PDF**: 脚本模拟快捷键 (Command + Shift + E) 导出 PDF，使用最佳打印质量
2. **时间戳命名**: 生成的文件名格式为 `MMCL3-YYYY-MM-DD-HH-MM-SS.pdf`，确保每次修改都有唯一版本
3. **PDF 裁剪**: 调用 `crop_pdf.sh` 脚本进行白边和灰色框裁剪
4. **文件同步**:
   - 处理后的 PDF 同步到 Google Drive
   - 原始 PPTX 文件也同步到 Google Drive，便于版本管理
5. **激活浏览器**: 打开 Firefox，方便后续在 Overleaf 中查看更新

## 在 Overleaf 中使用

1. 将 Google Drive 中的 PDF 文件设置为公开分享
2. 在 Overleaf 中使用 External URL 链接到 PDF
3. Overleaf 刷新后，论文中的图片会自动更新

## 版本管理建议

Google Drive 会自动记录文件修改历史，但版本保留有时间限制。建议在进行重大修改前手动保存重要版本。

## 贡献与反馈

If you find this tool useful, please consider giving it a ⭐ star on GitHub!

如果这个工具为您的工作带来了便利，欢迎访问我的个人主页，我们可以进一步交流想法、探讨合作机会。

I'm always open to discussions and collaborations!