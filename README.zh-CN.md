# Hermes 安卓客户端

[Hermes Agent](https://hermes-agent.nousresearch.com/) 的安卓客户端 —— 通过本地 Wi-Fi 或私有 Tailscale 网络，在手机或平板上与您的 Hermes 会话聊天。

## 当前版本

- 版本：**1.0.8**
- 包名：`com.hermesagent.hermes_android`
- 多数现代手机推荐 APK：`app-arm64-v8a-release.apk`
- 其他 APK：`app-armeabi-v7a-release.apk`、`app-x86_64-release.apk`
- 下载：[GitHub Releases](https://github.com/rusty4444/hermes-android/releases/latest)

## v1.0.8 更新内容

- **反向代理路径前缀** —— 为网关 API 与仪表盘分别配置路径前缀，例如在 `/api` 和 `/v1` 之前加 `/profile/peter`，在仪表盘 `/api` 路由之前加 `/dashboard`。
- **代理后仪表盘模式** —— 当 nginx/Caddy/您的主机注入了仪表盘认证时，开启 **Dashboard behind proxy（仪表盘位于代理之后）**。此模式下应用直接发送干净的仪表盘请求，不再尝试抓取仪表盘会话令牌或执行密码登录。
- **前缀感知的校验与聊天** —— API 密钥校验、会话浏览、已有聊天历史、流式聊天补全，以及仪表盘抽屉页，全部使用所配置的前缀。

## v1.0.7 更新内容

- **带密码保护的仪表盘** —— 记忆 / 定时任务 / 技能 / 设置 标签页现在也能对接启用了 basic-auth 密码保护的仪表盘，而不只是开放（`--insecure`）的那种。应用通过仪表盘的 `/auth/password-login` 流程登录，并复用会话 Cookie（与桌面客户端机制相同）。
- **可配置的仪表盘端口** —— 当不是默认端口 `9119` 时，可为每个连接单独设置仪表盘端口。
- **连接流程中的仪表盘详情** —— 添加连接时即可设置仪表盘端口 / 用户名 / 密码（展开 **Custom dashboard details（自定义仪表盘详情）**），或稍后通过 **⋮ → Dashboard Login（仪表盘登录）** 设置，保存前会先做校验。

## v1.0.6 更新内容

- **语音聊天支持** —— 在聊天中点击麦克风向 Hermes 口述消息，Hermes 也能语音念回回复。
- 可在聊天输入框中开关「语音回复」。
- 已包含安卓 / iOS 的麦克风与语音识别权限。

## 功能特性

- **安卓上的 Hermes 聊天** —— 浏览会话、新建聊天、向您的 Hermes 智能体发送提示词。
- **流式响应** —— 聊天使用 Hermes 网关的 OpenAI 兼容流式端点：`POST /v1/chat/completions`。Token 实时出现，并平滑自动滚到底部。
- **消息风格 UI** —— 深色 / 浅色 / 跟随系统三套主题，Hermes 金色强调色（`#D4AF37`），Markdown 渲染，相对时间戳，以及响应式的手机 / 平板布局。
- **金黑 Hermes 品牌** —— 黑底金调的醒目强调色、带 mipmap 多密度的自定义应用图标，智能体消息使用灰色气泡。
- **网关 API 集成** —— 会话与聊天通过 Hermes 网关 API 服务运行，通常位于端口 `8642`，支持 HTTP 与 HTTPS 端点。反向代理部署可在 `/api` 和 `/v1` 路由之前设置网关路径前缀。
- **仪表盘集成** —— 记忆、定时任务、技能、设置 页面使用 Hermes 仪表盘 API（默认端口 `9119`，可按连接配置）访问同一主机。兼容开放（`--insecure`）仪表盘、通过内置登录的**密码保护仪表盘**，以及认证由上游戏入的代理后仪表盘。
- **模型设置** —— 在仪表盘暴露模型设置的位置查看并更改已配置的 Hermes 模型。
- **定时任务管理** —— 列出、触发、暂停 / 恢复、创建、编辑、删除已调度的 Hermes 定时任务。
- **技能浏览器** —— 查看可用的 Hermes 技能及其描述与触发条件。
- **记忆查看器** —— 检查跨会话的对话记忆。
- **详细模式开关** —— 在聊天中显示原始消息元数据（角色、工具调用、时间戳）。
- **三态主题切换** —— 深色 / 浅色 / 系统默认。
- **键盘处理** —— 键盘弹出时自动滚动、回车发送、浮动按钮滚动到底部。
- **语音聊天** —— 麦克风听写将识别出的语音发送给 Hermes，并可选择文字转语音（TTS）语音回复。

## 截图

<table>
  <tr>
    <td align="center"><img src="docs/screenshots/01-session-list.jpg" width="220" alt="Session list"><br><sub>会话列表</sub></td>
    <td align="center"><img src="docs/screenshots/02-navigation-drawer.jpg" width="220" alt="Navigation drawer"><br><sub>导航抽屉</sub></td>
    <td align="center"><img src="docs/screenshots/03-cron-jobs.jpg" width="220" alt="Cron jobs"><br><sub>定时任务</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/04-add-cron-job.jpg" width="220" alt="Add cron job"><br><sub>添加定时任务</sub></td>
    <td align="center"><img src="docs/screenshots/05-memory.jpg" width="220" alt="Memory"><br><sub>记忆</sub></td>
    <td align="center"><img src="docs/screenshots/06-settings.jpg" width="220" alt="Settings"><br><sub>设置</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/07-skills.jpg" width="220" alt="Skills"><br><sub>技能</sub></td>
  </tr>
</table>

## 快速开始

### 前置条件

- 安卓设备或模拟器（Android 8 及以上）。
- 主机上已安装 Hermes Agent。
- 安卓设备能访问到 Hermes 网关 API 服务。
- 来自 Hermes 主机环境的 `API_SERVER_KEY`（`~/.hermes/.env`）。
- 可选：为记忆 / 定时任务 / 技能 / 设置 页面暴露可达的 Hermes 仪表盘。

Hermes Agent 文档：<https://hermes-agent.nousresearch.com/docs>

### 安装 APK

从 [GitHub Releases](https://github.com/rusty4444/hermes-android/releases/latest) 页面下载最新 APK。

多数安卓手机安装 arm64 版 APK：

```bash
adb install app-arm64-v8a-release.apk
```

若在安卓上直接侧载，请为您的浏览器或文件管理器开启 **「安装未知应用」**，再打开下载好的 APK。

### 1. 启动网关 API 服务

安卓聊天 / 会话功能连接到 Hermes 网关 API 服务。它必须绑定到手机能够访问的地址，而不仅是 `127.0.0.1`。

使用您平常的 Hermes 网关 / API 服务启动命令，并确认：

- 主机 / IP 可从安卓访问
- 端口通常为 `8642`
- `API_SERVER_KEY` 在 `~/.hermes/.env` 中可用

### 2. 可选：为抽屉页功能启动仪表盘

记忆、定时任务、技能、设置 使用 Hermes 仪表盘 API（默认端口 `9119`）。

开放仪表盘（无需登录）：

```bash
hermes dashboard --insecure --host 0.0.0.0 --tui --port 9119
```

密码保护仪表盘（在共享网络上推荐）—— 用 basic-auth 提供方代替 `--insecure` 启动，然后在应用的 **Dashboard / Proxy Settings（仪表盘 / 代理设置）** 对话框里填入用户名 / 密码（见 [仪表盘访问配置](#4-可选配置仪表盘访问)）。

> 从其他设备连接时 **必须** 加 `--host 0.0.0.0`。仅监听本地的仪表盘无法从安卓访问。

### 3. 连接应用

1. 将安卓设备与 Hermes 主机置于同一 Wi-Fi / 局域网（或通过 Tailscale 连接 —— 见下文）。
2. 查找 Hermes 主机 IP：

   ```bash
   # macOS
   ipconfig getifaddr en0

   # Linux
   hostname -I | awk '{print $1}'
   ```

3. 打开 Hermes 安卓应用。
4. 点击 **+** 添加连接。
5. 填入：
   - **Label（标签）：** 任意名称，例如 `Home`
   - **Host（主机）：** 主机 IP，例如 `192.168.1.50`
   - **Port（端口）：** `8642`
   - **API Key（API 密钥）：** 来自 Hermes 主机的 `API_SERVER_KEY`
6. 若您的部署位于反向代理路径之后，展开 **Custom proxy and dashboard details（自定义代理与仪表盘详情）**，在其中设置网关 / 仪表盘前缀。不要把 URL 路径填进 Host 字段；Host 字段只填协议、主机名和可选端口。
7. 点击已保存的连接以浏览会话。
8. 点击某个会话开始聊天，或新建一个。

### 4. 可选：配置仪表盘访问

抽屉页（记忆、定时任务、技能、设置）与 Hermes 仪表盘通信，它可以运行在与网关 API 服务不同的端口上，并可能受密码保护。按连接配置 —— 既可在添加连接时（在添加连接对话框展开 **Custom proxy and dashboard details（自定义代理与仪表盘详情）**），也可在之后：

1. 在连接列表中，点击某连接上的 **⋮** 菜单 → **Dashboard / Proxy Settings（仪表盘 / 代理设置）**。
2. 填写：
   - **Gateway path prefix（网关路径前缀）** —— 网关 `/api` 与 `/v1` 路由之前的反向代理路径，例如 `/profile/peter`。
   - **Dashboard path prefix（仪表盘路径前缀）** —— 仪表盘 `/api` 路由之前的反向代理路径，例如 `/dashboard`。
   - **Dashboard behind proxy（仪表盘位于代理之后）** —— 当代理注入了仪表盘认证、且应用不应再去抓取仪表盘 SPA 令牌或用用户名 / 密码登录时，开启此项。
   - **Dashboard Port（仪表盘端口）** —— 留空使用默认（HTTP 为 `9119`，HTTPS 部署则使用同一外部端口）；若仪表盘暴露在其他位置，可显式指定端口。
   - **Username / Password（用户名 / 密码）** —— 仅用于密码保护仪表盘。开放（`--insecure`）仪表盘两者均留空。
3. 点击 **Save（保存）**。应用会在存储前对照仪表盘校验这些设置。

设置凭据后，应用通过仪表盘的 `/auth/password-login` 流程认证，并复用返回的会话 Cookie —— 与 Hermes 桌面客户端机制相同。

## 通过 Tailscale 远程连接

Tailscale 为您的手机与 Hermes 主机提供私有加密网络，因此您**不必**把 Hermes 直接暴露到公网。

Tailscale 官网：<https://tailscale.com/>

### 在安卓上安装 Tailscale

1. 安装安卓版 Tailscale：<https://tailscale.com/download/android>
2. 使用与 Hermes 主机相同的 Tailscale 账号 / tailnet 登录。
3. 使用 Hermes 应用时保持 Tailscale 连接。

### 在 Hermes 主机上安装 Tailscale

为您的系统安装 Tailscale：<https://tailscale.com/download>

示例：

```bash
# macOS（Homebrew）
brew install --cask tailscale

# Debian/Ubuntu
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

主机连上后，获取它的 Tailscale 地址：

```bash
tailscale ip -4
```

您也可以开启 MagicDNS，用机器名代替 `100.x.y.z` 这个 IP：

- MagicDNS 文档：<https://tailscale.com/kb/1081/magicdns>

### 通过 Tailscale 连接应用

在安卓应用的连接对话框中：

- **Host（主机）：** Hermes 主机的 Tailscale IP，例如 `100.64.12.34`，或其 MagicDNS 名称
- **Port（端口）：** `8642`
- **API Key（API 密钥）：** `API_SERVER_KEY`

若要在远程使用记忆 / 定时任务 / 技能 / 设置，请让仪表盘在同一 Tailscale 主机的 `9119` 端口保持可达。

## 通过 HTTPS 连接

对于托管 / 反向代理部署（例如 Hugging Face Spaces、带 nginx/Caddy 的 VPS），在 **Host（主机）** 字段填入完整 HTTPS URL：

```text
https://your-hermes-host.example.com
```

若未包含端口，应用使用 `443` 端口。若您的 HTTPS 服务使用自定义端口，可在 URL 中包含（`https://host.example.com:8443`），或在连接前将 Port 字段设为该值。

对于 HTTPS 连接，抽屉页仪表盘使用同一外部 HTTPS 端口。对于本地 HTTP / 局域网连接，聊天使用 `8642` 端口，仪表盘页面使用 `9119` 端口。

### 反向代理路径

如果您的代理在 URL 路径下暴露 Hermes，请让 **Host（主机）** 字段只填源站，并把路径放到 **Custom proxy and dashboard details（自定义代理与仪表盘详情）** 中：

```text
Host: https://your-hermes-host.example.com
Port: 443
Gateway path prefix: /profile/peter
Dashboard path prefix: /dashboard
Dashboard behind proxy: on，若代理注入了仪表盘认证
```

按此配置，应用调用的网关路由形如：

`https://your-hermes-host.example.com/profile/peter/v1/chat/completions`

仪表盘路由形如：

`https://your-hermes-host.example.com/dashboard/api/model/info`

### 安全提示

- 远程使用优先选择 Tailscale / VPN。
- 不要将网关 API 服务或仪表盘直接端口转发到公网。
- 若 `API_SERVER_KEY` 被共享或泄露，请及时轮换。
- 本地 / Tailscale 示例使用 HTTP，因此私有网络边界很重要。公网或托管端点请使用 HTTPS。

## 架构

```text
Android app (Flutter)
├─ Gateway API Server，端口 8642 或 HTTPS 代理前缀
│  ├─ GET /api/sessions
│  ├─ GET /api/sessions/{id}/messages
│  └─ POST /v1/chat/completions  (SSE 流式)
└─ Hermes dashboard，端口 9119 或 HTTPS 代理前缀
   ├─ /api/memory
   ├─ /api/cron/jobs
   ├─ /api/skills
   └─ /api/model/*
```

## 使用应用

### 聊天界面

- **发送消息** —— 在输入框中输入，点击发送按钮或按回车。
- **流式响应** —— 智能体的响应以 token 为单位实时出现。新 token 到达时聊天自动滚动到底部。
- **工具进度** —— 当智能体使用工具时，行内进度消息会显示工具名、状态与进度。
- **详细模式** —— 在应用设置中开关，以显示原始消息元数据（角色、工具调用 ID、时间戳）。
- **Markdown 渲染** —— 智能体消息渲染 Markdown（代码块、表格、列表、链接）。
- **相对时间戳** —— 消息显示「2 分钟前」「3 小时前」等。

### 语音聊天

聊天输入框有两个语音控件：

| 按钮 | 图标 | 作用 |
|--------|------|-------------|
| **麦克风** | 🎤 / 🎤🔴 | 点击开始语音听写。说出您的消息 —— 文字会出现在输入框，并在您停顿后自动发送。再次点击（或红色停止图标）取消。 |
| **语音回复开关** | 🔊 / 🔇 | 切换语音输入消息后 Hermes 是否朗读其回复。开 = 🔊（音量开），关 = 🔇（音量关）。 |

**语音回复如何工作：**

1. 点击麦克风，说出您的问题，等待识别完成（文字出现并自动发送）。
2. Hermes 照常在聊天中以文字流返回响应。
3. 完整响应到达后，若语音回复开关为开（🔊），应用通过文字转语音朗读响应。

语音回复**仅**在您通过麦克风按钮发送消息时触发。键入的消息只产生文字响应。

#### 配置文字转语音（TTS，安卓）

语音回复需要设备上安装并配置好 Google 文字转语音。应用使用设备内置的 TTS 引擎 —— 它不自带语音包。

**逐步操作：**

1. **安装 Google 文字转语音** —— 若设备上还没有，从 Play 商店安装：[Google Text-to-Speech](https://play.google.com/store/apps/details?id=com.google.android.tts)
2. **设为默认引擎** —— 设置 → 无障碍 → 文字转语音输出 → 首选引擎 → **Google 文字转语音**
3. **下载语音数据** —— 在同一个 TTS 设置界面，点击 Google 文字转语音旁的齿轮图标 ⚙️ → 安装语音数据 → 选择 **English (Australia)** 或您偏好的英文语音 → 下载
4. **检查媒体音量** —— TTS 使用**媒体**音频流，而非铃声。调高媒体音量，并确保手机未处于静音 / 仅振动模式。
5. **测试 TTS** —— 在 TTS 设置界面点击「播放」试听测试语句。若能听到，应用即可工作。

**语音故障排查：**

- **点麦克风无反应** —— 设备可能不支持语音识别。确保已安装 Google 应用并授予麦克风权限。
- **语音回复开关已开（🔊）但 Hermes 不发声** —— 多半是 Google TTS 未安装或未下载语音数据。请按上述 TTS 设置步骤操作。
- **Hermes 发音过轻或过快** —— 在设置 → 无障碍 → 文字转语音输出 中调整语速与音量。
- **识别不准** —— 清晰发音、减少背景噪音，并检查设备的系统语言是否包含英文。

### 会话列表

- 浏览所有 Hermes 会话。
- 点击会话打开其聊天。
- 下拉刷新会话列表。
- 从会话列表页头新建会话。

### 导航抽屉（☰）

访问这些由仪表盘驱动的页面：

- **记忆（Memory）** —— 查看跨会话的对话记忆。显示已存的事实、偏好与项目上下文。
- **定时任务（Cron Jobs）** —— 列出所有已调度定时任务。触发、暂停 / 恢复、创建、编辑或删除任务。
- **技能（Skills）** —— 浏览可用的 Hermes 技能及其描述与触发条件。
- **设置（Settings）** —— 查看并更改已配置的 Hermes 模型、主题偏好与详细模式。

### 主题

- 三态切换：**深色（Dark）** / **浅色（Light）** / **系统默认（System default）**。
- 深色模式下为金色 Hermes 强调色（`#D4AF37`）；浅色模式做了适配。

### 定时任务管理

定时任务页面支持完整 CRUD：

- **列出（List）** —— 查看所有任务及其状态（启用 / 禁用）、下次运行时间与调度。
- **创建（Create）** —— 点击 **+** 新增任务，含调度（cron 表达式或间隔）、提示词与可选技能。
- **编辑（Edit）** —— 点击任务修改其调度、提示词、技能或状态。
- **触发（Trigger）** —— 立即手动运行任务。
- **暂停 / 恢复（Pause/Resume）** —— 切换任务的启用状态。
- **删除（Delete）** —— 移除任务（需确认）。

## 开发

```bash
cd hermes-android
flutter pub get
flutter analyze
flutter test
flutter run -d android
```

## 构建发布版 APK

```bash
flutter clean
flutter pub get
flutter build apk --release --split-per-abi
mkdir -p release-apks
cp build/app/outputs/flutter-apk/app-*-release.apk release-apks/
```

输出文件：

```text
build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
build/app/outputs/flutter-apk/app-x86_64-release.apk
```

## 发布检查清单

每个发布 PR 在打标签或发布 APK 前，必须完成 [`CODE_QUALITY_CHECKLIST.md`](CODE_QUALITY_CHECKLIST.md)。该清单涵盖分析、架构、UX、安全、发布与手动冒烟测试检查。

最小发布流程：

1. 更新 `pubspec.yaml` 版本号。
2. 完成 `CODE_QUALITY_CHECKLIST.md`，并在发布 PR 中记录任何例外。
3. 构建分 ABI 的发布 APK。
4. 打发布标签，例如 `v1.0.0`。
5. 创建一个包含所有 APK 资源的 GitHub Release。
6. 在 GitHub 上确认仓库可见性与发布资源。

## 故障排查

### 能看到会话，但仪表盘抽屉页失败

聊天 / 会话功能使用端口 `8642`。记忆、定时任务、技能、设置 使用端口 `9119` 上的仪表盘。请用 `--host 0.0.0.0` 启动仪表盘，并确保端口 `9119` 通过 Wi-Fi 或 Tailscale 可达。

### 聊天因认证错误失败

检查安卓连接的 API 密钥是否与 Hermes 主机的 `API_SERVER_KEY`（`~/.hermes/.env`）一致。

### 应用找不到主机

- 确认手机与主机在同一 Wi-Fi 或同一 Tailscale tailnet。
- 先尝试原始 IP 而非主机名。
- 检查本地防火墙对端口 `8642` 与 `9119` 的规则。
- 在安卓上确保应用拥有网络权限（默认已授予）。

### 流式中断或消息不出现

- SSE 连接可能已超时。下拉刷新会话列表并重新进入聊天。
- 检查网关 API 服务是否正在运行且可响应：`curl http://<host>:8642/api/sessions`。
- 若使用反向代理，请确保它支持长连接 SSE（不要有过于激进的超时）。

### 仪表盘页面显示为空或报错

- 确认仪表盘以 `--host 0.0.0.0` 运行（开放仪表盘还需 `--insecure`）。
- 若仪表盘受密码保护，在 **⋮ → Dashboard / Proxy Settings（仪表盘 / 代理设置）** 中设置用户名 / 密码（或添加连接时的 **Custom proxy and dashboard details（自定义代理与仪表盘详情）**）。此处出现 401 表示凭据错误。
- 若仪表盘位于反向代理路径之后，设置 **Dashboard path prefix（仪表盘路径前缀）**。若代理注入了仪表盘认证，开启 **Dashboard behind proxy（仪表盘位于代理之后）**，让应用发送干净请求。
- 检查仪表盘端口与连接一致（本地 / Tailscale 默认 `9119`，托管为同一 HTTPS 端口；必要时在 Dashboard / Proxy Settings 中覆盖）。
- 仪表盘必须与网关 API 服务位于同一主机，应用的抽屉页才能访问到它。

### 语音听写或语音回复不工作

- **语音回复不工作** —— 安装 Google 文字转语音、设为默认引擎并下载英文语音数据。详见上文 [配置文字转语音](#配置文字转语音tts安卓)。
- **语音识别不工作** —— 确保已安装 Google 应用并授予麦克风权限（设置 → 应用 → Hermes → 权限 → 麦克风）。
- **语音回复开关关闭** —— 检查聊天输入框中的扬声器图标：🔊 = 开，🔇 = 关。点击可启用语音回复。
- **媒体音量为零** —— TTS 使用媒体音频流，而非铃声。在主屏用物理音量键调高媒体音量。
- **Hermes 能发声但音轻或过快** —— 在设置 → 无障碍 → 文字转语音输出 中调整语速与音量。

### Host 字段示例

应用接受以下任意形式，并在保存时做归一化：

```text
192.168.1.50
192.168.1.50:8642
http://192.168.1.50:8642
100.64.12.34
hermes-machine.tailnet-name.ts.net
https://your-hermes-host.example.com
https://your-hermes-host.example.com:8443
```

对于托管路径如 `https://your-hermes-host.example.com/profile/peter`，请将 `https://your-hermes-host.example.com` 作为主机、`/profile/peter` 作为 **Gateway path prefix（网关路径前缀）** 填入。

## 项目结构

```text
lib/
├── main.dart                          # 应用外壳、已存连接、导航抽屉
├── core/
│   ├── models/
│   │   ├── connection.dart            # SavedConnection 模型与主机归一化
│   │   └── session.dart               # Session 模型
│   ├── screens/
│   │   ├── session_list_screen.dart   # 会话浏览器
│   │   ├── chat_screen.dart           # 带 SSE 流式的聊天
│   │   ├── settings_screen.dart       # 模型 / 主题 / 应用设置
│   │   ├── memory_screen.dart         # 记忆查看器
│   │   ├── skills_screen.dart         # 技能浏览器
│   │   └── cron_screen.dart           # 定时任务管理器
│   ├── services/
│   │   ├── connection_manager.dart    # 已存连接、网关 API、仪表盘 API
│   │   └── ws_client.dart             # 供未来仪表盘 / TUI 使用的 JSON-RPC WebSocket 客户端
│   └── utils/
│       └── responsive.dart            # 手机 / 平板断点
└── assets/
    └── icon/
        └── icon.png                   # 应用图标源文件
```

## 贡献者

- **grunjol** —— 贡献 PR #68：反向代理路径前缀与代理后仪表盘支持。
- **sternbergm** —— 贡献 PR #67：密码保护仪表盘与可配置仪表盘端口。

## 许可证

MIT
