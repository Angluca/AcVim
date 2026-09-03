*lsp.txt*	语言服务器协议 (LSP) Vim9 插件

作者: Yegappan Lakshmanan  (yegappan AT yahoo DOT com)
适用于 Vim 9.0 及以上版本
最后更新: 2026年5月31日

==============================================================================
目录                                                         *lsp-contents*

     1. 概述 ................................... |lsp-overview|
     2. 安装 ................................... |lsp-installation|
     3. 使用 ................................... |lsp-usage|
       3.1 快速入门 ............................. |lsp-quick-start|
     4. 添加语言服务器 ......................... |lsp-server-add|
     5. 命令 ................................... |lsp-commands|
       5.1 导航（跳转和引用） .................. |lsp-navigation-cmds|
       5.2 预览（不跳转） ...................... |lsp-peek-cmds|
       5.3 符号与结构 .......................... |lsp-symbol-cmds|
       5.4 符号信息与文档 ...................... |lsp-symbol-info-cmds|
       5.5 代码修改与重构 ...................... |lsp-editing-cmds|
       5.6 层次结构（调用和类型） .............. |lsp-hierarchy-cmds|
       5.7 诊断信息（错误和警告） .............. |lsp-diag-cmds|
       5.8 服务器和工作区管理 .................. |lsp-server-cmds|
     6. 配置 ................................... |lsp-configuration|
     7. 插入模式补全 ........................... |lsp-ins-mode-completion|
       7.1. 无字符强制补全 ..................... |lsp-ins-force|
     8. 诊断信息 ............................... |lsp-diagnostics|
     9. 标签函数 ............................... |lsp-tagfunc|
    10. LSP 格式化 ............................. |lsp-format|
    11. 调用层次结构 ........................... |lsp-call-hierarchy|
    12. 自动命令 ............................... |lsp-autocmds|
    13. 高亮组 ................................. |lsp-highlight-groups|
    14. 语义高亮 ............................... |lsp-semantic-highlighting|
    15. 调试 ................................... |lsp-debug|
    16. 自定义命令处理器 ....................... |lsp-custom-commands|
    17. 自定义 LSP 请求 ........................ |lsp-custom-requests|
    18. 自定义 LSP 补全类型 .................... |lsp-custom-kinds|
    19. 自定义弹出框样式 ....................... |lsp-custom-popup-styles|
    20. 自定义位置请求 ......................... |lsp-custom-locations|
    21. 一个缓冲区的多个语言服务器 ............. |lsp-multiple-servers|
    22. 语言服务器功能 ......................... |lsp-features|
    23. 许可证 ................................. |lsp-license|

==============================================================================
							*lsp-overview*
1. 概述~

语言服务器协议 (LSP) 插件为 Vim9 提供了一个 LSP 客户端。

关于语言服务器协议的背景信息，请参阅：

    https://microsoft.github.io/language-server-protocol/
    https://langserver.org/

要求：
    - Vim 9.0 及以上版本
    - 为您使用的编程语言安装了语言服务器。
      请参阅上述页面获取可用服务器列表。

该插件的 Github 仓库位于：

      http://github.com/yegappan/lsp

==============================================================================
							*lsp-installation*
2. 安装~

您可以使用以下步骤直接从 github 安装此插件：

    $ git clone https://github.com/yegappan/lsp $HOME/.vim/pack/downloads/opt/lsp
    $ vim -u NONE -c "helptags $HOME/.vim/pack/downloads/opt/lsp/doc" -c q

或者，您可以使用任何 Vim 插件管理器（如 dein.vim、pathogen、vam、vim-plug、volt、Vundle 等）来安装和管理此插件。

卸载：
    - 如果使用插件管理器安装：使用其卸载命令。
    - 如果手动安装：删除 $HOME/.vim/pack/downloads/opt/lsp 目录。

激活：
要使用此插件，请在您的 .vimrc 文件中添加以下行：

    packadd lsp

==============================================================================
							*lsp-usage*
3. 使用~

插件工作流程包含三个部分：

1. 加载插件（例如使用 |:packadd|）。
2. 使用 |g:LspAddServer()| 注册一个或多个语言服务器。
3. 使用 LSP 命令，例如 |:LspGotoDefinition|、|:LspHover|、
   |:LspShowReferences| 和 |:LspCodeAction|。

							*lsp-quick-start*
3.1 快速入门~

使用以下最小设置快速上手： >

		vim9script

		# 1) 配置插件选项（可选）
		autocmd User LspSetup g:LspOptionsSet({
			autoHighlightDiags: true,
			showDiagInPopup: true,
		})

		# 2) 注册一个或多个语言服务器
		autocmd User LspSetup g:LspAddServer([{
			name: 'clangd',
			filetype: ['c', 'cpp'],
			path: 'clangd',
			args: ['--background-index']
		}])
<

打开该类型的文件，使用 |:LspShowAllServers| 验证服务器状态。然后尝试以下命令：

- |:LspHover| 显示符号文档。
- |:LspGotoDefinition| 跳转到定义。
- |:LspShowReferences| 列出引用。
- |:LspDiag| current 显示光标所在行的诊断信息。

有关按功能分组的所有命令的完整列表，请参阅 |lsp-commands|。

为了便于使用这些功能，建议在语言服务器附加到缓冲区时定义映射： >

    autocmd User LspAttached {
	nnoremap <buffer> <silent> gd <cmd>LspGotoDefinition<cr>
	nnoremap <buffer> <silent> K  <cmd>LspHover<cr>
	nnoremap <buffer> <silent> [d <cmd>LspDiag prev<cr>
	nnoremap <buffer> <silent> ]d <cmd>LspDiag next<cr>
	nnoremap <buffer> <silent> <leader>rn <cmd>LspRename<cr>
	nnoremap <buffer> <silent> <leader>ca <cmd>LspCodeAction<cr>
    }

    autocmd User LspDetached {
	silent! unmap <buffer> gd
	silent! unmap <buffer> K
	silent! unmap <buffer> [d
	silent! unmap <buffer> ]d
	silent! unmap <buffer> <leader>rn
	silent! unmap <buffer> <leader>ca
    }

==============================================================================
							*lsp-server-add*
4. 添加语言服务器~

要使用特定文件类型的插件功能，您需要首先为该文件类型注册一个语言服务器。

					*LspAddServer()* *g:LspAddServer()*
要注册一个或多个语言服务器，请在 .vimrc 文件中使用 LspAddServer() 函数配合语言服务器详情列表，或在加载插件前定义变量 |g:lsp_servers|。

要注册语言服务器，请在您的 .vimrc 文件中添加以下行（仅使用您需要的语言服务器）：
如果您使用 [vim-plug](https://github.com/junegunn/vim-plug) 安装 LSP 插件，具体步骤将在本节后面描述。 >

   vim9script
   var lspServers = [
		     {
			 name: 'typescriptls',
			 filetype: ['javascript', 'typescript'],
			 path: '/usr/local/bin/typescript-language-server',
			 args: ['--stdio']
		      },
		     {
			 name: 'pythonls',
			 filetype: 'python',
			 path: '/usr/local/bin/pyls',
			 args: ['--check-parent-process', '-v']
		      }
		   ]
   g:LspAddServer(lspServers)
<
根据您系统中安装的 typescript 和 python pyls 语言服务器的位置，请相应更新上述代码片段中的 "path"。

另一个示例，为 C、C++、Golang、Rust、Shell 脚本、Vim 脚本和 PHP 文件类型添加语言服务器： >

   vim9script
   var lspServers = [
		     {
			name: 'clangd',
		        filetype: ['c', 'cpp'],
		        path: 'clangd',
		        args: ['--background-index']
		     },
                     {
			name: 'golang',
                        filetype: ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
                        path: '/path/to/.go/bin/gopls',
                        args: [],
                        syncInit: true,
                      },
                     {
			name: 'rustls',
                        filetype: ['rust'],
                        path: '/path/to/.cargo/bin/rust-analyzer',
                        args: [],
                        syncInit: true,
                      },
		     {
			name: 'bashls',
			filetype: 'sh',
			path: '~/src/bash-language-server/bash-language-server',
			args: ['start']
		     },
		     {
			name: 'vimls',
			filetype: ['vim'],
			path: '/usr/local/bin/vim-language-server',
			args: ['--stdio']
		     },
		     {
			name: 'phpls',
		        filetype: ['php'],
		        path: '/usr/local/bin/intelephense',
		        args: ['--stdio'],
		        syncInit: true,
		        initializationOptions: {
		        licenceKey: 'xxxxxxxxxxxxxxx'
		        }
		      }
		   ]
   g:LspAddServer(lspServers)
<
添加语言服务器时，需要以下信息：

						*lsp-cfg-name*
	name		（可选）语言服务器的名称。可以是任意字符串。
			用于 LSP 消息和日志文件中。
						*lsp-cfg-path*
	path		语言服务器可执行文件的路径（不含参数）。
			该值会通过 |expandcmd()| 展开并在 $PATH 中查找。
			也可以使用完整路径。
						*lsp-cfg-args*
	args		传递给语言服务器的命令行参数列表。
			每个空格分隔的命令行参数作为列表的一个独立项。
						*lsp-cfg-filetype*
	filetype		该语言服务器支持的一种或多种文件类型。
			可以是 |String| 或 |List|。要指定多种文件类型，
			请使用 List。
					*lsp-cfg-initializationOptions*
	initializationOptions
			（可选）对于某些 LSP 服务器（如 intelephense），
			可能需要额外的初始化选项。这些选项可以在此字典中提供，
			如果存在，则会传递给 LSP 服务器。
						*lsp-cfg-workspaceConfig*
	workspaceConfig （可选）一个 |Dict| 值，将在初始化后作为
			"settings" 通过 "workspace/didChangeConfiguration"
			通知发送给语言服务器。
			请参阅语言服务器文档以了解此通知接受的配置值。
			此配置也用于响应语言服务器的
			"workspace/configuration" 请求消息。
						*lsp-cfg-rootSearch*
	rootSearch	（可选）用于定位工作区根路径或 URI 的文件和
			目录名称列表。"rootSearch" 中的目录名称必须以
			"/" 或 "\" 结尾。每个文件和目录名会在所有父目录
			中向上搜索。如果找到多个目录，则使用最接近当前
			缓冲区目录的目录作为工作区根。

			如果未指定此参数或未找到文件，则当前工作目录
			将作为子文件的工作区根，对于其他文件，则使用
			文件的父目录。

						*lsp-cfg-runIfSearch*
	runIfSearch	（可选）用于确定是否应运行服务器的文件和目录名称列表。
			与 |lsp-cfg-rootSearch| 类似。
			如果找到文件或目录，则启动服务器，否则不启动。

			如果未指定此参数或列表为空，则除非
			|lsp-cfg-runUnlessSearch| 阻止，否则启动服务器。

						*lsp-cfg-runUnlessSearch*
	runUnlessSearch	（可选）与 |lsp-cfg-runIfSearch| 相反。

此外还可以进行以下配置：

					*lsp-cfg-customNotificationHandlers*
	customNotificationHandlers
			（可选）某些 LSP 服务器（如 typescript-language-server）
			会发送额外的通知，您可能希望静默或处理它们。
			提供的通知处理程序将使用 "lspserver" 和 "reply"
			引用调用。 >

		vim9script
		g:LspAddServer([{
			filetype: ['javascript', 'typescript'],
			path: '/usr/local/bin/typescript-language-server',
			args: ['--stdio'],
			customNotificationHandlers: {
				'$/typescriptVersion': (lspserver, reply) => {
					echom printf("TypeScript Version = %s",
						reply.params.version)
				}
			}
		}])
<
					*lsp-cfg-customRequestHandlers*
	customRequestHandlers
			（可选）某些 LSP 服务器会发送额外的请求回复，
			您可能希望静默或处理它们。提供的请求处理程序将
			使用 "lspserver" 和 "request" 引用调用。

	features				*lsp-cfg-features*
			（可选）切换应为给定语言服务器启用哪些功能。
			参见 |lsp-multiple-servers| 和 |lsp-features|。

	forceOffsetEncoding			*lsp-cfg-forceOffsetEncoding*
			（可选）一个 |String| 值，强制在 LSP 消息中
			使用特定的偏移编码。如果未指定此选项，则在初始
			化期间与服务器协商 UTF 偏移编码。
			支持的值有 'utf-8'、'utf-16' 或 'utf-32'。
			Vim 原生偏移编码为 'utf-32'。对于 'utf-8' 和
			'utf-16' 编码，需要在每条 LSP 消息中对偏移量
			进行编码和解码，会产生一些开销。

	languageId				*lsp-cfg-languageId*
			（可选）通过指定一个函数或 lambda 来覆盖发送给
			语言服务器的 languageId，适用于 languageId 与
			filetype 不一致的情况。这对于以下服务器可能有用：

			https://github.com/docker/docker-language-server
			https://github.com/alesbrelih/gitlab-ci-ls

			示例：
>
		vim9script

		augroup dockercompose-yaml
		    autocmd!
		    autocmd BufEnter,BufReadPre docker-compose.yaml,docker-compose.yml setfiletype dockercompose.yaml
		augroup END

		def GetLanguageId(): string
		    if expand('%:t') =~# 'docker-compose' && &filetype =~# 'yaml'
			return 'dockercompose'
		    endif
		    return &filetype
		enddef

		g:LspAddServer([{
		    name: 'docker-language-server',
		    path: 'docker-language-server',
		    args: ['start', '--stdio'],
		    filetype: ['dockerfile', 'dockercompose.yaml'],
		    debug: v:true,
		    languageId: GetLanguageId,
		}])
<
			这确保了

			1. docker-language-server 适用于 docker-compose.yaml
			2. docker-language-server 适用于 Dockerfile
			3. docker-language-server 不会在任何 yaml 文件上启动

			不一定要采用这种方法，但它有助于组织自定义文件类型。

			另一种适用于此情况的方法是：
>
		augroup dockercompose
		    autocmd!
		    au BufEnter,BufRead docker-compose.yaml,docker-compose.yml set filetype=dockercompose
		    au BufEnter,BufRead docker-compose.yaml,docker-compose.yml set syntax=yaml
		augroup END

		g:LspAddServer([{
		    name: 'docker-language-server',
		    path: 'docker-language-server',
		    args: ['start', '--stdio'],
		    filetype: ['dockerfile', 'dockercompose'],
		    debug: v:true,
		}])
<
			在这两种情况下，yaml-language-server 也必须为新文件类型
			激活。不过，languageId 覆盖函数为用户处理类似情况
			提供了最大的灵活性。

						*lsp-cfg-omnicompl*
	omnicompl	（可选）一个布尔值，启用（true）或禁用（false）
			这些文件类型的全能补全。默认值为 "v:true"。
			此值仅在自动补全被禁用时才适用
			（|lsp-opt-autoComplete|）。

						*lsp-cfg-processDiagHandler*
	processDiagHandler
			（可选）一个 |Funcref| 或 |lambda|，接受语言服务器
			诊断列表并返回新的过滤或修改后的诊断列表。
			可用于移除不需要的诊断、为诊断文本添加前缀等。
			以下示例将移除除错误和警告之外的所有诊断： >

		vim9script
		g:LspAddServer([{
			filetype: ['javascript', 'typescript'],
			path: '/usr/local/bin/typescript-language-server',
			args: ['--stdio'],
			processDiagHandler: (diags: list<dict<any>>) => {
				# 只包含错误和警告
				return diags->filter((ix, diag) => {
					return diag.severity <= 2
				})
			},
		}])
<
			此示例将为诊断消息添加前缀 "TypeScript: "： >

		vim9script
		g:LspAddServer([{
			filetype: ['javascript', 'typescript'],
			path: '/usr/local/bin/typescript-language-server',
			args: ['--stdio'],
			processDiagHandler: (diags: list<dict<any>>) => {
				return diags->map((ix, diag) => {
					diag.message = $'TypeScript: {diag.message}'
					return diag
				})
			},
		}])
<
						*lsp-cfg-syncInit*
	syncInit        （可选）对于初始化耗时且回复 "initialize" 请求
			消息较慢的语言服务器（如 rust analyzer、gopls 等），
			应将其设置为 "true"。如果设置为 true，则使用同步
			调用来初始化语言服务器，否则异步初始化服务器。
			默认值为 "false"。

						*lsp-cfg-debug*
	debug		（可选）将此语言服务器在 stdout 和 stderr 中打印的
			消息记录到文件。用于调试语言服务器。
			默认情况下不记录消息。参见 |lsp-debug|。

						*lsp-cfg-traceLevel*
	traceLevel	（可选）设置此语言服务器的调试跟踪级别。
			支持的值有："off"、"debug" 和 "verbose"。
			默认值为 "off"。

语言服务器使用 LspAddServer() 函数添加。该函数接受一个包含以上信息的语言服务器列表。

如果您使用 [vim-plug](https://github.com/junegunn/vim-plug) 安装 LSP 插件，则需要使用 LspSetup User 自动命令来初始化语言服务器和设置语言服务器选项，或者您可以设置变量 |g:lsp_servers|。例如： >

    vim9script

    var lspOpts = {autoHighlightDiags: true}
    autocmd User LspSetup LspOptionsSet(lspOpts)

    var lspServers = [
		     {
		        name: 'clangd',
		        filetype: ['c', 'cpp'],
		        path: '/usr/local/bin/clangd',
		        args: ['--background-index']
		      }
		   ]
    autocmd User LspSetup LspAddServer(lspServers)
<
				    *LspServerReady()* *g:LspServerReady()*
g:LspServerReady() 函数在当前缓冲区附加的所有语言服务器完成初始化并可接受请求时返回 |v:true|。如果没有当前文件、没有附加语言服务器或一个或多个附加服务器仍在初始化，则返回 |v:false|。

				    *LspServerRunning()* *g:LspServerRunning()*
g:LspServerRunning({filetype}) 函数在注册给 {filetype} 的一个或多个语言服务器当前正在运行时返回 |v:true|。

==============================================================================
							*lsp-commands*
5. 命令~

本插件提供以下命令。这些命令的详细描述将在后面提供。

:LspCodeAction		请求所有附加到当前缓冲区的合格语言服务器
			为当前行提供代码操作，并应用所选操作。
:LspAutoFix		为当前行或用户指定范围请求代码操作，并
			自动为每个诊断应用首选操作。
:LspFixAll [query]	从所有合格语言服务器为当前文件请求
			source.fixAll 代码操作，并应用所选操作。
:LspOrganizeImports [query]
			从所有合格语言服务器为当前文件请求
			source.organizeImports 代码操作，并应用所选操作。
:LspCodeLens		显示当前文件可用的所有代码镜头命令，
			并应用所选命令。
:LspDiag current	显示当前行的诊断消息。
:LspDiag first		跳转到当前缓冲区的第一条诊断消息。
:LspDiag here		跳转到当前行内的诊断消息。
:LspDiag highlight disable
			禁用当前 Vim 会话中带有诊断消息的行的
			高亮显示。
:LspDiag highlight enable
			启用当前 Vim 会话中带有诊断消息的行的
			高亮显示。
:LspDiag highlight toggle
			切换当前 Vim 会话中带有诊断消息的行的
			高亮显示。
:LspDiag last		跳转到当前缓冲区的最后一条诊断消息。
:LspDiag next		跳转到当前光标位置之后的下一条诊断消息。
:LspDiag nextWrap	跳转到当前光标位置之后的下一条诊断消息。
			在没有更多消息时回绕到第一条消息。
:LspDiag prev		跳转到当前光标位置之前的诊断消息。
:LspDiag prevWrap	跳转到当前光标位置之前的诊断消息。
			在没有前一条消息时回绕到最后一条消息。
:LspDiag show		在位置列表中显示语言服务器为当前缓冲区
			提供的诊断消息。
:LspDocumentSymbol	在弹出菜单中显示当前文件中的符号，并跳转到
			所选符号的位置。
:LspFold		使用语言服务器的折叠范围在当前缓冲区中
			创建折叠。
:LspFormat		使用语言服务器格式化当前文件中的一行范围。
			默认范围为整个文件。参见 |lsp-format|。
:LspGotoDeclaration	跳转到光标下符号的声明处。
:LspGotoDefinition	跳转到光标下符号的定义处。
:LspGotoImpl		跳转到光标下符号的实现处。
:LspGotoTypeDef		跳转到光标下符号的类型定义处。
:LspHighlight		高亮光标下关键字的所有匹配项。
:LspHighlightClear	清除由 :LspHighlight 高亮的所有匹配项。
:LspHover		在弹出窗口中显示光标下符号的文档。
:LspIncomingCalls	在窗口中显示当前符号的传入调用层次结构。
:LspInlayHints		启用、禁用或切换内联提示。
:LspOutgoingCalls	在窗口中显示当前符号的传出调用层次结构。
:LspOutline		在单独窗口中显示当前文件中定义的符号列表。
:LspPeekDeclaration	在弹出窗口中打开光标下符号的声明。
:LspPeekDefinition	在弹出窗口中打开光标下符号的定义。
:LspPeekImpl		在弹出窗口中打开光标下符号的实现。
:LspPeekReferences	在弹出窗口中显示光标下符号的引用列表。
:LspPeekTypeDef		在弹出窗口中打开光标下符号的类型定义。
:LspRename		重命名当前符号。
:LspSelectionExpand	展开当前符号范围的视觉选择。
:LspSelectionShrink	收缩当前符号范围的视觉选择。
:LspServer		显示语言服务器的状态和消息，并重启语言服务器。
:LspShowAllServers	显示所有已注册语言服务器的状态。
:LspShowReferences	在新的位置列表中显示光标下关键字的引用列表。
:LspShowSignature	显示光标下符号的签名。
:LspSubTypeHierarchy	在弹出窗口中显示子类型层次结构。
:LspSuperTypeHierarchy	在弹出窗口中显示超类型层次结构。
:LspSwitchSourceHeader	在源文件和头文件之间切换。
:LspSymbolSearch	在工作区范围内搜索符号。
:LspWorkspaceAddFolder {folder}
			向工作区添加文件夹。
:LspWorkspaceListFolders
			显示工作区中的文件夹列表。
:LspWorkspaceRemoveFolder {folder}
			从工作区移除文件夹。

							*lsp-navigation-cmds*
5.1 导航（跳转和引用）~

用于通过跳转到定义或列出符号所有引用位置来导航代码库的命令。

							*:LspGotoDeclaration*
:[count]LspGotoDeclaration
			跳转到光标下符号的声明处。此命令的行为
			类似于 |:LspGotoDefinition| 命令。

							*:LspGotoDefinition*
:[count]LspGotoDefinition
			跳转到光标下符号的第 [count] 个定义处。
			如果有多个匹配且未指定 [count]，则会创建
			一个包含所有位置的位置列表。

			如果只有一个位置，或提供了 [count]，则
			适用以下规则：

			如果文件已在一个窗口中打开，则跳转到该窗口。
			否则，在新窗口中打开文件。如果当前缓冲区已修改
			且 'hidden' 未设置，或当前缓冲区是特殊缓冲区，
			则打开新窗口。如果跳转成功，当前光标位置会被
			推入标签栈。可以使用 |CTRL-T| 命令返回标签栈。
			此外，|``| 标记会设置为跳转前的位置。

			此命令支持 |:command-modifiers|。您可以使用修饰符
			指定是否使用新窗口或新标签页，以及窗口打开的位置。
			示例： >

			    # 打开水平分割窗口
			    :topleft LspGotoDefinition
			    # 打开垂直分割窗口
			    :vert LspGotoDefinition
			    # 打开新标签页
			    :tab LspGotoDefinition
<
			您可能想要映射一个按键来调用此命令： >

	    nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
	    nnoremap <buffer> <C-W>gd <Cmd>topleft LspGotoDefinition<CR>
<
			或者如果您想支持 [count]gd： >

	    nnoremap <buffer> gd <Cmd>execute v:count .. 'LspGotoDefinition'<CR>
	    nnoremap <buffer> <C-W>gd <Cmd>execute 'topleft ' .. v:count .. 'LspGotoDefinition'<CR>
<

			如果启用了 definitionFallback（默认禁用），
			则回退到 |:tjump|。参见 |lsp-opt-definitionFallback|。

							*:LspGotoImpl*
:[count]LspGotoImpl	跳转到光标下符号的实现处。此命令的行为
			类似于 |:LspGotoDefinition| 命令。请注意，
			并非所有语言服务器都支持此功能。

			您可能想要映射一个按键来调用此命令： >

			    nnoremap <buffer> gi <Cmd>LspGotoImpl<CR>
<
							*:LspGotoTypeDef*
:[count]LspGotoTypeDef	跳转到光标下符号的类型定义处。此命令的行为
			类似于 |:LspGotoDefinition| 命令。请注意，
			并非所有语言服务器都支持此功能。

			您可能想要映射一个按键来调用此命令： >

			    nnoremap <buffer> gt <Cmd>LspGotoTypeDef<CR>
<
							*:LspShowReferences*
:LspShowReferences	创建一个新的位置列表，列出光标下符号被引用的
			所有位置，并打开位置窗口。如果希望在快速修复
			列表中而不是位置列表中显示引用，请设置： >

			LspOptionsSet({'useQuickfixForLocations': true})
<
							*:LspSwitchSourceHeader*
:LspSwitchSourceHeader	在源文件和头文件之间切换。这是 Clangd 特有的
			扩展，仅适用于 C/C++ 源文件。

------------------------------------------------------------------------------
							*lsp-peek-cmds*
5.2 预览（不跳转）~

用于在弹出窗口中查看符号详细信息，同时保持光标在缓冲区中当前位置的命令。

							*:LspPeekDeclaration*
:[count]LspPeekDeclaration
			在弹出窗口中显示光标下符号声明的行。此命令
			的行为类似于 |:LspPeekDefinition| 命令。

							*:LspPeekDefinition*
:[count]LspPeekDefinition
			在弹出窗口中显示光标下符号定义的行。符号在
			弹出窗口中被高亮显示。
			当找到多个符号时，它们都会被显示。符号对应的
			文件会在另一个弹出窗口中显示。当符号弹出菜单
			中的选择改变时，弹出窗口中的文件会更新。
			当提供 [count] 时，只显示第 [count] 个符号。

							*lsp-symbol-window*
			移动光标或按 <Esc> 将关闭弹出窗口。在弹出
			窗口中，可以使用以下按键：

				CTRL-F     - 向下翻一页
				<PageDown> - 同上
				CTRL-B     - 向上翻一页
				<PageUp>   - 同上
				CTRL-Home  - 跳转到第一个条目
				CTRL-End   - 跳转到最后一个条目
				<Esc>      - 关闭弹出窗口
				CTRL-C     - 同上
				CTRL-E     - 向下滚动一行
				CTRL-D     - 向下滚动半页
				CTRL-Y     - 向上滚动一行
				CTRL-U     - 向上滚动半页

			如果启用了 definitionFallback（默认禁用），
			则回退到 |:ptjump|。
			参见 |lsp-opt-definitionFallback|。

							*:LspPeekImpl*
:[count]LspPeekImpl	在弹出窗口中显示光标下符号的实现处。此命令
			的行为类似于 |:LspPeekDefinition| 命令。
			请注意，并非所有语言服务器都支持此功能。

							*:LspPeekReferences*
:LspPeekReferences	在弹出菜单中显示光标下符号的引用列表。
			引用对应的文件会在另一个弹出窗口中显示。
			当引用弹出菜单中的选择改变时，弹出窗口中的
			文件会更新。

							*:LspPeekTypeDef*
:[count]LspPeekTypeDef	在弹出窗口中显示光标下符号类型定义的行。
			此命令的行为类似于 |:LspPeekDefinition| 命令。
			请注意，并非所有语言服务器都支持此功能。

------------------------------------------------------------------------------
							*lsp-symbol-cmds*
5.3 符号与结构~

用于搜索符号或查看文件或整个工作区逻辑结构的命令。

							*:LspDocumentSymbol*
:LspDocumentSymbol	在弹出菜单中显示当前文件中的符号。当在弹出
			菜单中选择一个符号并按下 <Enter> 或 <Space> 时，
			跳转到该符号的位置。

			可以使用 <Up>、<Down>、<Tab>、<S-Tab>、<C-N>、
			<C-P>、<ScrollWheelUp>、<ScrollWheelDown> 键来
			一次滚动一个菜单项。<PageUp> 和 <PageDown> 可以
			滚动一页弹出窗口，而 <C-F> 和 <C-B> 可以滚动一页
			底层窗口。<Esc> 或 <Ctrl-C> 可以取消弹出菜单。

			如果输入了一个或多个关键字字符，则仅显示包含
			这些关键字字符的符号。使用模糊搜索来获取匹配
			符号列表。<BS> 键可以擦除最后输入的字符。
			<C-U> 键可以擦除所有字符。

			在弹出菜单中滚动符号时，对应的行范围会被高亮。

							*:LspOutline*
:[count]LspOutline [ {open | close | toggle} ]
			打开一个名为 "LSP-Outline" 的垂直分割窗口，
			显示当前文件中定义的符号列表。
			支持 "open"、"close" 和 "toggle" 参数。
			如果未给出参数，默认为 "open"。

			窗口头部显示文件名及其父目录。符号按其类型
			（例如，函数、变量）分组，子级缩进显示在其
			父类型下。使用基于缩进的折叠创建折叠；默认
			展开最多四级。

			在大纲窗口中可使用以下按键：
			<CR>	  跳转到源文件中选定的符号。
				  如果文件已在窗口中打开，则重用该窗口；
				  否则在最近的普通缓冲区窗口中打开文件，
				  或创建新的分割窗口。
			p	  在源文件窗口中居中预览符号，但将光标
				  保持在大纲窗口。
			K	  显示光标下符号的详细信息。
			Z	  最大化或最小化（切换）大纲窗口大小。
			q	  关闭大纲窗口。

			当前符号使用 |Search| 高亮组高亮，并在源文件
			中光标闲置时（|CursorHold|）更新。切换到不同
			文件会使用新文件的符号更新大纲窗口。

			您可以使用 |lsp-opt-outlineOnRight| 和
			|lsp-opt-outlineWinSize| 自定义窗口的位置和大小。

			此命令也支持 |:command-modifiers|。您可以使用
			修饰符指定窗口的位置。注意，默认为
			":vert :topleft" 或 ":vert :botright"，
			取决于 |lsp-opt-outlineOnRight|。

			此命令也支持提供 [count] 来指定窗口大小。
			注意，这会覆盖 |lsp-opt-outlineWinSize| 中
			定义的值。
			示例： >

			    # 在当前窗口上方打开大纲窗口
			    :aboveleft LspOutline

			    # 在当前窗口旁边打开大纲窗口，这与默认不同，
			    # 当您已有多个分割时
			    :vert aboveleft LspOutline

			    # 同上，但宽度为50
			    :vert aboveleft 50LspOutline
<
							*:LspSymbolSearch*
:LspSymbolSearch <sym>	在工作区范围内搜索符号 <sym>。
			如果未提供 <sym>，则会提示您输入符号名称
			（默认使用光标下的关键字）。如果只有一个匹配
			符号，光标将定位到符号位置。否则会打开一个
			弹出窗口，显示匹配符号列表。您可以输入几个
			字符来缩小匹配范围。可以通过按 <Backspace> 或
			<C-U> 擦除显示的符号名称，并输入新的符号搜索
			模式。可以通过按 Escape 键或 CTRL-C 关闭弹出
			菜单。

			在弹出菜单中，可以使用以下按键：

				CTRL-F     - 向下翻一页
				<PageDown> - 同上
				CTRL-B     - 向上翻一页
				<PageUp>   - 同上
				CTRL-Home  - 跳转到第一个条目
				CTRL-End   - 跳转到最后一个条目
				<Up>       - 向上移动一个条目
				<C-P>      - 同上
				<Down>     - 向下移动一个条目
				<C-N>      - 同上
				<Enter>    - 打开选中的文件
				<Esc>      - 关闭弹出菜单
				<CTRL-C>   - 同上
				<BS>       - 从过滤文本中擦除一个字符
				<C-H>      - 同上
				<C-U>      - 擦除过滤文本

			任何其他字母数字键将用于缩小弹出菜单中显示
			的名称列表。当您输入过滤字符串时，仅显示模糊
			匹配该字符串的符号。您可以输入新的搜索模式来
			执行工作区范围的符号搜索。

			此命令接受 |:command-modifiers|，可用于在水平或
			垂直分割窗口或新标签页中跳转到符号： >

				:topleft LspSymbolSearch foo
				:vert LspSymbolSearch bar
				:tab LspSymbolSearch baz
<
------------------------------------------------------------------------------
							*lsp-symbol-info-cmds*
5.4 符号信息与文档~

用于显示光标下符号的文档、函数签名和其他元数据的命令。

							*:LspHighlight*
:LspHighlight		高亮光标下符号的所有匹配项。符号的文本、
			读取和写入引用分别使用 Search、DiffChange 和
			DiffDelete 高亮组高亮。

							*:LspHighlightClear*
:LspHighlightClear	清除由 |:LspHighlight| 命令高亮的所有符号
			匹配项。

							*:LspHover*
:LspHover		在弹出窗口中显示光标下符号的文档。

			悬停内容可以是纯文本或 Markdown。Markdown 内容
			（包括代码块）使用 |lspgfm| 文件类型进行渲染。

			在弹出模式下，可以使用以下按键滚动弹出窗口：

			    <CTRL-E> - 向下滚动一行。
			    <CTRL-D> - 向下滚动 'scroll' 行数。
			    <CTRL-F> - 向下翻一页。
			    <PageDown> - 同上。
			    <CTRL-Y> - 向上滚动一行。
			    <CTRL-U> - 向上滚动 'scroll' 行数。
			    <CTRL-B> - 向上翻一页。
			    <PageUp> - 同上。
			    <CTRL-Home> - 跳转到第一行。
			    <CTRL-End>  - 跳转到最后一行。
			    <Esc>       - 关闭弹出窗口。
			    <CTRL-C>    - 同上。

			点击弹出窗口也会关闭它。在正常使用中，移动光标
			或使用其他按键会关闭它。

			您可以在弹出模式下按 |K| 将弹出窗口移动到预览
			窗口。

			如果您希望始终在 |preview-window| 中显示符号
			文档而非弹出窗口，请设置： >

			    LspOptionsSet({'hoverInPreview': true})
<
			您可以使用 |:pclose| 命令关闭预览窗口。预览缓冲
			区名为 "LspHover"。

			要使用 |K| 进行悬停请求，直接映射： >

			    nnoremap K <Cmd>LspHover<CR>
<
			如果您启用 |lsp-opt-hoverFallback|，请保持
			'keywordprg' 设置为您的常规文件类型特定程序
			（例如，Vim 帮助缓冲区的 |:help|），而不是
			将其设置为 |:LspHover|。

			此命令支持 |:command-modifiers|。使用 |:silent|
			可以抑制 "No documentation found" 警告消息。

			如果启用了 |lsp-opt-hoverOnCursorHold|，则当
			光标闲置时（|CursorHold|）会自动请求悬停文档。
			请求使用 |lsp-opt-hoverDelay| 进行去抖。

			如果启用了 hoverFallback（默认禁用），则回退
			到文件类型特定的 'keywordprg'。
			参见 |lsp-opt-hoverFallback|。

			弹出窗口外观可以使用 |lsp-opt-popup-Hover| 和
			全局弹出选项进行自定义。

							*:LspInlayHints*
:LspInlayHints {enable | disable | toggle}
			全局启用、禁用或切换内联提示。
			支持 "enable"、"disable" 和 "toggle" 参数。
			参数是必需的。
			当指定 "enable" 时，将 |lsp-opt-showInlayHints|
			设置为 true，并为所有已打开缓冲区中附加了
			支持 inlayHint 能力的语言服务器的缓冲区激活
			内联提示。
			当指定 "disable" 时，将 |lsp-opt-showInlayHints|
			设置为 false，并立即从所有打开的缓冲区中移除
			所有内联提示。
			当指定 "toggle" 时，根据当前状态启用或禁用
			内联提示。

							*:LspShowSignature*
:LspShowSignature	显示光标处符号（例如函数或方法）的签名，
			显示参数信息。

			当启用 |lsp-opt-showSignature|（默认为 true）
			时，在插入模式下键入触发字符（通常为 '(' 或 ','）
			时会自动显示签名。签名弹出窗口会高亮显示活动
			参数，帮助您了解当前正在键入的参数。在签名
			会话处于活动状态时，插件可以在支持的重新触发
			字符上以及插入模式光标/文本更改时重新触发
			签名帮助，从而使显示的调用签名跟踪当前编辑
			位置。

			如果符号有多个签名（重载），插件会显示计数
			指示器，如 "(1/3)"，显示您正在查看的重载。

			默认情况下，签名在光标附近的弹出窗口中显示。
			您可以将此行为更改为在命令行中回显签名： >

			LspOptionsSet({'echoSignature': true})
<
			回显时，活动参数会以不同颜色高亮
			（|LspSigActiveParameter|）。

			默认情况下，仅显示短签名标签。启用
			|lsp-opt-showSignatureDocs| 可在弹出窗口或
			回显输出中包含参数和签名文档。当启用文档且
			服务器返回 markdown 内容时，弹出窗口使用配置
			的 markdown 渲染支持。

			禁用自动签名显示： >

			LspOptionsSet({'showSignature': false})
<
			您仍然可以使用 |:LspShowSignature| 命令或
			自定义映射手动调用签名。

			在签名标签旁显示文档： >

			LspOptionsSet({'showSignatureDocs': true})
<
			使用 |lsp-opt-popup-SignatureHelp| 选项自定义
			签名弹出窗口外观。

------------------------------------------------------------------------------
							*lsp-editing-cmds*
5.5 代码修改与重构~

用于使用语言服务器修改、重命名或格式化代码的命令。

							*:LspCodeAction*
:LspCodeAction [query]	从所有附加到当前缓冲区的合格语言服务器中，
			为当前行请求代码操作。如果使用范围调用
			（例如在可视模式下），则为该行范围请求代码
			操作。

			所选行/范围的诊断信息会包含在代码操作
			上下文中。即使没有诊断信息，当服务器提供
			源代码或其他上下文无关操作时，操作仍然可用。

			当给出 [query] 时，直接选择一个操作：
			- 数字（例如 "2"）按 1 基索引选择，
			- 以 "/" 开头的文本被视为正则表达式，
			- 其他文本匹配操作标题前缀。
			- 以 "only:" 或 "kind:" 开头的文本使用
			  CodeActionContext.only 在服务器端过滤操作。

			对于请求端过滤，使用以下之一： >

				only:<kind[,kind...]>
				kind:<kind[,kind...]>
<
			您可以附加 "#<selector>" 从过滤结果中直接选择
			（例如 "only:quickfix#1" 或 "kind:source.fixAll#/fix"）。
			[query] 中的前导和尾随空格将被忽略。

			如果未给出 [query]，则会提示您选择一个操作
			（根据 |lsp-opt-usePopupInCodeAction| 使用弹出
			菜单或 |inputlist()|）。所有合格语言服务器的
			操作会合并显示在一个列表中。

			首选操作会首先显示。首选操作会以 "*" 为前缀。
			菜单项包含操作类型。

			如果两个或多个操作具有相同标题，则会将源服务器
			名称附加到这些菜单项以消除歧义。

			在关联命令执行之前，会先应用 CodeAction 编辑。
			所选操作始终由提供该操作的语言服务器解析/执行。

			使用 |:LspFixAll| 和 |:LspOrganizeImports| 可以对
			当前文件执行专门的源代码操作。

							*:LspAutoFix*

:LspAutoFix		从所有附加到当前缓冲区的合格语言服务器中，
			为当前行或指定范围（通过可视选择或 Ex 范围）
			请求代码操作。

			对于严格在范围内的每个诊断（从下到上排序）：
			- 为诊断的行请求代码操作。
			- 筛选标记为 isPreferred 且与诊断相关的操作。
			- 如果有多个首选操作，提示用户选择一个
			  （根据 |lsp-opt-usePopupInCodeAction| 使用弹出
			  菜单或 |inputlist()|）。
			  使用弹出模式时，按 <Esc> 取消当前诊断选择，
			  并继续处理范围内的下一个诊断。按 <C-C> 取消
			  弹出窗口并停止应用更多诊断。
			- 如果诊断没有首选操作，则跳过。
			- 应用所选的首选操作。
			- 如果应用代码操作时发生错误，停止进一步处理。

			如果未使用范围调用，默认使用当前行。

			如果在范围内未找到诊断，则显示警告消息。

							*:LspFixAll*
:LspFixAll [query]	从所有附加到当前缓冲区的合格语言服务器中，
			为当前文件请求 only:source.fixAll 代码操作，
			并直接应用一个操作。

			如果省略 [query]，则应用第一个匹配操作
			（等同于 "only:source.fixAll#1"）。

			如果提供了 [query]，则用作过滤后操作的选择器
			（例如 "/fix" 或 "2"）。

						*:LspOrganizeImports*
:LspOrganizeImports [query]
			从所有附加到当前缓冲区的合格语言服务器中，
			为当前文件请求 only:source.organizeImports 代码
			操作，并直接应用一个操作。

			如果省略 [query]，则应用第一个匹配操作
			（等同于 "only:source.organizeImports#1"）。

			如果提供了 [query]，则用作过滤后操作的选择器。

							*:LspCodeLens*
:LspCodeLens		显示当前缓冲区可用的代码镜头命令列表，
			并应用所选代码镜头命令。

							*:LspFold*
:LspFold		为当前缓冲区创建折叠。

			此命令需要支持 |lsp-features-foldingRange| 的
			服务器。

			当前缓冲区必须使用 'foldmethod=manual'。
			如果不是，命令会失败并报错。

			在创建新折叠之前，当前窗口中的现有手动折叠
			会被清除（相当于 |zE|）。

			如果未返回折叠范围，则不创建折叠。

			如果 'foldcolumn' 为 0，此命令会将其设置为 2，
			以便创建的折叠可见。

							*:LspFormat*
:LspFormat		使用语言服务器格式化当前文件。格式化时
			会使用当前缓冲区的 'shiftwidth' 和 'expandtab'
			值。
			如果启用了 formatFallback（默认禁用），则回退
			到 |gq|。参见 |lsp-opt-formatFallback|。

:{range}LspFormat	使用语言服务器格式化当前文件中指定的行范围。
			在普通模式下映射 <plug>(LspFormat) 以操作文本
			对象。
			如果启用了 formatFallback（默认禁用），则回退
			到 |gq|。参见 |lsp-opt-formatFallback|。

							*:LspRename*
:LspRename [newName]	重命名当前符号。

			如果未给出 [newName]，则会提示您输入符号的
			新名称。提示会预填光标下的当前单词。
			您可以按 <Esc> 或在提示中输入空字符串来取消
			操作。

			此命令需要支持 |lsp-features-rename| 的服务器。
			如果不支持重命名，则会显示错误并且不发送请求。

							*:LspSelectionExpand*
:LspSelectionExpand	使用语言服务器在光标位置的选择范围层次结构
			开始一个字符视觉选择。

			如果在可视模式下再次调用，仅当当前视觉选择
			仍与同一缓冲区的先前返回的 LSP 范围匹配时，
			才会扩展到下一个父范围。否则，从光标位置开始
			新的选择范围请求。

			例如，如果光标位于 "for" 语句上，此命令可以
			首先选择该语句，然后扩展以包含封闭块。

			这对于创建用于重复扩展的视觉映射很有用。
			示例： >

			xnoremap <silent> <Leader>e <Cmd>LspSelectionExpand<CR>
<
			通过上述映射，您可以在可视模式下连续按 "\e"
			来扩展当前符号视觉区域。

							*:LspSelectionShrink*
:LspSelectionShrink	将当前字符视觉选择收缩到上一次 LSP 选择
			范围链中的前一级别。

			如果没有与当前缓冲区的先前 LSP 派生选择状态
			匹配的内容，则从光标位置开始新的选择范围
			请求。

			这对于创建用于重复收缩的视觉映射很有用。
			示例： >

			xnoremap <silent> <Leader>s <Cmd>LspSelectionShrink<CR>
<
			通过上述映射，您可以在可视模式下连续按 "\s"
			来收缩当前符号视觉区域。

------------------------------------------------------------------------------
							*lsp-hierarchy-cmds*
5.6 层次结构（调用和类型）~

用于探索函数调用者/被调用者或类和接口层次结构之间深层关系的
命令。

							*:LspIncomingCalls*
:LspIncomingCalls	在窗口中显示光标下符号的传入调用层次结构。
			传入调用是调用当前符号的符号。层次结构显示
			在名为 "LSP-CallHierarchy" 的临时窗口中。
			顶行显示当前模式，下方的树从所选符号及其
			调用者开始。

			有关导航以及层次结构窗口中可用的缓冲区本地
			命令，请参见 |lsp-call-hierarchy|。请注意，
			并非所有语言服务器都支持此功能。

							*:LspOutgoingCalls*
:LspOutgoingCalls	在窗口中显示光标下符号的传出调用层次结构。
			传出调用是当前符号调用的符号。层次结构显示
			在名为 "LSP-CallHierarchy" 的临时窗口中。
			顶行显示当前模式，下方的树从所选符号及其
			被调用者开始。

			有关导航以及层次结构窗口中可用的缓冲区本地
			命令，请参见 |lsp-call-hierarchy|。请注意，
			并非所有语言服务器都支持此功能。

							*:LspSubTypeHierarchy*
:LspSubTypeHierarchy	显示光标下符号的子类型层次结构。子类型是
			从当前类型派生（或实现）的类型。层次结构以
			树的形式显示在弹出窗口中，子类型缩进显示在
			其父类型下。另一个弹出窗口显示当前高亮类型
			的源位置。在层次结构中导航时，文件弹出窗口
			会自动更新。

			使用 j/k 导航。按 Enter 跳转到类型定义
			（当前位置首先保存到 |tagstack|，以便您可以
			使用 CTRL-T 返回）。按 Esc 关闭弹出窗口而不
			跳转。

			另请参阅 |:LspSuperTypeHierarchy|。

							*:LspSuperTypeHierarchy*
:LspSuperTypeHierarchy	显示光标下符号的超类型层次结构。超类型是
			当前类型派生的基类型（父类或接口）。层次结构
			以树的形式显示在弹出窗口中，祖先类型缩进显示
			在当前类型下。另一个弹出窗口显示当前高亮类型
			的源位置。在层次结构中导航时，文件弹出窗口
			会自动更新。

			使用 j/k 导航。按 Enter 跳转到类型定义
			（当前位置首先保存到 |tagstack|，以便您可以
			使用 CTRL-T 返回）。按 Esc 关闭弹出窗口而不
			跳转。

			另请参阅 |:LspSubTypeHierarchy|。

------------------------------------------------------------------------------
							*lsp-diag-cmds*
5.7 诊断信息（错误和警告）~

用于导航和查看语言服务器报告的错误、警告和提示消息的命令。

					*:LspDiag-current* *:LspDiagCurrent*
:LspDiag current	显示当前行的诊断消息（如果有）。如果选项
			'showDiagInPopup' 设置为 true（默认），则消息
			显示在弹出窗口中。否则消息显示在状态消息
			区域。

			当前行有多个诊断时，此命令会选择起始位置
			在光标处或右侧的第一个诊断；如果没有匹配，
			则选择行上的最后一个诊断。

:LspDiag! current	仅在诊断消息直接位于光标下时显示。
			否则与 ":LspDiag current" 完全相同。

			要在移动时显示光标下的当前诊断，可以使用
			以下自动命令： >

			    augroup LspCustom
			      au!
			      au CursorMoved * silent! LspDiag! current
			    augroup END
<
						*:LspDiag-first* *:LspDiagFirst*
:LspDiag first		跳转到当前文件的第一条诊断消息位置。

						*:LspDiag-here* *:LspDiagHere*
:LspDiag here		跳转到当前行中的诊断消息位置（从当前列开始）。

:LspDiag highlight disable			*:LspDiag-highlight-disable*
			禁用当前 Vim 会话中带有诊断消息的行的高亮
			显示。
			要永久禁用高亮，请将 autoHighlightDiags 选项
			设置为 false。

:LspDiag highlight enable			*:LspDiag-highlight-enable*
			启用当前 Vim 会话中带有诊断消息的行的高亮
			显示。注意，默认情况下会启用带有诊断消息的
			行的高亮。

:LspDiag highlight toggle			*:LspDiag-highlight-toggle*
			切换（启用或禁用）当前 Vim 会话中所有缓冲区
			带有诊断消息的行的高亮。

						*:LspDiag-last* *:LspDiagLast*
:LspDiag last		跳转到当前文件的最后一条诊断消息位置。

						*:LspDiag-next* *:LspDiagNext*
:[count]LspDiag next	跳转到当前光标位置之后的第 [count] 条诊断消息。
			如果省略 [count]，则使用 1。如果 [count] 超过
			当前位置之后的诊断数量，则选择最后一条诊断。

					*:LspDiag-nextWrap* *:LspDiagNextWrap*
:[count]LspDiag nextWrap	与 |:LspDiag-next| 相同，但在没有更多
			消息时回绕到第一条消息。

						*:LspDiag-prev* *:LspDiagPrev*
:[count]LspDiag prev	跳转到当前光标位置之前的第 [count] 条诊断消息。
			如果省略 [count]，则使用 1。如果 [count] 超过
			当前位置之前的诊断数量，则选择第一条诊断。

					*:LspDiag-prevWrap* *:LspDiagPrevWrap*
:[count]LspDiag prevWrap	与 |:LspDiag-prev| 相同，但在没有前一条
			消息时回绕到最后一条消息。

						*:LspDiag-show* *:LspDiagShow*
:LspDiag show		创建一个新的位置列表，包含语言服务器为当前
			文件提供的诊断消息（如果有），并打开位置列表
			窗口。您可以使用 Vim 位置列表命令浏览列表。

------------------------------------------------------------------------------
							*lsp-server-cmds*
5.8 服务器和工作区管理~

用于控制语言服务器进程、监控其状态和管理工作区文件夹范围的
命令。

						*:LspServer*
:LspServer { debug | restart | show | start | stop | trace }
			用于显示和控制当前缓冲区语言服务器的命令。
			每个参数都有额外的子命令，如下所述。

			debug { on | off | messages | errors }
			    启用或禁用语言服务器调试消息，并显示
			    语言服务器调试和错误消息的命令。支持以下
			    子命令：
				errors	打开包含语言服务器错误消息的
					日志文件。
				messages
					打开包含语言服务器调试消息的
					日志文件。
				off	禁用语言服务器消息的日志记录。
				on	启用语言服务器在标准输出和标准
					错误中发出的消息的日志记录。
			    默认情况下，不记录语言服务器消息。在类 Unix
			    系统上，启用时，这些消息将分别记录到
			    /tmp/lsp-<server-name>.log 和
			    /tmp/lsp-<server-name>.err 文件中。在
			    MS-Windows 上，使用 %TEMP%/lsp-<server-name>.log
			    和 %TEMP%/lsp-<server-name>.err 文件。
			    参见 |lsp-debug|。

			restart
			    重启（停止然后启动）当前缓冲区的语言服务器。
			    所有与当前缓冲区具有相同文件类型的已加载
			    缓冲区都会重新添加到服务器。

			show {capabilities | initializeRequest | messages
								| status}
			    支持以下子命令：
				capabilities
					显示当前缓冲区的语言服务器
					能力列表。服务器能力在 LSP
					协议规范中的 "ServerCapabilities"
					接口下描述。
				initializeRequest
					显示语言服务器初始化请求消息
					（initialize）的内容。
				messages
					显示从语言服务器接收到的日志
					消息。这包括使用
					"window/logMessage" 和 "$/logTrace"
					LSP 通知接收到的消息。
				status
					显示当前缓冲区的语言服务器
					状态。输出显示语言服务器
					可执行文件的路径和服务器状态。

			start
			    启动为当前缓冲区文件类型注册的语言服务器。
			    所有具有此文件类型的缓冲区都会添加到
			    服务器。

			stop
			    停止为当前缓冲区文件类型注册的所有语言
			    服务器。注意，这会停止所有具有此文件类型
			    的缓冲区的语言服务器。打开具有此文件类型的
			    新文件不会启动语言服务器，直到使用 start
			    命令显式启动服务器。

			trace { off | messages | verbose }
			    使用 "$/setTrace" 命令设置语言服务器调试
			    跟踪值。

						*:LspShowAllServers*
:LspShowAllServers	显示已注册语言服务器及其状态的列表。
			语言服务器使用 LspAddServer() 函数注册。
			输出显示在名为 "Language-Servers" 的临时
			缓冲区中。如果该窗口已存在，则重用并刷新。

			输出有两个部分：
			- "Filetype Information" 显示已注册的 Vim
			  文件类型、匹配的语言服务器、可执行文件路径
			  以及每个服务器是否正在运行。
			- "Buffer Information" 显示每个缓冲区附加了
			  哪些语言服务器。

						*:LspWorkspaceAddFolder*
:LspWorkspaceAddFolder {folder}
			将 {folder} 添加到当前缓冲区所有附加语言
			服务器的工作区文件夹中。{folder} 必须指定
			一个存在的目录。

:LspWorkspaceListFolders			*:LspWorkspaceListFolders*
			显示当前缓冲区每个附加语言服务器的当前
			工作区文件夹。

						*:LspWorkspaceRemoveFolder*
:LspWorkspaceRemoveFolder {folder}
			从当前缓冲区所有附加语言服务器的工作区
			文件夹中移除 {folder}。{folder} 必须指定
			一个存在的目录。

==============================================================================
							*lsp-configuration*
6. 配置~

					*lsp-options*
					*LspOptionsSet()* *g:LspOptionsSet()*
LSP 插件的某些功能可以通过 LspOptionsSet() 函数启用或禁用。
该函数接受一个字典参数，其中包含以下可选项：

						*lsp-opt-aleSupport*
aleSupport		|Boolean| 选项。如果为 true，诊断信息会发送给
			Ale，而不是由本插件显示。这对于合并所有 LSP
			和 linter 诊断信息很有用。默认值为 false。

						*lsp-opt-autoComplete*
autoComplete		|Boolean| 选项。在插入模式下自动补全当前符号。
			否则使用全能补全。默认值为 true。

						*lsp-opt-autoHighlight*
autoHighlight		|Boolean| 选项。在普通模式下自动高亮光标下
			符号的所有出现。默认值为 false。

						*lsp-opt-autoHighlightDiags*
autoHighlightDiags	|Boolean| 选项。自动在带有语言服务器诊断
			消息的行上放置符号。默认值为 true。

						*lsp-opt-autoPopulateDiags*
autoPopulateDiags	|Boolean| 选项。自动使用语言服务器的诊断
			信息填充位置列表。默认值为 false。
			诊断消息的完整信息（从 LSP 服务器接收的）
			可以通过位置列表项的 'user_data' 属性访问。
			为此，每个位置列表项的 'user_data' 属性中会
			添加一个字典 { diagnostic: <完整诊断消息> }。

						*lsp-opt-codeActionPopupDetails*
codeActionPopupDetails	|String| 选项。配置代码弹出窗口的详细信息。
			此选项接受以下值之一：
			    full                 - 显示标题、完整类型和服务器
			    full-kind-and-server - 显示操作标题和完整类型
			    kind                 - 显示操作标题和类型
			    kind-and-server      - 显示操作标题、类型和服务器（默认）
			    server               - 显示操作标题和服务器
			    short                - 仅显示操作

						*lsp-opt-completionMatcher*
completionMatcher	|String| 选项。为返回完整补全项列表的语言
			服务器启用模糊或大小写不敏感补全。某些语言
			服务器在服务器端进行补全过滤，而其他则依赖
			客户端进行过滤。

			此选项仅适用于期望客户端过滤补全项的语言
			服务器。

			此选项接受以下值之一：
			    case  - 大小写敏感匹配（默认）。
			    fuzzy - 模糊匹配补全项。
			    icase - 忽略大小写匹配项。

						*lsp-opt-completionTextEdit*
completionTextEdit	|Boolean| 选项。如果为 true，则在补全后应用
			LSP 服务器提供的文本编辑。如果某个片段插件
			将要应用文本编辑，则将此设置为 false 以避免
			重复应用。默认值为 true。

                                                *lsp-opt-completionKinds*
completionKinds		|Dictionary| 选项。参见 |lsp-custom-kinds|
			获取所有补全类型名称。

					*lsp-opt-customCompletionKinds*
customCompletionKinds   |Boolean| 选项。如果设置为 true，您可以使用
			completionKinds 选项设置自定义补全类型。

						*lsp-opt-diagSignErrorText*
diagSignErrorText       |String| 选项。更改错误诊断符号文本。
			默认 'E>'

						*lsp-opt-diagSignHintText*
diagSignHintText        |String| 选项。更改提示诊断符号文本。
			默认 'H>'

						*lsp-opt-diagSignInfoText*
diagSignInfoText        |String| 选项。更改信息诊断符号文本。
			默认 'I>'

						*lsp-opt-diagSignWarningText*
diagSignWarningText     |String| 选项。更改警告诊断符号文本。
			默认 'W>'

						*lsp-opt-diagVirtualTextAlign*
diagVirtualTextAlign	|String| 选项。如果 |lsp-opt-showDiagWithVirtualText|
			设置为 true，则诊断消息的对齐方式。
			允许的值为 'above'、'below' 或 'after'。
			默认值为 'above'。

						*lsp-opt-diagVirtualTextWrap*
diagVirtualTextWrap	|String| 选项。如果 |lsp-opt-showDiagWithVirtualText|
			设置为 true，则诊断消息的换行方式。
			允许的值为 'default'、'wrap' 或 'truncate'。
			默认值为 'default'。

						*lsp-opt-echoSignature*
echoSignature		|Boolean| 选项。在插入模式下，在命令行中回显
			当前符号签名，而不是显示在弹出窗口中。如果
			您更喜欢更简洁的界面或想避免重叠的弹出窗口，
			这很有用。注意：'showmode' 选项应被禁用以便
			签名可见。此外，应将 'c' 标志添加到 'shortmess'
			选项以禁用插入补全消息。默认值为 false。

					*lsp-opt-hideDisabledCodeActions*
hideDisabledCodeActions |Boolean| 选项。隐藏语言服务器标记为已禁用的
			代码操作（CodeAction.disabled）。默认值为 false。
			启用后，禁用项会在匹配或提示之前被移除，因此
			操作索引可能与服务器的原始列表不同。

						*lsp-opt-highlightDiagInline*
highlightDiagInline	|Boolean| 选项。内联高亮诊断信息。
			默认值为 true。

						*lsp-opt-hoverInPreview*
hoverInPreview		|Boolean| 选项。在预览窗口中显示 |:LspHover|，
			而不是弹出窗口。预览缓冲区名为 "LspHover"，
			可以通过 |:pclose| 关闭。默认值为 false。

						*lsp-opt-hoverOnCursorHold*
hoverOnCursorHold	|Boolean| 选项。当光标闲置时（|CursorHold|）
			自动请求悬停文档。默认值为 false。

						*lsp-opt-hoverDelay*
hoverDelay		|Number| 选项。当 |lsp-opt-hoverOnCursorHold|
			启用时，自动悬停请求使用的去抖延迟（毫秒）。
			默认值为 300。

						*lsp-opt-completionInPreview*
completionInPreview	|Boolean| 选项。在 |preview-window| 中显示补全
			文档，而不是弹出窗口。启用时，缓冲区
			'completeopt' 会包含 'preview'（而不包含
			'popup'）。默认值为 false。

						*lsp-opt-closePreviewOnComplete*
closePreviewOnComplete	|Boolean| 选项。当使用 |preview-window| 进行
			补全文档时（参见 |lsp-opt-completionInPreview|），
			在补全菜单关闭时自动关闭预览窗口。
			默认值为 true。

						*lsp-opt-hoverFallback*
hoverFallback		|Boolean| 选项。在没有悬停信息可用时回退到
			文件类型 'keywordprg'。如果启用，并且本地
			'keywordprg' 不为空且未设置为 |:LspHover|，
			则 |:LspHover| 会执行内置的 |K| 行为作为回退。

			使用此选项时，不要将 'keywordprg' 设置为
			|:LspHover|，因为这会禁用回退并可能导致
			自定义映射中的递归。请使用类似以下的映射： >

                          nnoremap K <Cmd>LspHover<CR>
<
			默认值为 false。

						*lsp-opt-definitionFallback*
definitionFallback	|Boolean| 选项。在没有定义信息可用时回退
			到 |:tjump|。不要将 'tagfunc' 设置为
			'lsp#lsp#TagFunc'，但可以使用合适的映射：

                          nnoremap <c-]> <Cmd>LspGotoDefinition<CR>
                          nnoremap g]    <Cmd>LspPeekDefinition<CR>

			如果您更希望使用弹出窗口而不是默认的
			|preview-window| 进行预览回退，请参阅
			'previewpopup'。默认值为 false。

						*lsp-opt-formatFallback*
formatFallback  	|Boolean| 选项。在没有格式化可用时回退
			到 |gq|。不要将 'formatexpr' 设置为
			'lsp#lsp#FormatExpr()'，但可以使用合适的映射：

			  nnoremap gq <plug>(LspFormat)
			  xnoremap gq <plug>(LspFormat)

						*lsp-opt-ignoreMissingServer*
ignoreMissingServer	|Boolean| 选项。不打印缺失的语言服务器
			可执行文件消息。默认值为 false。

						*lsp-opt-keepFocusInDiags*
keepFocusInDiags     	|Boolean| 选项。在 ":LspDiag show" 之后聚焦于
			位置列表窗口。默认值为 true。

					*lsp-opt-keepFocusInReferences*
keepFocusInReferences	|Boolean| 选项。在 LspShowReferences 之后聚焦于
			位置列表窗口。默认值为 true。

						*lsp-opt-maxDiagnostics*
maxDiagnostics		|Number| 选项。从服务器接收诊断通知时
			处理的最大诊断数。处理数百条诊断消息很慢，
			特别是当需要解码偏移位置时。默认值为 200。

					*lsp-opt-noNewlineInCompletion*
noNewlineInCompletion	|Boolean| 选项。抑制在按 <CR> 选择补全时添加
			新行。默认值为 false。

						*lsp-opt-omniComplete*
