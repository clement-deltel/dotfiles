# Software <!-- omit in toc -->

Here is a list of tools that could be interesting and further enhance the stack, as well as tools that I no longer use or which are obsolete.

## Table of Contents <!-- omit in toc -->

- [Linux](#linux)
- [Microsoft Windows](#microsoft-windows)
- [Browser extensions](#browser-extensions)
- [Visual Studio Code extensions](#visual-studio-code-extensions)

## Linux

Enhancements:

- **Artificial Intelligence (AI)**
  - [cocommit](https://github.com/andrewromanenco/cocommit): cli that works with your HEAD commit and leverages an LLM of your choice to enhance commit quality.
  - [OpenCommit](https://github.com/di-sukharev/opencommit): generate commit messages by an LLM in 1 sec.
- **Containers**
  - [copacetic](https://github.com/project-copacetic/copacetic): cli tool for directly patching container images.
  - [Docker Bench](https://github.com/docker/docker-bench-security): script that checks for dozens of common best-practices around deploying Docker containers in production.
  - [dozzle](https://github.com/amir20/dozzle): realtime log viewer for docker containers.
  - [skopeo](https://github.com/containers/skopeo): work with remote images registries - retrieving information, images, signing content.
- **Docker**
  - new commands (require a Docker account and/or subscription): init, debug, compose watch, build cloud, scout.
- **Infrastructure as Code (IaC)**
  - [sst](https://sst.dev): build full-stack apps on your own infrastructure.
- **Integrated Development Environment (IDE)**
  - [Cursor](https://github.com/getcursor/cursor): AI code editor.
  - [Zed](https://github.com/zed-industries/zed): high-performance, multiplayer code editor from the creators of Atom and Tree-sitter.
- **Security**
  - [Clair](https://github.com/quay/clair): vulnerability static analysis for containers.
  - [Google OSV](https://github.com/google/osv.dev): Open source vulnerability DB and triage service.
  - [terrascan](https://github.com/tenable/terrascan): detect compliance and security violations across Infrastructure as Code to mitigate risk before provisioning cloud native infrastructure.
- **Shell**
  - **Commands**
    - [ag](https://github.com/ggreer/the_silver_searcher): code-searching tool similar to ack, but faster.
    - [atuin](https://github.com/atuinsh/atuin): magical shell history.
    - [dust](https://github.com/bootandy/dust): a more intuitive version of du, written in Rust.
    - [fd](https://github.com/sharkdp/fd): simple, fast and user-friendly alternative to 'find'.
    - [ls-lint](https://github.com/loeffel-io/ls-lint): directory and filename linter, bring some structure to your project filesystem.
    - [midnight commander](https://github.com/MidnightCommander/mc)
    - [ripgrep](https://github.com/BurntSushi/ripgrep): recursively searches directories for a regex pattern while respecting your gitignore.
    - [thefuck](https://github.com/nvbn/thefuck): magnificent app which corrects your previous console command.
  - **Files**
    - [entr](https://github.com/eradman/entr): run arbitrary commands when files change.
    - [yazi](https://github.com/sxyazi/yazi): terminal file manager based on async I/O, written in Rust.
  - **Multiplexer**
    - [tmux](https://github.com/tmux/tmux)
    - [zellij](https://github.com/zellij-org/zellij)
  - **System Info**
    - [fastfetch](https://github.com/fastfetch-cli/fastfetch)
    - [nerdfetch](https://github.com/ThatOneCalculator/NerdFetch)
    - [macchina](https://github.com/Macchina-CLI/macchina)
    - [powertop](https://github.com/fenrus75/powertop)
    - [sampler](https://github.com/sqshq/sampler)
  - **Text Editors**
    - [Lazy NVim](https://github.com/folke/lazy.nvim): modern plugin manager for Neovim.
    - [xan](https://github.com/medialab/xan): csv magician.
  - **Tools**
    - [Autocomplete](https://github.com/withfig/autocomplete): IDE-style autocomplete for your existing terminal & shell.
    - [Cheat](https://github.com/cheat/cheat): create and view interactive cheatsheets on the command-line.
    - [Clipboard](https://github.com/Slackadays/Clipboard): smart clipboard manager.
    - [cmatrix](https://github.com/abishekvashok/cmatrix): terminal based "The Matrix" like implementation.
    - [Espanso](https://github.com/espanso/espanso): cross-platform text expander, written in Rust.
    - [hey](https://github.com/rakyll/hey): HTTP load generator, apachebench (ab) replacement.
    - [hyperfine](https://github.com/sharkdp/hyperfine): benchmarking cli.
    - [oha](https://github.com/hatoo/oha): HTTP load generator, with tui animation.
    - [pmd](https://github.com/pmd/pmd): extensible multilanguage static code analyzer.
  - **zsh**
    - [zsh-auto-notify](https://github.com/MichaelAquilina/zsh-auto-notify)
- **Version Control**
  - [better commits](https://github.com/Everduin94/better-commits): CLI for creating better commits following the conventional commits specification.
  - [commitlint](https://github.com/conventional-changelog/commitlint): lint commit messages.
  - [delta](https://github.com/dandavison/delta): syntax-highlighting pager for git, diff, grep, and blame output.
  - [difftastic](https://difftastic.wilfred.me.uk)
  - [gh-dash](https://github.com/dlvhdr/gh-dash): beautiful CLI dashboard for GitHub.
  - [gitbutler](https://github.com/gitbutlerapp/gitbutler): GitButler version control client.
  - [gitu](https://github.com/altsem/gitu): TUI git client inspired by Magit.
  - [git-appraise](https://github.com/google/git-appraise): distributed code review system for git repos.
  - [git-bug](https://github.com/git-bug/git-bug): distributed, offline-first bug tracker embedded in git, with bridges.
  - [git-plan](https://github.com/rorybyrne/git-plan): a better workflow for git.
  - [git-sim](https://github.com/initialcommit-com/git-sim): visually simulate Git operations in your own repos with a single terminal command.
  - [git-xargs](https://github.com/gruntwork-io/git-xargs): cli for making updates across multiple Github repositories with a single command.
  - [gitflow](https://github.com/nvie/gitflow): git extensions to provide high-level repository operations for Vincent Driessen's branching model.
  - [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli): gitmoji interactive cli tool for using emojis on commits.
  - [mergiraf](https://mergiraf.org)
  - [multi-gitter](https://github.com/lindell/multi-gitter): update multiple repositories in with one command.

Not using anymore:

- **Cloud**
  - [Cloudlens](https://github.com/one2nc/cloudlens): missing a lot of features, no longer maintained.

## Microsoft Windows

Enhancements:

- Chocolatey
  - **Benchmarking**
    - [Cinebench](https://community.chocolatey.org/packages/cinebench): real-world cross-platform test suite that evaluates your computer's hardware capabilities.
  - **Hardware Tweaks**
    - [MSI Afterburner](https://community.chocolatey.org/packages/msiafterburner): graphics card utility.
    - [OCCT](https://community.chocolatey.org/packages/occt): stability checking tool.
  - **Monitoring**
    - [CPU-Z](https://community.chocolatey.org/packages/cpu-z): system profiler (system monitor) application that detects the central processing unit, RAM, motherboard chipset, and other hardware features.
    - [GPU-Z](https://community.chocolatey.org/packages/gpu-z): utility designed to provide you with all information about your graphics card and GPU.
    - [Open Hardware Monitor](https://community.chocolatey.org/packages/openhardwaremonitor)
  - **Software Tweaks**
    - [Flow Launcher](https://community.chocolatey.org/packages/flow-launcher): Search everything from applications, files, bookmarks, YouTube, Twitter and more.
    - [Winaero Tweaker](https://community.chocolatey.org/packages/winaero-tweaker): all-in-one application that comes with dozens of options for fine-grained tuning of various Windows settings and features.
  - **Tools**
    - [Revo Uninstaller](https://community.chocolatey.org/packages/revo-uninstaller)
  - **Other**
    - Beeper
    - Discord
- Independently:
  - **Databases**
    - Oracle SQL Developer (Chocolatey package outdated)
    - OracleXE
  - **Hardware Tweaks**
    - [Fan Control](https://getfancontrol.com)
    - [Open RGB](https://openrgb.org/)
  - **Monitoring**
    - [Hardware Monitor](https://www.cpuid.com/softwares/hwmonitor.html)
  - **Security**
    - [Zed Encrypt](https://www.zedencrypt.com)
  - **Other**
    - Minecraft
    - Office 365

Not using anymore:

- Chocolatey
  - [Ant Renamer](https://community.chocolatey.org/packages/ant-renamer): make easier the renaming of lots of files and folders by using specified settings. **Reason**: using PowerToys PowerRename instead.
  - [PDF Gear](https://community.chocolatey.org/packages/pdfgear): read, edit, convert, merge, and sign PDF files across devices, for completely free and without signing up. **Reason**: too bloated and slow.
  - [TreeSize Free](https://community.chocolatey.org/packages/treesizefree): tells you where precious disk space has gone. **Reason**: using WizTree instead.
- Winget
  - [PDF Merger & Splitter](https://www.anywaysoft.com/pdf-merger-splitter/index.html): using pdftk in WSL2 instead.
- Other
  - [Google Chrome Desktop](https://remotedesktop.google.com): using RustDesk instead.

## Browser extensions

Not using anymore:

- **Ads & Tracking**
  - [Disconnect](https://chromewebstore.google.com/detail/disconnect/jeoacafpbcihiomhlakheieifhpjdfeo): disconnect tracker protection makes the web more private, secure, and faster.
- **Artificial Intelligence**
  - [AIPRM for ChatGPT](https://chromewebstore.google.com/detail/aiprm-for-chatgpt/ojnbohmppadfgpejeebfnmnknjdlckgj): list of curated prompt templates and advanced features.
  - [ChatGPT for Google](https://chromewebstore.google.com/detail/chatgpt-for-google/jgjaeacdkonaoafenlfkkkmbaopkbilf): display ChatGPT response alongside search engine results.
  - [Max Focus](https://chromewebstore.google.com/detail/maxfocus-link-preview-ai/bnacincmbaknlbegecpioobkfgejlojp): preview links directly from your current tab and maintain your concentration.
  - [ReaderGPT](https://chromewebstore.google.com/detail/readergpt-chatgpt-based-w/ohgodjgnfedgikkgcjdkomkadbfedcjd): generates summary of any readable web page using ChatGPT with just a single click.
  - [WebChatGPT: ChatGPT with internet access](https://chromewebstore.google.com/detail/webchatgpt-chatgpt-with-i/lpfemeioodjbpieminkklglpmhlngfcn): augment your ChatGPT prompts with relevant web search results through web browsing.
  - [Wikiwand](https://chromewebstore.google.com/detail/wikiwand-wikipedia-and-be/emffkefkbkpkgpdeeooapgaicgmcbolj): ai-driven wiki aggregator created to enhance user experience on Wikipedia by streamlining knowledge consumption.
- **Crypto**
  - [Coinbase Wallet Extension](https://chromewebstore.google.com/detail/coinbase-wallet-extension/hnfanknocfeofbddgcijnmhnfnkdnaad): crypto app in your browser.
- **Development**
  - [DevLinks](https://chromewebstore.google.com/detail/dev-links/eogoekcejgaaaodjgbhnlpmccdmboapb): all links a developer would need.
  - [Fake Filler](https://chromewebstore.google.com/detail/fake-filler/bnjjngeaknajbdcgpfkgnonkmififhfo): a form filler that fills all inputs on a page with fake/dummy data.
  - [Octotree - GitHub code tree](https://chromewebstore.google.com/detail/octotree-github-code-tree/bkhaagjahfmjljalopjnoealnfndnagc): enhances GitHub code review and exploration.
  - [QuickCode](https://chromewebstore.google.com/detail/quickcode-free-online-pro/nnigpbiaggiephcndokoaongeefpbdcj): curates free online programming courses and serves best courses everyday.
  - [Vimium](https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb): provides keyboard shortcuts for navigation and control in the spirit of vim.
  - [Wappalyzer - Technology profiler](https://chromewebstore.google.com/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg): technology profiler that shows you what websites are built with.
- **Google**
  - [Google Docs Offline](https://chromewebstore.google.com/detail/google-docs-offline/ghbmnnjooekpmoecnnnilnnbdlolhkhi)
  - [Google Translate](https://chromewebstore.google.com/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb)
- **Other**
  - [Better Viewer](https://chromewebstore.google.com/detail/betterviewer/llcpfkbjgkpmapiidpnohffjmmnhpmpb): makes image viewing faster, easier, and more fun.
  - [DeepL Translate](https://chromewebstore.google.com/detail/deepl-translate/cofdbpoegempjloogbagkncekinflcnj): translate while you read and write, the world’s most accurate translator.
  - [Lighthouse](https://chromewebstore.google.com/detail/lighthouse/blipmdconlkpinefehnmjammfjpmpbjk): open-source, automated tool for improving the performance, quality, and correctness of your web apps.
  - [Link Redirect Trace](https://chromewebstore.google.com/detail/link-redirect-trace/nnpljppamoaalgkieeciijbcccohlpoh): redirect path analyzer.
  - [The Marvelous Suspender](https://chromewebstore.google.com/detail/the-marvellous-suspender/noogafoofpebimajpfpamcfhoaifemoa): make your computer run smoothly by suspending the tabs you aren't using
  - [uBlacklist](https://chromewebstore.google.com/detail/ublacklist/pncfbmialoiaghdehhbnbhkkgmjanfhe): blocks sites you specify from appearing in Google search results
  - [WhatFont](https://chromewebstore.google.com/detail/whatfont/jabopobgcpjmedljpbcaablpmlmfcogm): identify fonts on web pages.

## Visual Studio Code extensions

Not using anymore:
