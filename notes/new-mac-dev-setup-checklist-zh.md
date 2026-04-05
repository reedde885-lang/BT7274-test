# 新 Mac 开荒清单（开发者版）

适用场景：

- 新买 MacBook / Mac mini / Mac Studio
- 重装系统后的开发环境恢复
- 以 Web、后端、AI、iOS 或通用开发为主

说明：

- 这份清单按“先安全、再基础、再开发、最后迁移”来排顺序。
- 不要求一次装完所有软件，先把最常用的链路打通更重要。
- 如果是 Apple silicon 机型，优先装原生 arm64 版本软件。

## 0. 开箱后的前 15 分钟

- 连上稳定网络，先完成系统初始化。
- 进入 `System Settings > General > Software Update`，先把系统更新到当前可用版本。
- 登录 `Apple ID`，打开你需要的同步项：
  `iCloud Drive`、`Passwords / Keychain`、`Find My Mac`、`Notes`、`Calendar`
- 如果你要从旧 Mac 迁移数据，先决定是：
  - 直接用 Migration Assistant
  - 只迁移文档和账号，开发环境重新搭

## 1. 安全与备份先做好

- 打开 `FileVault`
  路径：`System Settings > Privacy & Security > FileVault`
- 打开 `Find My Mac`
- 准备 `Time Machine` 备份盘，至少先建立第一次备份
- 确认锁屏密码、Touch ID、自动锁屏时间都合理

为什么先做这一步：

- 丢机器时，`FileVault + Find My` 比任何开发工具都更重要
- 新机器最容易忽略备份，但一旦环境搭好后再坏盘，损失最大

## 2. 先调整系统设置

- Finder:
  - 显示文件扩展名
  - 显示路径栏
  - 显示状态栏
  - 新窗口默认打开你的工作目录
- Keyboard:
  - 调整按键重复速度
  - 关闭你不需要的自动纠错
  - 确认输入法快捷键
- Trackpad:
  - 打开轻点点按
  - 调整滚动、三指拖移、Mission Control 手势
- Dock:
  - 删掉不用的默认 App
  - 把常用开发工具固定到 Dock
- Screenshot:
  - 把截图默认目录改到固定文件夹
- Battery:
  - 如果长期插电，打开优化电池充电

## 3. 装开发基础链路

### 必装 1：Xcode Command Line Tools

```bash
xcode-select --install
```

这是很多开发工具的前置依赖，没装它，`git`、编译链和一部分包管理流程都会不顺。

### 必装 2：Homebrew

官方安装命令：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装后先跑：

```bash
brew update
brew doctor
```

### 必装 3：Git 与 GitHub CLI

```bash
brew install git gh
git --version
gh --version
```

### 必装 4：编辑器

常见选择：

- `VS Code`
- `Xcode`（如果你做 Apple 平台开发）
- JetBrains 系列（按需）

如果你主要做 Web、脚本、AI 和通用开发，先装 `VS Code` 通常最省事。

### 必装 5：终端

常见选择：

- 系统自带 `Terminal`
- `iTerm2`

不折腾就先用系统终端，想要更强体验再上 `iTerm2`。

## 4. 配 Git、SSH 和身份

### Git 基本身份

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

### 生成 SSH Key

```bash
ssh-keygen -t ed25519 -C "you@example.com"
```

然后把公钥传到 GitHub / GitLab。

建议检查这些目录是否需要从旧机器迁移：

- `~/.ssh`
- `~/.gitconfig`
- `~/.npmrc`
- `~/.pypirc`
- 云服务凭据目录
- 你的 dotfiles 仓库

## 5. 装语言运行时与包管理

按你自己的技术栈选，不要一次装满。

### Web / Node.js

```bash
brew install node pnpm
```

如果你经常切换 Node 版本，也可以改用版本管理工具。

### Python / AI

```bash
brew install python uv
```