omniComplete		|Boolean| 选项。启用或禁用全能补全。
			默认值为 v:false。如果 "autoComplete" 设置为
			v:false，则默认启用全能补全。通过将 "omniComplete"
			选项设置为 v:false，也可以禁用全能补全。

						*lsp-opt-omniCompleteAllowBare*
omniCompleteAllowBare   |Boolean| 选项。定义全能补全函数是否可以在
			光标前没有触发字符的情况下触发。仅当
			|lsp-opt-omniComplete| 为 true 时生效。默认
			值为 v:false。
			注意，由于实现原因，这可能是一个非常嘈杂的
			选项，因为它会导致全能补全在空格以及许多
			其他不合理的位置触发。对于等效且噪音小得多
			的 |lsp-opt-autoComplete| 解决方案，请参见
			|lsp-ins-force|。

						*lsp-opt-onTypeFormatting*
onTypeFormatting	|Boolean| 选项。在输入时使用语言服务器的
			输入时格式化支持重新格式化代码（例如，在按
			<Enter> 后重新缩进行）。默认值为 false，因为
			它会在您输入时编辑缓冲区。参见
			|lsp-on-type-format|。

						*lsp-opt-outlineOnRight*
outlineOnRight		|Boolean| 选项。如果为 true，在大纲窗口的右侧
			打开窗口。如果为 false（默认），在左侧打开。
			为 |:LspOutline| 提供 |:command-modifiers| 会
			覆盖此选项。

						*lsp-opt-outlineWinSize*
outlineWinSize		|Number| 选项。符号大纲窗口的宽度（列数）。
			默认值为 20。通过为 |:LspOutline| 提供 [count]
			可以覆盖。

						*lsp-opt-popupBorder*
popupBorder		|Boolean| 选项。启用弹出窗口边框。
			默认值为 false。

						*lsp-opt-popupBorderChars*
popupBorderChars	|List| 选项。用于绘制弹出窗口边框的字符，
			参见 |popup_create-arguments|。
			默认值为 ['─', '│', '─', '│', '╭', '╮', '╯', '╰']。

						*lsp-opt-popupBorderHighlight*
popupBorderHighlight	|String| 选项。用于弹出窗口边框的高亮组名称。
			默认值为 'LspPopupBorder'。

						*lsp-opt-popupHighlight*
popupHighlight		|String| 选项。用于弹出窗口内容的高亮组名称。
			默认值为 'LspPopup'。

						*lsp-opt-popup-CodeAction*
			覆盖 CodeAction 弹出窗口的选项：
popupBorderCodeAction			|Boolean| 选项。
popupBorderHighlightCodeAction		|String| 选项。
popupHighlightCodeAction		|String| 选项。

						*lsp-opt-popup-Completion*
			覆盖 Completion 弹出窗口的选项：
popupBorderCompletion			|Boolean| 选项。
popupBorderHighlightCompletion		|String| 选项。
popupHighlightCompletion		|String| 选项。

						*lsp-opt-popup-Diag*
			覆盖 Diagnostic 弹出窗口的选项：
popupBorderDiag				|Boolean| 选项。
popupBorderHighlightDiag		|String| 选项。
popupHighlightDiag			|String| 选项。

						*lsp-opt-popup-Hover*
			覆盖 Hover 弹出窗口的选项：
popupBorderHover			|Boolean| 选项。
popupBorderHighlightHover		|String| 选项。
popupHighlightHover			|String| 选项。

						*lsp-opt-popup-Peek*
			覆盖 Peek 弹出窗口的选项：
popupBorderPeek				|Boolean| 选项。
popupBorderHighlightPeek		|String| 选项。
popupHighlightPeek			|String| 选项。

						*lsp-opt-popup-SignatureHelp*
			覆盖插入模式下键入函数/方法调用时显示的
			SignatureHelp 弹出窗口的选项。活动参数会在
			弹出窗口中高亮显示。
			当 |lsp-opt-showSignatureDocs| 启用时，弹出
			窗口还可能在签名标签下方包含参数和签名文档。

popupBorderSignatureHelp		|Boolean| 选项。默认：false
			绘制签名弹出窗口的边框。

popupBorderHighlightSignatureHelp	|String| 选项。
			签名弹出窗口边框的高亮组。

popupHighlightSignatureHelp		|String| 选项。
			签名弹出窗口背景和文本的高亮组。

						*lsp-opt-popup-SymbolMenu*
			覆盖 SymbolMenu 弹出窗口的选项：
popupBorderSymbolMenu			|Boolean| 选项。
popupBorderHighlightSymbolMenu		|String| 选项。
popupHighlightSymbolMenu		|String| 选项。

						*lsp-opt-popup-SymbolMenuInput*
			覆盖 SymbolMenuInput 弹出窗口的选项：
popupBorderSymbolMenuInput		|Boolean| 选项。
popupBorderHighlightSymbolMenuInput	|String| 选项。
popupHighlightSymbolMenuInput		|String| 选项。

						*lsp-opt-popup-TypeHierarchy*
			覆盖 TypeHierarchy 弹出窗口的选项：
popupBorderTypeHierarchy		|Boolean| 选项。
popupBorderHighlightTypeHierarchy	|String| 选项。
popupHighlightTypeHierarchy		|String| 选项。

						*lsp-opt-semanticHighlight*
semanticHighlight	|Boolean| 选项。启用或禁用语义高亮。
			启用时，插件会向语言服务器请求语义令牌，
			并使用 |LspSemanticNamespace|、|LspSemanticType|、
			|LspSemanticClass| 和相关高亮组将文本属性
			应用到缓冲区。仅当缓冲区附加到支持语义令牌
			的语言服务器时，才会启用语义高亮。
			默认值为 false。
			另请参见 |lsp-opt-semanticHighlightDelay| 和
			|lsp-semantic-highlighting|。

					*lsp-opt-semanticHighlightDelay*
semanticHighlightDelay	|Number| 选项。语义高亮请求的延迟（毫秒）。
			这是在文本更改后刷新语义令牌时使用的去抖
			延迟，因此可以防止在快速编辑期间发送过多
			请求。较低的值会更早更新高亮，但会向语言
			服务器发送更多请求。默认值为 1000。

						*lsp-opt-showDiagInBalloon*
showDiagInBalloon	|Boolean| 选项。当鼠标悬停在诊断引用的
			文本范围上时，在气球中显示诊断文本。
			默认值为 true。在 GUI Vim 中，需要 |+balloon_eval|
			特性。在终端 Vim 中，需要 |+balloon_eval_term|
			特性。在终端 Vim 中，应设置 'mouse' 选项以
			启用鼠标。如果此选项设置为 true，则会设置
			'ballooneval' 和 'balloonevalterm' 选项。

						*lsp-opt-showDiagInPopup*
showDiagInPopup		|Boolean| 选项。当使用 ":LspDiag current"
			命令显示当前行的诊断消息时，使用弹出窗口
			显示消息，而不是在状态区域回显。默认值
			为 true。

						*lsp-opt-showDiagOnStatusLine*
showDiagOnStatusLine	|Boolean| 选项。在状态行上显示诊断消息。
			默认值为 false。

						*lsp-opt-showDiagWithSign*
showDiagWithSign	|Boolean| 选项。在带有诊断的行上放置符号。
			默认值为 true。"autoHighlightDiags" 选项应
			设置为 true。

					*lsp-opt-showDiagWithVirtualText*
showDiagWithVirtualText	|Boolean| 选项。使用虚拟文本显示语言服务器的
			诊断消息文本。默认值为 false。
			"autoHighlightDiags" 选项应设置为 true。
			注意：需要 Vim 9.0.1157 或更高版本。

						*lsp-opt-showInlayHints*
showInlayHints		|Boolean| 选项。显示语言服务器的内联提示。
			默认值为 false。
			内联提示在缓冲区中以虚拟文本形式显示推断的
			类型注释（|LspInlayHintsType|）和参数名称
			标签（|LspInlayHintsParam|）。提示仅在普通
			模式下显示。当光标在 |'updatetime'| 毫秒内
			未移动（|CursorHold|）后，会请求更新，随后
			会有短暂的延迟。
			使用 |:LspInlayHints| 可在不永久更改此选项
			的情况下启用、禁用或切换当前会话的提示。
			注意：需要 Vim 9.0.0178 或更高版本。

						*lsp-opt-showSignature*
showSignature		|Boolean| 选项。在插入模式下，当触发字符
			（通常为 '(' 或 ','）触发时，自动显示当前
			符号签名（函数或方法参数）。签名显示在
			弹出窗口中，活动参数会高亮。在签名会话
			处于活动状态时，插件也可以在支持的重新触发
			字符上以及插入模式光标/文本更改时重新触发，
			以使显示的签名保持最新。
			禁用此选项可防止自动弹出，同时仍允许使用
			|:LspShowSignature| 手动调用。
			默认值为 true。

						*lsp-opt-showSignatureDocs*
showSignatureDocs	|Boolean| 选项。在签名帮助输出中包含参数
			和签名文档。禁用时，签名帮助仅显示短签名
			标签，同时仍高亮活动参数。这适用于弹出和
			|lsp-opt-echoSignature| 显示模式。启用时，
			会为当前活动参数显示参数文档，并在语言
			服务器提供时在其下方显示签名级别的文档。
			默认值为 false。

						*lsp-opt-snippetSupport*
snippetSupport		|Boolean| 选项。启用片段补全支持。
			需要像 vim-vsnip 这样的片段补全插件。
			默认值为 false。

						*lsp-opt-ultisnipsSupport*
ultisnipsSupport	|Boolean| 选项。启用 SirVer/ultisnips 支持。
			需要 SirVer/ultisnips 片段补全插件。
			默认值为 false。

						*lsp-opt-vsnipSupport*
vsnipSupport		|Boolean| 选项。启用 hrsh7th/vim-vsnip 支持。
			需要 hrsh7th/vim-vsnip 和 hrsh7th/vim-vsnip-integ
			片段补全插件。在启用此选项之前，请确保
			ultisnipsSupport 设置为 false。默认值为 false。

						*lsp-opt-usePopupInCodeAction*
usePopupInCodeAction    |Boolean| 选项。当使用 |:LspCodeAction| 命令且
			未给出 [query] 时，使用弹出菜单代替
			|inputlist()|。
			在弹出模式下，<Esc> 执行正常取消。对于
			|:LspAutoFix| 范围处理，这意味着继续处理
			下一个诊断。<C-C> 执行强制取消并停止进一步
			的范围处理。默认值为 false。

					*lsp-opt-useQuickfixForLocations*
useQuickfixForLocations	|Boolean| 选项。在快速修复列表中而不是位置
			列表中显示 |:LspShowReferences|。默认值为
			false。

						*lsp-opt-useBufferCompletion*
useBufferCompletion     |Boolean| 选项。如果启用，当前缓冲区的单词
			会添加到自动补全列表中。默认值为 false。

					*lsp-opt-bufferCompletionTimeout*
bufferCompletionTimeout |Number| 选项。指定处理当前缓冲区以获取
			自动补全单词时的等待时间（毫秒）。如果设置
			过高，每次显示补全菜单时处理当前缓冲区内容
			可能会降低 Vim 性能。如果设置为 0，则在整个
			缓冲区上处理，不考虑超时。默认值为 100 毫秒。

					*lsp-opt-filterCompletionDuplicates*
filterCompletionDuplicates |Boolean| 选项。如果启用，将从服务器发送的
			重复补全项中过滤，只保留一个副本。

					*lsp-opt-condensedCompletionMenu*
condensedCompletionMenu |Boolean| 选项。如果启用，将补全菜单项最小化
			为单个（关键字）单词（加上类型）。将所有
			额外详细信息移至信息弹出窗口。
			注意：LazyDoc 会覆盖移动的详细信息！

				*lsp-opt-ignoreCompleteItemsIsIncomplete*
ignoreCompleteItemsIsIncomplete |List| of strings 选项。
			可选的 LSP 服务器名称列表，对于这些服务器，
			应忽略 'IsIncomplete' 消息，并强制过滤接收
			到的补全项列表。这对于行为异常且始终发送
			此类 'IsIncomplete' 消息的 LSP 服务器很有用。

						*lsp-opt-documentationFormat*
documentationFormat |List| of strings 选项。
			DocumentationFormat，按偏好顺序告诉 LSP 我们
			想要的格式。

						*lsp-opt-incrementalSync*
incrementalSync		|Boolean| 选项。指定与语言服务器同步缓冲区
			更改的方法。

			- 如果为 |true|，仅发送缓冲区的修改部分
			  （增量同步）。这对于大文件更高效，减少
			  网络/CPU 开销。
			  注意：这需要 |diff()| 函数的支持，该函数
			  在补丁 9.1.0099 中引入。
			- 如果为 |false|，每次更改时发送整个缓冲区
			  内容（全量同步）。这更健壮，但在超大
			  文档中可能导致延迟。

			默认值：|false|

						*lsp-opt-workspaceIgnoredPaths*
workspaceIgnoredPaths	|List| 选项。永远不会用作任何语言服务器
			工作区根的目录路径。如果解析的工作区根匹配
			某个条目，则向服务器发送 null 根，以便它
			仅分析当前缓冲区。支持 Glob 模式。

			默认值：
 			['/', $"{$HOME}", $"{$HOME}/.cargo", $"{$HOME}/.cargo/**",
 			$"{$HOME}/.rustup", $"{$HOME}/.rustup/**", $"{$HOME}/pkg/mod",
 			$"{$HOME}/pkg/mod/**"]

例如，要禁用 LSP 诊断消息符号的自动放置，您可以在 .vimrc
文件中添加以下行： >

	call g:LspOptionsSet({'autoHighlightDiags': false})
<
						*g:lsp_options*
为了方便，您也可以在 vimrc 中使用此全局变量设置上述选项。
该值必须是一个字典，并支持与直接调用 LspOptionsSet() 相同的
选项。当设置了 g:lsp_options 时，会在插件加载时自动调用
LspOptionsSet()。例如，在您的 vimrc 中： >

    vim9script
    g:lsp_options = {autoHighlightDiags: true}
<
等效于： >

    vim9script
    var lspOpts = {autoHighlightDiags: true}
    autocmd User LspSetup g:LspOptionsSet(lspOpts)
<
						*g:lsp_servers*
为了方便，也可以通过变量 |g:lsp_servers| 设置服务器列表，
该变量应在加载插件之前设置，例如在您的 |.vimrc| 中定义。
该值必须是一个字典列表，并支持与 |LspAddServer()| 相同的
选项。当设置了 |g:lsp_servers| 时，会在插件加载时自动调用
|LspAddServer()|。例如，在您的 vimrc 中： >

    vim9script
    var lspServers = [
		     {
		        name: 'clangd',
		        filetype: ['c', 'cpp'],
		        path: '/usr/local/bin/clangd',
		        args: ['--background-index']
		      }
		   ]

    g:lsp_servers = lspServers