如果你主要跑 Python 项目，`uv` 很适合做包和虚拟环境管理。

### Go

```bash
brew install go
```

### Java

按项目需要安装 JDK，优先选一个你团队统一的发行版和版本。

### Rust

优先用官方 `rustup` 管理，而不是只装单一版本编译器。

## 6. 容器与本地服务

如果你会跑容器、本地数据库、微服务，建议尽早装。

常见选择：

- `Docker Desktop`
- `OrbStack`

原则：

- 只选一个主容器方案，避免同时装多个互相抢资源
- 如果只是偶尔跑容器，先装一个最熟的

常见本地服务按需装：

- `PostgreSQL`
- `Redis`
- `MySQL`
- `MongoDB`

## 7. Apple silicon 额外注意

- 优先下载 `Apple silicon` / `Universal` 版本 App
- 只有旧工具必须依赖 Intel 二进制时，再装 `Rosetta`
- 如果某些浏览器插件、终端工具或驱动不兼容，再单独排查

## 8. 如果你做 Apple 平台开发

- 安装完整 `Xcode`
- 打开一次 Xcode，让它完成附加组件安装
- 安装你需要的模拟器
- 登录 Apple Developer 相关账号
- 确认 `Signing & Capabilities`、证书和 Provisioning Profile 流程可用

## 9. 工作文件与项目迁移

推荐顺序：

1. 先拉代码仓库
2. 再恢复 dotfiles
3. 再恢复 SSH / token / 私钥
4. 最后恢复大体积资料、下载目录和历史缓存

不建议原样把旧机器的“所有软件和所有垃圾”直接完整复制过来。

## 10. 跑一次最小验证

至少检查这些命令能通：

```bash
git --version
gh auth status
python3 -V
node -v
npm -v
pnpm -v
brew doctor
```

如果你依赖容器，再检查：

```bash
docker version
```

如果你依赖 GitHub SSH：

```bash
ssh -T git@github.com
```

最后再实际启动一个你常用项目，确认：

- 代码能拉下来
- 依赖能装
- 环境变量能配
- 开发服务能跑
- 测试至少能过一轮最小用例

## 11. 我会优先装的最小组合

如果是我自己开一台新 Mac，我通常先装这些：

- Xcode Command Line Tools
- Homebrew
- Git
- GitHub CLI
- VS Code
- iTerm2 或系统 Terminal
- Node.js / pnpm
- Python / uv
- Docker Desktop 或 OrbStack
- 1Password 或你已有的密码管理方案
- Raycast（可选）

## 12. 一页版速查

### 第一优先级

- 更新系统
- 登录 Apple ID
- 打开 FileVault
- 配 Time Machine
- 安装 Xcode Command Line Tools
- 安装 Homebrew
- 装 Git / 编辑器 / 终端

### 第二优先级

- 配 Git 和 SSH
- 装语言运行时
- 装容器工具
- 拉代码和 dotfiles

### 第三优先级

- 装数据库、本地服务、效率工具
- 调整 Finder / Keyboard / Trackpad
- 做完整项目验证

## 官方参考链接

- Migration Assistant:
  <https://support.apple.com/en-us/102613>
- FileVault:
  <https://support.apple.com/guide/mac-help/protect-data-on-your-mac-with-filevault-mh11785/mac>
- Mac 备份 / Time Machine:
  <https://support.apple.com/mac-backup>
- Rosetta:
  <https://support.apple.com/en-us/102527>
- Homebrew:
  <https://brew.sh/>
- VS Code on macOS:
  <https://code.visualstudio.com/docs/setup/mac>
- Xcode:
  <https://developer.apple.com/xcode>
- Docker Desktop for Mac:
  <https://docs.docker.com/desktop/setup/install/mac-install/>
- iTerm2:
  <https://iterm2.com/downloads.html>
- OrbStack:
  <https://orbstack.dev/>
- Raycast:
  <https://www.rayca.st/>