<
等效于： >

    vim9script
    var lspServers = [
		     {
		        name: 'clangd',
		        filetype: ['c', 'cpp'],
		        path: '/usr/local/bin/clangd',
		        args: ['--background-index']
		      }
		   ]

    autocmd User LspSetup g:LspAddServer(lspServers)
<
						*g:lsp_enable*
默认情况下，插件在 Vim 启动时自动启用。您可以使用此选项
在 Vim 启动时禁用自动启用 LSP，例如： >

    vim9script
    g:lsp_enable = false
<
可以在启动后使用 |g:LspEnable()| 函数启用插件。

				    *LspEnable()* *g:LspEnable()*
g:LspEnable() 函数在 Vim 启动后启用 LSP 插件。

				    *LspDisable()* *g:LspDisable()*
g:LspDisable() 函数在 Vim 启动后禁用缓冲区的 LSP 功能。
它不会停止已经运行的语言服务器。要停止运行中的服务器，
请使用 |:LspServer| stop。

				    *LspOptionsGet()* *g:LspOptionsGet()*
g:LspOptionsGet() 函数返回所有 LSP 插件选项的 |Dict|。
要获取特定选项值，可以使用以下方式： >

	echo g:LspOptionsGet()['autoHighlightDiags']
<
==============================================================================
						*lsp-ins-mode-completion*
7. 插入模式补全~

默认情况下，当您在插入模式时，LSP 插件会在插入补全弹出菜单中
自动显示光标下符号的建议。可以使用 |popupmenu-keys| 中指定的
键与此菜单交互。

要禁用所有文件的此自动补全功能，您可以在 .vimrc 文件中使用
|LspOptionsSet()| 函数将 "autoComplete" 选项设置为 false： >

    call LspOptionsSet({'autoComplete': false})
<
将 "autoComplete" 选项设置为 |v:false| 后，LSP 插件将不再
在插入模式下自动触发补全建议。相反，它将使用全能补全
（|compl-omni|），并为具有已注册语言服务器的缓冲区设置
'omnifunc' 选项。要在插入模式下手动触发符号补全，您可以按
CTRL-X CTRL-O。此组合键将使用语言服务器提供的建议调用补全。

要为所有缓冲区启用全能补全，请将 "omniComplete" 选项设置为
v:true。要显式禁用所有缓冲区的全能补全，请将 "omniComplete"
选项设置为 v:false（默认）。

除了上述通用自动补全行为，您还可以在注册特定文件类型的语言
服务器时，启用或禁用该语言服务器的全能补全。

为此，您可以在注册语言服务器的配置中为所需文件类型设置
'omnicompl' 项为 |v:false|。如果未指定 'omnicompl' 项，则
默认启用全能补全。

以下是禁用 Python 全能补全的示例： >

    vim9script
    var lspServers = [
		     {
			filetype: 'python',
			omnicompl: false,
			path: '/usr/local/bin/pyls',
			args: ['--check-parent-process', '-v']
		     }
		   ]
<
在此示例中，使用 |LspAddServer()| 函数注册 Python 语言服务器，
并将 'omnicompl' 项显式设置为 |v:false|。因此，与此语言
服务器关联的 Python 文件将禁用全能补全。

请注意，如果注册语言服务器时配置中未包含 'omnicompl'，则
默认启用全能补全。

在插入模式补全中，插件会向语言服务器发送补全请求消息，并
根据当前光标位置获取潜在补全匹配项列表。为此，插件会获取
光标前紧邻的关键字（参见 'iskeyword' 设置），然后根据此
关键字过滤从语言服务器接收到的补全项列表。得到的过滤列表
会显示为补全菜单。

值得注意的是，不同的语言服务器以不同方式处理补全过滤。
一些服务器直接在服务器端进行过滤，而其他则将此任务委托给
客户端（即插件）。

默认情况下，插件使用大小写敏感比较方法过滤返回的补全项。
但您可以通过修改 "completionMatcher" 选项灵活自定义此行为。
此选项允许您根据偏好和需求在大小写不敏感或模糊比较方法
之间切换。

除了自动补全和全能补全，还可以利用外部补全引擎与 LSP 客户端
配合使用。这可以通过重新利用 |g:LspOmniFunc| 函数来实现。
外部补全引擎适配器需要按照 |complete-functions| 文档中
描述的方式调用此函数两次。

过程如下：

1. 第一次调用：外部补全引擎适配器调用 |g:LspOmniFunc| 以
   发起对 LSP 服务器的补全候选请求。
2. 第一次调用后，向 LSP 服务器发送请求以查找补全候选。
3. 第二次调用：外部补全引擎适配器再次调用 |g:LspOmniFunc|
   以检索 LSP 服务器返回的匹配项。
4. 如果 LSP 服务器未立即准备回复，|g:LspOmniFunc| 会等待
   最多 2 秒。
5. 然而，此等待可能会阻塞调用者执行其他任务，这可能对
   异步补全引擎造成问题。
6. 为解决此问题，适配器可以使用 |g:LspOmniCompletePending|
   函数，该函数允许非阻塞检查。如果语言服务器尚未准备好
   回复，它会立即返回 true。
7. 要继续第二次调用 g:LspOmniFunc，必须确保
   |g:LspOmniCompletePending| 返回 false，表示语言服务器
   现在已准备好提供补全匹配项。

------------------------------------------------------------------------------
							*lsp-ins-force*
7.1. 无字符强制补全~

使用调用 24x7 补全函数的自定义映射，您可以强制补全对话框
出现，即使没有触发字符。这在以下语言中特别有用：有明确定义
的可插入内容，但没有可用的特殊触发字符。例如，在填充
TypeScript 对象时，您希望在不先输入任何内容的情况下获得
名称补全。

默认情况下不启用此功能，因为在某些情况下它可能相对嘈杂。

示例映射： >
    inoremap <C-space> <C-\><C-o>:call lsp#completion#LspComplete(v:true)<cr>
<
（注意，由于终端 Vim 的输入限制，<C-space> 特别限于 gVim）

==============================================================================
							*lsp-diagnostics*
8. 诊断信息~

LSP 插件提供了通过在符号列中放置符号来高亮源文件中语法错误、
警告和静态分析警告的功能。这些符号作为语言服务器报告诊断
信息的视觉指示器。

要与这些诊断交互，您可以使用 LSP 插件提供的各种命令：

1. ":LspDiag show"：此命令在位置列表窗口中显示当前文件的
   所有诊断消息。位置列表窗口允许您查看所有诊断消息的列表，
   以及它们对应的行号和描述。
2. ":LspDiag first"：使用此命令直接跳转到第一条诊断消息所在
   的行。它可以帮助您快速导航到语言服务器检测到的初始问题
   位置。
3. ":LspDiag next"：使用此命令可以导航到下一条最近的诊断
   消息行。它帮助您逐步遍历诊断列表。
4. ":LspDiag prev"：相反，此命令允许您跳转到上一条最近的
   诊断消息行。它对于反向查看诊断很有用。
5. ":LspDiag here"：如果您只想关注当前行的诊断消息，可以
   使用此命令直接跳转到它。
6. ":LspDiag current"：此命令显示语言服务器为当前行提供的
   完整诊断消息。它提供有关特定问题及其描述的详细信息。

通过使用这些命令，您可以高效地导航和检查语言服务器报告的
诊断，从而更容易识别和解决代码中的语法错误、警告或静态
分析问题。

默认情况下，LSP 插件通过在带有诊断消息的行上放置符号并高亮
与诊断关联的文本范围来标记这些行。但是，您可以通过调整某些
配置设置来自定义此行为：

1. 禁用自动符号放置：如果您不希望自动在带有诊断消息的行上
   放置符号，可以通过将 "showDiagWithSign" 选项设置为 |v:false|
   来实现。默认情况下，此选项设置为 |v:true|，意味着会自动
   在带有诊断的行上放置符号。
2. 禁用诊断文本高亮：如果您不希望高亮诊断文本，可以通过将
   "highlightDiagInline" 选项设置为 |v:false| 来实现。默认
   情况下，此选项设置为 |v:true|，会高亮与每个诊断关联的
   文本范围。
3. 带有诊断的行的高亮组：LSP 插件使用 "LspDiagLine" 高亮组
   来高亮包含诊断的行。默认情况下，此高亮组未设置，允许您
   根据需要使用自己的高亮样式。

除了使用符号和文本高亮显示诊断消息的默认方式外，LSP 插件
还提供了在诊断相关位置附近以虚拟文本形式呈现诊断消息的
选项。要启用此功能，您可以将 "showDiagWithVirtualText" 选项
设置为 |v:true|。但请注意，此功能需要 Vim 版本 9.0.1157 或
更高版本。默认情况下，此选项设置为 |v:false|，即未激活虚拟
文本显示。

虚拟文本的位置可以使用 "diagVirtualTextAlign" 选项控制，该
选项确定其相对于受影响行的对齐方式。默认情况下，此选项
设置为 'above'，将虚拟文本放置在带有诊断消息的行上方。
其他支持的值为 'below'（将虚拟文本放置在受影响行下方）和
'after'（将虚拟文本显示在受影响行文本之后）。

虚拟文本的换行可以使用 "diagVirtualTextWrap" 选项控制。默认
情况下，此选项设置为 'default'，对于放置在受影响行上方或
下方的虚拟文本会 'truncate'，对于放置在受影响行之后的文本
会 'wrap'。将值设置为 'wrap' 或 'truncate' 将强制对
"diagVirtualTextAlign" 的当前值应用指定行为。如果使用
'truncate' 且 "diagVirtualTextAlign" 设置为 'after'，且受
影响行的诊断消息已被截断，则进一步的诊断将放置在受影响行
下方。

LSP 插件提供了方便的方式来高亮诊断消息，使您更容易发现代码
中的错误、警告、提示或信息性通知。默认情况下，当
"highlightDiagInline" 选项设置为 |v:true| 时，插件会自动
高亮与每条诊断消息关联的文本范围。

高亮使用不同的高亮组，具体取决于诊断消息的类型：

    "LspDiagInlineError" 用于错误消息。
    "LspDiagInlineHint" 用于提示。
    "LspDiagInlineInfo" 用于信息性消息。
    "LspDiagInlineWarning" 用于警告消息。

如果您希望暂时禁用当前 Vim 会话的自动诊断高亮，可以使用
":LspDiag highlight disable" 命令实现。当您想重新启用高亮
时，可以使用 ":LspDiag highlight enable" 命令。要切换高亮
状态，可以使用 ":LspDiag highlight toggle" 命令。

要永久禁用自动诊断高亮，您可以在 .vimrc 文件中将
"autoHighlightDiags" 选项设置为 |v:false|。可以使用
|LspOptionsSet()| 函数进行配置： >

    call LspOptionsSet({'autoHighlightDiags': v:false})
<
默认情况下，"autoHighlightDiags" 选项设置为 |v:true|，确保
在编码过程中自动高亮诊断消息。

lsp#lsp#ErrorCount() 函数返回当前缓冲区中诊断消息的计数，
按类型分类。调用时，此函数返回一个包含四个键的 Dictionary：
"Info"、"Hint"、"Warn" 和 "Error"。每个键对应特定的诊断类型，
其关联值为该类型在当前缓冲区中的消息数量。通过此函数获取
的信息，您可以轻松地在 'statusline' 中显示当前缓冲区的
诊断数量。

对于某些诊断错误/警告，语言服务器可能提供自动修复。要应用
此修复，您可以使用 |:LspCodeAction| 命令。此命令应用语言
服务器为当前行提供的操作（如果有）。

":LspDiag show" 命令会创建一个新的位置列表，包含当前缓冲区
的当前诊断列表。要使用从语言服务器收到的最新诊断自动刷新
位置列表，您可以将 "autoPopulateDiags" 选项设置为 |v:true|。
默认情况下，此选项设置为 |v:false|。当收到缓冲区的新诊断时，
如果已存在包含诊断的位置列表，则会使用新诊断刷新。

在 GUI Vim 或启用了 'balloonevalterm' 选项的终端 Vim 中，
一个有用的功能是当您将鼠标悬停在受影响的文本范围上时，
在弹出气球中显示诊断消息。这提供了在不执行额外命令或导航
位置列表的情况下快速访问诊断信息的便捷方式。

默认情况下，LSP 插件配置为在弹出气球中显示诊断消息，增强
用户体验，并在您与代码交互时提供视觉反馈。此默认行为由
"showDiagInBalloon" 选项控制，默认设置为 |v:true|。

但是，如果您不希望查看弹出气球中的诊断消息，而愿意仅依赖
其他方法，您可以灵活自定义此行为。通过将 "showDiagInBalloon"
选项设置为 |v:false|，您可以禁用弹出气球中的诊断消息显示。
如果您发现气球干扰或希望通过其他方式（如位置列表或状态行）
查看诊断，这可能很有用。

要在状态区域显示当前行的诊断消息，您可以将
"showDiagOnStatusLine" 选项设置为 |v:true|。默认情况下，
此选项设置为 |v:false|。

默认情况下，":LspDiag current" 命令在弹出窗口中显示当前行
的诊断消息。要在状态消息区域显示消息，您可以将
'showDiagInPopup' 选项设置为 |v:false|。默认值为 |v:true|。

lsp#diag#GetDiagsForBuf() 函数可用于获取缓冲区中所有 LSP
诊断信息。此函数可选地接受缓冲区编号。如果未指定缓冲区
编号参数，则使用当前缓冲区。此函数返回按行和列号排序的
|List| 诊断信息。每个诊断信息是语言服务器返回的 |Dict|。

==============================================================================
							*lsp-tagfunc*
9. 标签函数~

|:LspGotoDefinition| 命令可用于跳转到符号定义的位置。要使用
Vim |tag-commands| 跳转到符号定义，您可以将 'tagfunc' 选项
设置为 'lsp#lsp#TagFunc' 函数： >

	setlocal tagfunc=lsp#lsp#TagFunc
<
设置上述选项后，您可以使用 |Ctrl-]| 和其他标签相关命令跳转
到符号定义。

对于基于光标的跳转（例如 |Ctrl-]|），标签函数使用
"textDocument/definition"。对于显式的基于模式的标签查找
（例如带有符号名称的 |:tag| 或 |:tjump|），它使用
"workspace/symbol" 并仅保留精确匹配的符号名称。

注意，大多数语言服务器即使符号在代码中多处定义，也只返回
一个符号位置。

==============================================================================
							*lsp-format*
10. 代码格式化~

|:LspFormat| 命令可用于使用语言服务器格式化整个文件或选定
的行范围。格式化时会使用当前缓冲区的 'shiftwidth' 和
'expandtab' 值。

要使用 'gq' 命令格式化代码，您可以设置 'formatexpr' 选项： >

    setlocal formatexpr=lsp#lsp#FormatExpr()
<
						*lsp-on-type-format*
如果语言服务器支持且 |lsp-opt-onTypeFormatting| 选项设置为
true，则在您键入语言服务器指定的触发字符之一时（例如，
clangd 在您按 <Enter> 时重新缩进当前行），代码会在输入时
被重新格式化。此选项默认禁用，因为它会在您输入时编辑缓冲
区。

==============================================================================
							*lsp-call-hierarchy*
11. 调用层次结构~

|:LspIncomingCalls| 和 |:LspOutgoingCalls| 命令可用于显示
符号的调用层次结构。例如，调用函数的函数或被函数调用的
函数。结果显示在名为 "LSP-CallHierarchy" 的临时窗口中。
第一行标识窗口显示的是所选符号的传入调用还是传出调用。
下方的树从所选符号本身开始。

每个树条目显示符号名称以及包含该符号的文件名和父目录。
子项会在您展开条目时按需加载，因此只有在您请求时才会查询
层次结构的更深层。

使用常规的 Vim 运动命令在树中导航。当您刷新层次结构或在
传入和传出视图之间切换时，会重用相同的窗口。

在调用层次结构树窗口中，支持以下按键：

<Enter>			跳转到光标下符号的位置。
-			展开光标下的符号。如果尚未检索到子项，
			则首先查询语言服务器。
+			折叠光标下的符号。

您可以在该窗口中显示传入调用层次结构或传出调用层次结构。
您不能同时显示两者。

在调用层次结构树窗口中，支持以下命令：

						*:LspCallHierarchyRefresh*
:LspCallHierarchyRefresh	再次查询语言服务器获取顶层
			符号，并刷新调用层次结构树。
			这会丢弃所有缓存的子项，并从顶层
			符号重新加载层次结构。

						*:LspCallHierarchyIncoming*
:LspCallHierarchyIncoming	显示顶层符号的传入调用层次
			结构。如果窗口当前显示传出调用，
			则会刷新以显示传入调用。
						*:LspCallHierarchyOutgoing*
:LspCallHierarchyOutgoing	显示顶层符号的传出调用层次
			结构。如果窗口当前显示传入调用，
			则会刷新以显示传出调用。

如果语言服务器无法为光标下的符号准备调用层次结构，或者没有
返回调用者/被调用者，则会显示警告消息而不是打开层次结构
窗口。

==============================================================================
							*lsp-autocmds*
12. 自动命令~

							*LspSetup*
LspSetup			LSP 插件加载时触发的 |User| 自动命令。
				可用于使用 |LspAddServer()| 函数添加
				语言服务器，并使用 |LspOptionsSet()|
				函数设置插件选项。

							*LspAttached*
LspAttached			所有附加到缓冲区的语言服务器
				准备就绪且缓冲区特定的 LSP 功能
				初始化完成后触发的 |User| 自动命令。
				可用于配置缓冲区本地映射或选项。

				如果当所有服务器准备就绪时缓冲区
				不是当前缓冲区，则自动命令会延迟
				到您下次进入该缓冲区时触发。

							*g:LspAttachedContext*
				附加上下文在 |g:LspAttachedContext|
				全局变量中可用，为包含以下项的
				字典：

				  bufnr		附加的缓冲区编号
				  file		附加的缓冲区文件名
						（绝对路径）。
				  servers	附加的语言服务器名称的
					|List|。

				示例： >

				  autocmd User LspAttached {
				    var ctx = get(g:, 'LspAttachedContext', {})
				    echom $'Attached {ctx->get("file", "")} '
						.. $'(buf {ctx->get("bufnr", -1)})'
				  }
<
							*LspDetached*
LspDetached			当缓冲区从所有附加的语言服务器
				中移除时触发的 |User| 自动命令。
				这可能发生在缓冲区被擦除时、当
				|LspDisable()| 从所有附加的服务器
				中移除缓冲区时。

				此自动命令在缓冲区从所有附加的
				语言服务器分离后，每个缓冲区触发
				一次。可用于清理缓冲区本地映射、
				弹出窗口或其他 LSP 相关状态。

							*g:LspDetachedContext*
				分离上下文在 |g:LspDetachedContext|
				全局变量中可用，为包含以下项的
				字典：

				  bufnr		分离的缓冲区编号
				  file		分离的缓冲区文件名
				  servers	分离的语言服务器名称的
					|List|。

				示例： >

				  autocmd User LspDetached {
				    var ctx = get(g:, 'LspDetachedContext', {})
				    echom $'Detached {ctx->get("file", "")} '
						.. $'(buf {ctx->get("bufnr", -1)})'
				  }
<

							*LspDiagsUpdated*
LspDiagsUpdated			从语言服务器收到新诊断时触发的
				|User| 自动命令。在 LSP 客户端
				处理完诊断并更新内部诊断状态后
				调用。可以使用
				lsp#diag#GetDiagsForBuf() 函数
				获取缓冲区的所有诊断。

				如果在插入/替换模式时收到诊断，
				诊断符号/内联高亮/虚拟文本会
				在返回普通模式后刷新。

							*LspOutlineSetup*
LspOutlineSetup			使用 |:LspOutline| 创建大纲窗口后
				触发的 |User| 自动命令。大纲窗口
				将成为活动窗口。这主要用于更改
				窗口设置——窗口内容会在之后填充，
				|LspOutlineUpdated| 可用于在内容
				更新后执行操作。

							*LspOutlineUpdated*
LspOutlineUpdated			大纲窗口内容更新后触发的
				|User| 自动命令，包括在打开时
				的初始填充。大纲窗口将成为活动
				窗口。

							*LspProgressUpdate*
LspProgressUpdate			从语言服务器收到进度通知
				($/progress) 时触发的 |User| 自动
				命令。这可用于更新状态行组件。
				当前进度状态存储在 |g:LspProgress|
				中。

							*g:LspProgress*
g:LspProgress			包含所有语言服务器当前进度状态
				的 |Dictionary|。键是进度令牌，
				值是包含以下字段的字典：

				  title		操作的标题
				  message	当前进度消息
				  percentage	进度百分比（0-100），
					或 -1（如果不可用）
				  serverName	LSP 服务器名称

				状态行函数示例： >

				  def LspProgressStatus(): string
				    if empty(g:LspProgress)
				      return ''
				    endif
				    for info in values(g:LspProgress)
				      var parts = []
				      if !empty(info.title)
					parts->add(info.title)
				      endif
				      if info.percentage >= 0
					parts->add(info.percentage .. '%')
				      endif
				      return parts->join(' ')
				    endfor
				    return ''
				  enddef
<
==============================================================================
							*lsp-highlight-groups*
13. 高亮组~

LSP 插件使用以下高亮组。您可以在加载此插件之前在 .vimrc
文件中定义这些高亮组以覆盖它们。

*LspDiagInlineError*		用于高亮内联错误诊断。
				默认链接到 "SpellBad" 高亮组。
*LspDiagInlineHint*		用于高亮内联提示诊断。
				默认链接到 "SpellLocal" 高亮组。
*LspDiagInlineInfo*		用于高亮内联信息诊断。
				默认链接到 "SpellRare" 高亮组。
*LspDiagInlineWarning*		用于高亮内联警告诊断。
				默认链接到 "SpellCap" 高亮组。
*LspDiagLine*			用于高亮带有一个或多个诊断的行。
				默认链接到 "NONE"（已清除）。
				您可以将其链接到高亮组以高亮行。
*LspDiagSignErrorText*		用于高亮错误诊断符号文本。
				默认链接到 'ErrorMsg'。
*LspDiagSignHintText*		用于高亮提示诊断符号文本。
				默认链接到 'Question'。
*LspDiagSignInfoText*		用于高亮信息诊断符号文本。
				默认链接到 'Pmenu'。
*LspDiagSignWarningText*	用于高亮警告诊断符号文本。
				默认链接到 'Search'。
*LspDiagVirtualText*		用于高亮诊断虚拟文本。
				默认链接到 "LineNr" 高亮组。
*LspDiagVirtualTextError*	用于高亮错误诊断的虚拟文本。
				默认链接到 "SpellBad" 高亮组。
*LspDiagVirtualTextHint*	用于高亮提示诊断的虚拟文本。
				默认链接到 "SpellLocal" 高亮组。
*LspDiagVirtualTextInfo*	用于高亮信息诊断的虚拟文本。
				默认链接到 "SpellRare" 高亮组。
*LspDiagVirtualTextWarning*	用于高亮警告诊断的虚拟文本。
				默认链接到 "SpellCap" 高亮组。
*LspInlayHintsParam*		用于高亮类型为 "parameter" 的
				内联提示。默认链接到 "Conceal"
				高亮组。
*LspInlayHintsType*		用于高亮类型为 "type" 的内联提示。
				默认链接到 "Label" 高亮组。
*LspPopup*			用于高亮弹出内容。默认链接到
				"Pmenu" 高亮组。
*LspPopupBorder*		用于高亮弹出边框。默认链接到
				"Pmenu" 高亮组。
*LspSigActiveParameter*		用于高亮活动签名参数。
				默认链接到 "LineNr" 高亮组。
*LspSymbolName*			用于在使用 |:LspDocumentSymbol|
				命令时高亮符号名称。默认链接到
				"Search" 高亮组。
*LspSymbolRange*		用于在使用 |:LspDocumentSymbol|
				命令时高亮包含符号的行范围。
				默认链接到 "Visual" 高亮组。

例如，要覆盖用于诊断虚拟文本的高亮，您可以使用以下方式： >

    highlight LspDiagVirtualText ctermfg=Cyan guifg=Blue
<
或 >

    highlight link LspDiagLine DiffAdd
    highlight link LspDiagVirtualText WarningMsg
<
==============================================================================
						*lsp-semantic-highlighting*
14. 语义高亮~

语义高亮使用 LSP 语义令牌特性，比普通语法高亮提供更精确的
高亮。例如，语言服务器可以区分类名、函数名、参数和枚举成员，
即使它们使用类似的文本。

语义文本属性会与现有语法高亮结合，因此这通常是在缓冲区中
已经显示的颜色基础上进行细化，而不是完全替换它们。

要使用语义高亮，请将 |lsp-opt-semanticHighlight| 设置为
|true|，并使用支持语义令牌的语言服务器。启用后，插件会
请求当前缓冲区的语义令牌，并在缓冲区更改后刷新它们（使用
|TextChanged| 自动命令），延迟由
|lsp-opt-semanticHighlightDelay| 配置。如果服务器支持语义
令牌增量更新，则会自动使用。

只有以下列出的语义令牌类型在本插件中有内置的高亮组。如果
语言服务器返回其他令牌类型，它们将被忽略，除非扩展插件以
处理它们。

*LspSemanticNamespace*		用于高亮类型为 "namespace" 的
				语义令牌。默认链接到 "Type"
				高亮组。
*LspSemanticType*		用于高亮类型为 "type" 的语义
				令牌。默认链接到 "Type" 高亮组。
*LspSemanticClass*		用于高亮类型为 "class" 的语义
				令牌。默认链接到 "Type" 高亮组。
*LspSemanticEnum*		用于高亮类型为 "enum" 的语义
				令牌。默认链接到 "Type" 高亮组。
*LspSemanticInterface*		用于高亮类型为 "interface" 的
				语义令牌。默认链接到 "TypeDef"
				高亮组。
*LspSemanticStruct*		用于高亮类型为 "struct" 的语义
				令牌。默认链接到 "Type" 高亮组。
*LspSemanticTypeParameter*	用于高亮类型为 "typeParameter"
				的语义令牌。默认链接到 "Type"
				高亮组。
*LspSemanticParameter*		用于高亮类型为 "parameter" 的
				语义令牌。默认链接到 "Identifier"
				高亮组。
*LspSemanticVariable*		用于高亮类型为 "variable" 的
				语义令牌。默认链接到 "Identifier"
				高亮组。
*LspSemanticProperty*		用于高亮类型为 "property" 的
				语义令牌。默认链接到 "Identifier"
				高亮组。
*LspSemanticEnumMember*		用于高亮类型为 "enumMember" 的
				语义令牌。默认链接到 "Constant"
				高亮组。
*LspSemanticEvent*		用于高亮类型为 "event" 的语义
				令牌。默认链接到 "Identifier"
				高亮组。
*LspSemanticFunction*		用于高亮类型为 "function" 的
				语义令牌。默认链接到 "Function"
				高亮组。
*LspSemanticMethod*		用于高亮类型为 "method" 的语义
				令牌。默认链接到 "Function"
				高亮组。
*LspSemanticMacro*		用于高亮类型为 "macro" 的语义
				令牌。默认链接到 "Macro" 高亮组。
*LspSemanticKeyword*		用于高亮类型为 "keyword" 的
				语义令牌。默认链接到 "Keyword"
				高亮组。
*LspSemanticModifier*		用于高亮类型为 "modifier" 的
				语义令牌。默认链接到 "Type"
				高亮组。
*LspSemanticComment*		用于高亮类型为 "comment" 的
				语义令牌。默认链接到 "Comment"
				高亮组。
*LspSemanticString*		用于高亮类型为 "string" 的语义
				令牌。默认链接到 "String" 高亮组。
*LspSemanticNumber*		用于高亮类型为 "number" 的语义
				令牌。默认链接到 "Number" 高亮组。
*LspSemanticRegexp*		用于高亮类型为 "regexp" 的语义
				令牌。默认链接到 "String" 高亮组。
*LspSemanticOperator*		用于高亮类型为 "operator" 的
				语义令牌。默认链接到 "Operator"
				高亮组。
*LspSemanticDecorator*		用于高亮类型为 "decorator" 的
				语义令牌。默认链接到 "Macro"
				高亮组。

==============================================================================
							*lsp-debug*
15. 调试~

要调试此插件，您可以记录插件与语言服务器之间发送和接收的
语言服务器协议 (LSP) 消息。以下命令为当前缓冲区启用来自
语言服务器消息的日志记录： >

    :LspServer debug on
<
此命令也会清除现有的日志文件。以下命令为当前缓冲区禁用
来自语言服务器消息的日志记录： >

    :LspServer debug off
<
默认情况下，不记录消息。或者，您可以通过在添加语言服务器时
使用 |LspAddServer()| 函数将 "debug" 字段设置为 true 来启用
调试。

语言服务器打印到 stdout 的消息记录到 lsp-<server-name>.log
文件，打印到 stderr 的消息记录到 lsp-<server-name>.err 文件。
这些文件使用的目录确定如下：

  Linux/macOS：日志存储在 /tmp 中。如果 /tmp 缺失或不可写，
               则使用 $TMPDIR 指定的目录。
  MS-Windows：日志存储在 %TEMP% 指定的目录中。

以下命令打开包含语言服务器打印到 stdout 的消息的文件： >

    :LspServer debug messages
<
以下命令打开包含语言服务器打印到 stderr 的消息的文件： >

    :LspServer debug errors
<
要调试语言服务器初始化问题，在启用服务器调试后，您可以使用
以下命令重启当前缓冲区文件类型的服务器： >

    :LspServer restart
<
语言服务器通常支持启用调试消息和增加详细程度的命令行选项。
您可以参考语言服务器文档获取此信息。您可以在注册语言服务器
时将这些选项包含在此插件中。

如果语言服务器支持 "$/logTrace" LSP 通知，您可以使用
":LspServer trace" 命令设置服务器跟踪值： >

    :LspServer trace { off | messages | verbose }
<
==============================================================================
							*lsp-custom-commands*
16. 自定义命令处理器~

						*LspRegisterCmdHandler()*
						*g:LspRegisterCmdHandler()*
在应用代码操作时，语言服务器可能发出非标准命令。例如，
Java 语言服务器使用非标准命令（如 java.apply.workspaceEdit）。
要处理这些命令，您可以使用 LspRegisterCmdHandler() 函数为
每个命令注册回调函数。例如： >

    vim9script
    import autoload "lsp/textedit.vim"

    def WorkspaceEdit(cmd: dict<any>)
      for editAct in cmd.arguments
	  textedit.ApplyWorkspaceEdit(editAct)
      endfor
    enddef
    g:LspRegisterCmdHandler('java.apply.workspaceEdit', WorkspaceEdit)
<
将上述代码放在名为 lsp_java/plugin/lsp_java.vim 的文件中，
并加载此插件。

回调函数应接受一个 Dict 参数。Dict 参数包含 LSP Command
接口字段。有关 "Command" 接口的更多信息，请参阅 LSP 规范。

如果未为命令注册自定义处理器，则使用标准
|workspace/executeCommand| 请求将命令发送到服务器。
如果已注册的处理程序抛出异常，插件会报告错误消息并继续运行。

==============================================================================
							*lsp-custom-requests*
17. 自定义 LSP 请求~

lsp.Server() 函数可用于获取当前缓冲区的 LSP 服务器。如果
没有 LSP 服务器，则返回空字典。

返回的字典具有以下方法：

	getPosition(find_ident: bool): dict<number>
		返回当前光标位置作为 LSP 位置。
		find_ident 将搜索光标前的标识符，类似于
		CTRL-] 和 c_CTRL-R_CTRL-W。

		LSP 行号和列号从零开始，而 Vim 行号和列号
		从一开始。LSP 列号是行中的字符索引，而不是
		行中的字节索引。

	getTextDocPosition(find_ident: bool): dict<dict<any>>
		返回当前文件名和当前光标位置作为 LSP
		TextDocumentPositionParams 结构。

	featureEnabled(feature: string): bool
		当 lspserver 启用了某项功能时返回 true。
		默认情况下，lsp 服务器的所有功能都启用。

	rpc(method: string, params: any, opts: dict<any> = {}): dict<any>
		向 LSP 服务器发送同步 RPC 请求消息，并返回
		接收到的回复。如果出错，返回空 Dict。

	rpc_a(method: string, params: any, Cbfunc: func): number
		向 LSP 服务器发送异步 RPC 请求消息，并带有
		回调函数。返回 LSP 消息 id。此 id 可用于取消
		RPC 请求（如果需要）。出错时返回 -1。

一些示例：

	使用同步 rpc() 调用的 |:LspShowSignature| 版本，也适用
	于括号内：
>
            import autoload 'lsp/lsp.vim'

            def g:FindSig()
                var s = lsp.Server()
                if s->empty()
                    return
                endif

                var sig = s.rpc('textDocument/signatureHelp', s.getTextDocPosition(false))
                if sig.result->empty()
                    var save = winsaveview()
                    normal! F(
                    if getline('.')[charcol('.') - 1] == '('
                        sig = s.rpc('textDocument/signatureHelp', s.getTextDocPosition(false))
                    endif
                    winrestview(save)
                endif

                echon "\r\r"
                if sig.result->empty()
                    echon 'No signature found'
                else
                    echon sig.result.signatures[0].label
                endif
            enddef
            nnoremap <C-k> :call g:FindSig()<CR>
<
	使用异步 a_rpc() 调用来查找并回显签名：
>
            import autoload 'lsp/lsp.vim'

            def FindSigReply(s: dict<any>, sig: any)
                echon "\r\r"
                if sig->empty()
                    echon 'No signature found'
                else
                    echon sig.signatures[0].label
                endif
            enddef

            def g:FindSigAsync()
                var s = lsp.Server()
                if s->empty()
                    return
                endif
                s.rpc_a('textDocument/signatureHelp', s.getTextDocPosition(false), FindSigReply)
            enddef
            nnoremap <C-k> :call g:FindSigAsync()<CR>
<
				*LspRequestCustom()* *g:LspRequestCustom()*
LspRequestCustom({name}, {method}, {params}) 函数可用于向当前
缓冲区的名为 {name} 的语言服务器发送异步自定义请求。这对于
未由内置命令或辅助函数包装的非标准请求很有用。如果没有
匹配的语言服务器附加到当前缓冲区，则不发送请求。

==============================================================================
							*lsp-custom-kinds*
18. 自定义 LSP 补全类型~

当触发补全弹出窗口时，LSP 客户端将使用默认类型列表显示在
补全 "kind" 部分，要自定义它，您需要使用
|lsp-opt-customCompletionKinds| 选项，并在
|lsp-opt-completionKinds| 选项中设置所有自定义类型。以下是
所有默认 LSP 类型的表格：

 类型名称              | 值
------------------------|--------------------
 Text                   | t
 Method                 | m
 Function               | f
 Constructor            | C
 Field                  | F
 Variable               | v
 Class                  | c
 Interface              | i
 Module                 | M
 Property               | p
 Unit                   | u
 Value                  | V
 Enum                   | e
 Keyword                | k
 Snippet                | S
 Color                  | C
 File                   | f
 Reference              | r
 Folder                 | F
 EnumMember             | E
 Constant               | d
 Struct                 | s
 Event                  | E
 Operator               | o
 TypeParameter          | T
 Buffer                 | B

例如，如果您想将 "Method" 类型更改为 "method()"： >

	vim9script

	g:LspOptionsSet({
		customCompletionKinds: true,
		completionKinds: {
			"Method": "method()"
		}
	})
<
在补全弹出窗口中，将显示类似： >

	var file = new File()

	file.cre
		| create                method() |
		| createIfNotExists     method() |
		| ...				 |
<
==============================================================================
						*lsp-custom-popup-styles*
19. 自定义弹出框样式~

插件提供了根据个人喜好设置弹出框样式的可能性。默认情况下，
弹出框没有边框，并使用 |hl-Pmenu| 高亮组。

要更改全局弹出框样式，请使用通用弹出 |lsp-options|： >

    # 启用弹出边框
    autocmd User LspSetup LspOptionsSet({popupBorder: true})

    # 更改弹出边框字符和高亮，并禁用 SignatureHelp 边框
    var lspOpts = {
      popupBorder: true,
      popupBorderChars: ['-', '|', '-', '|', '┌', '┐', '┘', '└'],
      popupBorderHighlight: 'Identifier',
      popupHighlight: 'Normal',
      popupBorderSignatureHelp: false,
      popupHighlightSignatureHelp: 'Pmenu'
    }
    autocmd User LspSetup LspOptionsSet(lspOpts)
>
不同的弹出类型都可以单独自定义，使用弹出类型 |lsp-options|： >

    # - Hover
    #   - 边框高亮：ModeMsg
    # - Completion
    #   - 边框：关闭
    #   - 高亮：Pmenu
    # - Symbol menu input
    #   - 边框高亮：Title
    # - Symbol menu
    #   - 边框高亮：Directory
    var lspOpts = {
      popupBorder: true,
      popupBorderHighlightHover: 'ModeMsg',
      popupBorderCompletion: false,
      popupHighlightCompletion: 'Pmenu',
      popupBorderHighlightSymbolMenuInput: 'Title',
      popupBorderHighlightSymbolMenu: 'Directory'
    }
    autocmd User LspSetup LspOptionsSet(lspOpts)
<
有关补全菜单的样式设置，请参阅 |hl-pmenu|。

==============================================================================
							*lsp-custom-locations*
20. 自定义位置请求~

				    *LspFindLocations()* *g:LspFindLocations()*
语言服务器可能支持非标准位置请求。要显示光标下符号的位置，
您可以使用 g:LspFindLocations(server_name, peek, method, args)
函数。"server_name" 是您传递给 LspAddServer() 的 "name"。
"peek" 是布尔值。如果为 true，则在弹出菜单中显示位置列表，
否则在新的位置列表中显示。请求参数从当前缓冲区和光标位置
构建，然后与可选的 {args} 字典合并。命名的语言服务器必须
附加到当前缓冲区、正在运行并准备就绪。其行为类似于
|:LspPeekReferences| 和 |:LspShowReferences|。例如： >

    vim9script

    g:LspAddServer([{
	filetype: ["cpp"],
	name: 'ccls',
	path: '/usr/bin/ccls',
    }])

    autocmd Filetype cpp {
	# x (xref)
	# bases of up to 3 levels
	nmap <buffer> <localleader>b <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {})<cr>
	nmap <buffer> <localleader>B <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {"levels": 3})<cr>
	# derived of up to 3 levels
	nmap <buffer> <localleader>d <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {"derived": v:true})<cr>
	nmap <buffer> <localleader>D <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/inheritance", {"derived": v:true, "levels": 3})<cr>
	# caller
	nmap <buffer> <localleader>c <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/call")<cr>
	# callee
	nmap <buffer> <localleader>C <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/call", {"callee": v:true})<cr>
	# member
	nmap <buffer> <localleader>m <scriptcmd>g:LspFindLocations('ccls', false, "$ccls/member")<cr>
    }

==============================================================================
							*lsp-multiple-servers*
21. 一个缓冲区的多个语言服务器~

可以为给定的缓冲区运行多个语言服务器。

默认情况下，大多数功能一次使用一个语言服务器：先定义的语言
服务器尽可能多地使用，然后使用下一个，以此类推。所有运行中
的语言服务器的诊断会合并。

代码操作是一个例外：|:LspCodeAction|、|:LspAutoFix|、
|:LspFixAll| 和 |:LspOrganizeImports| 从所有附加的合格语言
服务器请求操作，并呈现合并的操作列表。

当选择操作时，它始终由产生该操作的语言服务器解析/执行。

如果合并列表中存在重复的操作标题，操作菜单只会为那些重复
标题的条目附加源服务器名称。

这意味着您可以先定义一个仅支持子集功能的语言服务器，然后
再定义通用语言服务器：
>
	vim9script

	g:LspAddServer([
		# 此语言服务器报告仅支持
		# textDocument/documentFormatting，因此它将用于
		# :LspFormat，但不用于其他功能。
		{
			filetype: ['html'],
			path: 'html-pretty-lsp',
			args: ['--stdio']
		},
		# 此语言服务器也支持
		# textDocument/documentFormatting，但由于它是后定义的，
		# 上面的服务器将优先使用。
		# 然而此服务器也支持
		# textDocument/definition、textDocument/declaration 等，
		# 因此它将用于 :LspGotoDefinition、
		# :LspGotoDeclaration 等。
		{
			filetype: ['html'],
			path: 'html-language-server',
			args: ['--stdio']
		}
	])
<
如示例所示，语言服务器定义的顺序会考虑用于给定方法。
但有时您想要用于格式化的语言服务器也报告支持其他功能。
在这种情况下，您可以做两件事之一：

1. 更改语言服务器的顺序，并指定给定语言服务器应用于
   给定方法。

2. 在 features |Dictionary| 中将不需要的功能设置为 |false|： >

	features: { 'codeAction': false }
<
例如，如果您想将 efm-langserver 用于格式化，但将
typescript-language-server 用于其他所有功能： >

	vim9script

	g:LspAddServer([
		# 此语言服务器默认使用，因为它是为
		# 'javascript' 和 'typescript' 定义的第一个 LSP。
		{
			filetype: ['javascript', 'typescript'],
			path: '/usr/local/bin/typescript-language-server',
			args: ['--stdio']
		},
		# 此语言服务器将用于 documentFormatting
		{
			filetype: ['javascript', 'typescript'],
			path: '/usr/local/bin/efm-langserver',
			args: [],
			features: {
				documentFormatting: true
			}
		}
	])
<
另一种方法是禁用不需要的功能：例如，如果您不想要
typescript-language-server 的诊断，但想将其用于其他所有
功能： >

	vim9script

	g:LspAddServer([
		{
			filetype: ['javascript', 'typescript'],
			path: '/usr/local/bin/typescript-language-server',
			args: ['--stdio'],
			features: {
				diagnostics: false
			}
		},
	])
<
==============================================================================
							*lsp-features*
22. 语言服务器功能~

当为给定文件类型使用多个语言服务器时，通过提供配置
|lsp-cfg-features|，可以指定哪个语言服务器应用于给定方法/
功能。支持以下功能标志：参见 |lsp-multiple-servers| 的示例。

						*lsp-features-callHierarchy*
callHierarchy			由 |:LspIncomingCalls| 和
				|:LspOutgoingCalls| 命令使用。
						*lsp-features-codeAction*
codeAction			由 |:LspCodeAction| 命令使用。
						*lsp-features-codeLens*
codeLens			由 |:LspCodeLens| 命令使用。
						*lsp-features-completion*
completion			用于 24/7 补全和 'omnifunc'
						*lsp-features-declaration*
declaration			由 |:LspGotoDeclaration| 和
				|:LspPeekDeclaration| 命令使用。
						*lsp-features-definition*
definition			由 |:LspGotoDefinition| 和
				|:LspPeekDefinition| 命令使用。
						*lsp-features-diagnostics*
diagnostics			用于禁用单个语言服务器的诊断，
				默认情况下所有运行中服务器的诊断
				会合并，通过将此设置为 |false|
				可以忽略特定服务器的诊断。
					*lsp-features-documentFormatting*
documentFormatting		由 |:LspFormat| 命令和
				'formatexpr' 使用。
					*lsp-features-documentHighlight*
documentHighlight		由 |:LspHighlight| 和
				|:LspHighlightClear| 命令使用。
					*lsp-features-documentSymbol*
documentSymbol			由 |:LspDocumentSymbol| 和
				|:LspOutline| 命令使用。
						*lsp-features-foldingRange*
foldingRange			由 |:LspFold| 命令使用。
						*lsp-features-hover*
hover				由 |:LspHover| 命令使用。
						*lsp-features-implementation*
implementation			由 |:LspGotoImpl| 和
				|:LspPeekImpl| 命令使用。
						*lsp-features-inlayHint*
inlayHint			用于显示内联提示：在缓冲区中
				以虚拟文本形式显示的推断类型
				注释和参数名称标签。由
				|lsp-opt-showInlayHints| 和
				|:LspInlayHints| 控制。
						*lsp-features-references*
references			由 |:LspShowReferences| 命令使用。
						*lsp-features-rename*
rename				由 |:LspRename| 命令使用。
						*lsp-features-selectionRange*
selectionRange			由 |:LspSelectionExpand| 和
				|:LspSelectionShrink| 命令使用。
						*lsp-features-semanticTokens*
semanticTokens			当语言服务器提供语义令牌时，
				由 |lsp-opt-semanticHighlight|
				使用。
						*lsp-features-signatureHelp*
signatureHelp			由 |:LspShowSignature| 命令使用。
						*lsp-features-typeDefinition*
typeDefinition			由 |:LspGotoTypeDef| 和
				|:LspPeekTypeDef| 命令使用。
						*lsp-features-typeHierarchy*
typeHierarchy			由 |:LspSubTypeHierarchy| 和
				|:LspSuperTypeHierarchy| 命令使用。
workspaceSymbol			由 |:LspSymbolSearch| 命令使用。

==============================================================================
							*lsp-license*
23. 许可证~

许可证：MIT 许可证
版权所有 (c) 2020-2026 Yegappan Lakshmanan

特此免费授予任何获得本软件及其相关文档文件（“软件”）副本
的人无限制使用本软件的权利，包括但不限于使用、复制、修改、
合并、发布、分发、再许可和/或销售本软件副本的权利，并允许
向其提供本软件的人这样做，但须满足以下条件：

上述版权声明和本许可声明应包含在本软件的所有副本或重要
部分中。

本软件按“原样”提供，不提供任何形式的明示或暗示保证，包括
但不限于适销性、特定用途适用性和非侵权性的保证。在任何
情况下，作者或版权持有人均不对任何索赔、损害或其他责任
负责，无论是在合同、侵权或其他方面，由本软件或本软件的
使用或其他交易引起、与之相关或与之连接。

==============================================================================

vim:tw=78:ts=8:noet:ft=help:norl:
