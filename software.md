# Software <!-- omit in toc -->

Here is a list of tools that could be interesting and further enhance the stack, as well as tools that I no longer use or which are obsolete.

## Table of Contents <!-- omit in toc -->

- [1. Linux](#1-linux)
- [2. Microsoft Windows](#2-microsoft-windows)
- [3. MacOS](#3-macos)
- [4. Browser extensions](#4-browser-extensions)
- [5. Visual Studio Code extensions](#5-visual-studio-code-extensions)

## 1. Linux

Enhancements:

- **CI/CD**
  - [gh-signoff](https://github.com/basecamp/gh-signoff) [Shell]: local CI, sign off on your own work.
- **Diagrams**
  - [d2](https://github.com/terrastruct/d2) [JavaScript]: modern diagram scripting language that turns text to diagrams.
- **Benchmarking**
  - [hyperfine](https://github.com/sharkdp/hyperfine) [Rust]: benchmarking CLI.
  - [stress-ng](https://github.com/ColinIanKing/stress-ng) [C]: stress test a computer system in various selectable ways.
  - [s-tui](https://github.com/amanusk/s-tui) [Python]: terminal-based CPU stress and monitoring utility.
- **Files**
  - [entr](https://github.com/eradman/entr) [C]: run arbitrary commands when files change.
  - [watchman](https://github.com/facebook/watchman) [C++/Python]: watches files and records, or triggers actions, when they change.
  - [yazi](https://github.com/sxyazi/yazi) [Rust]: terminal file manager based on async I/O.
- **Infrastructure as Code (IaC)**
  - [sst](https://sst.dev): build full-stack apps on your own infrastructure.
  - [terrascan](https://github.com/tenable/terrascan) [Go]: detect compliance and security violations across Infrastructure as Code to mitigate risk before provisioning cloud native infrastructure.
- **Integrated Development Environment (IDE)**
  - [cursor](https://github.com/getcursor/cursor): AI code editor.
  - [windsurf](https://windsurf.com/): AI code editor.
  - [zed](https://github.com/zed-industries/zed): high-performance, multiplayer code editor from the creators of Atom and Tree-sitter.
- **Modern Replacements**
  - [atuin](https://github.com/atuinsh/atuin) [Rust]: history, magical shell history.
  - [dua](https://github.com/Byron/dua-cli) [Rust]: du, view disk space usage and delete unwanted data.
  - [dust](https://github.com/bootandy/dust) [Rust]: du, a more intuitive version.
  - [fd](https://github.com/sharkdp/fd) [Rust]: find, fast and user-friendly alternative.
  - [hwatch](https://github.com/blacknon/hwatch) [Rust]: watch, records the differences in execution results and can check this differences at after.
  - [ripgrep](https://github.com/BurntSushi/ripgrep) [Rust]: grep, recursively searches directories for a regex pattern while respecting your gitignore.
- **Monitoring**
  - [powertop](https://github.com/fenrus75/powertop) [C/C++]: diagnose issues with power consumption and power management.
  - [sampler](https://github.com/sqshq/sampler) [Go]: shell commands execution, visualization and alerting.
- **Multiplexer**
  - [tmux](https://github.com/tmux/tmux)
  - [zellij](https://github.com/zellij-org/zellij)
- **Orchestration**
  - **Docker**
    - [clair](https://github.com/quay/clair) [Go]: vulnerability static analysis for containers.
    - [copacetic](https://github.com/project-copacetic/copacetic) [Go]: CLI tool for directly patching container images.
    - [docker bench](https://github.com/docker/docker-bench-security): script that checks for dozens of common best-practices around deploying Docker containers in production.
    - [skopeo](https://github.com/containers/skopeo) [Go]: work with remote images registries - retrieving information, images, signing content.
    - [subtrace](https://github.com/subtrace/subtrace) [Go]: wireshark for Docker containers.
    - new Docker commands (require an account and/or subscription): init, debug, compose watch, build cloud, scout.
  - **Kubernetes**
    - [khi](https://github.com/GoogleCloudPlatform/khi) [Go]: transformative log viewer for Kubernetes.
    - [kubevpn](https://github.com/kubenetworks/kubevpn) [Go]: cloud native dev environment that connects to Kubernetes cluster network.
    - [skaffold](https://github.com/GoogleContainerTools/skaffold) [Go]: easy and repeatable Kubernetes development.
- **Search**
  - [ag](https://github.com/ggreer/the_silver_searcher) [C/C++]: code-searching tool similar to ack, but faster.
- **Secrets**
  - [envilder](https://github.com/macalbert/envilder) [TypeScript]: securely centralizes environment variables from AWS SSM.
  - [teller](https://github.com/tellerops/teller) [Rust]: cloud native secrets management for developers - never leave your command line for secrets.
- **Security**
  - [google osv](https://github.com/google/osv.dev): Open source vulnerability DB and triage service.
- **Shell**
  - [brush](https://github.com/reubeno/brush) [Rust]: bash/POSIX-compatible shell.
- **Software Development**
  - [autocomplete](https://github.com/withfig/autocomplete) [TypeScript]: IDE-style autocomplete for your existing terminal & shell.
  - [cheat](https://github.com/cheat/cheat) [Go]: create and view interactive cheatsheets on the command-line.
  - [devbox](https://github.com/jetify-com/devbox) [Go]: instant, easy, and predictable development environments.
  - [epic-stack](https://github.com/epicweb-dev/epic-stack) [TypeScript]: full stack app starter with the foundational things setup and configured for you.
  - [mailpit](https://github.com/axllent/mailpit) [Go]: email and SMTP testing tool with API for developers.
- **System Info**
  - [fastfetch](https://github.com/fastfetch-cli/fastfetch) [C]: feature-rich and performance oriented, neofetch like system information tool.
  - [glances](https://github.com/nicolargo/glances) [Python]: glances an eye on your system.
  - [nerdfetch](https://github.com/ThatOneCalculator/NerdFetch) [Shell]: POSIX *nix fetch script using Nerdfonts.
  - [macchina](https://github.com/Macchina-CLI/macchina) [Rust]: system information frontend with an emphasis on performance.
- **Text Editors**
  - [lazy nvim](https://github.com/folke/lazy.nvim) [Lua]: modern plugin manager for Neovim.
  - [qsv](https://github.com/dathere/qsv) [Rust]: blazing-fast data-wrangling toolkit.
  - [xan](https://github.com/medialab/xan) [Rust]: csv magician.
- **Tools**
  - [Clipboard](https://github.com/Slackadays/Clipboard): smart clipboard manager.
  - [cmatrix](https://github.com/abishekvashok/cmatrix) [C]: terminal based "The Matrix" like implementation.
  - [espanso](https://github.com/espanso/espanso) [Rust]: cross-platform text expander.
  - [glow](https://github.com/charmbracelet/glow) [Go]: render markdown on the terminal.
  - [midnight commander](https://github.com/MidnightCommander/mc)
  - [mosh](https://github.com/mobile-shell/mosh) [C++]: mobile shell.
  - [pmd](https://github.com/pmd/pmd) [Java]: extensible multi-language static code analyzer.
  - [simdjson](https://github.com/simdjson/simdjson) [C++]: parsing gigabytes of JSON per second.
  - [thefuck](https://github.com/nvbn/thefuck) [Python]: magnificent app which corrects your previous console command.
- **Version Control**
  - [better commits](https://github.com/Everduin94/better-commits) [JavaScript]: CLI for creating better commits following the conventional commits specification.
  - [cocommit](https://github.com/andrewromanenco/cocommit) [Python]: CLI that works with your HEAD commit and leverages an LLM of your choice to enhance commit quality.
  - [commitlint](https://github.com/conventional-changelog/commitlint) [TypeScript]: lint commit messages.
  - [delta](https://github.com/dandavison/delta) [Rust]: syntax-highlighting pager for git, diff, grep, and blame output.
  - [difftastic](https://difftastic.wilfred.me.uk)
  - [gh-dash](https://github.com/dlvhdr/gh-dash) [Go]: beautiful CLI dashboard for GitHub.
  - [gitbutler](https://github.com/gitbutlerapp/gitbutler) [Rust]: GitButler version control client.
  - [gitu](https://github.com/altsem/gitu) [Rust]: TUI git client inspired by Magit.
  - [git-appraise](https://github.com/google/git-appraise) [Go]: distributed code review system for git repos.
  - [git-bug](https://github.com/git-bug/git-bug) [Go]: distributed, offline-first bug tracker embedded in git, with bridges.
  - [git-plan](https://github.com/rorybyrne/git-plan) [Python]: a better workflow for git.
  - [git-sim](https://github.com/initialcommit-com/git-sim) [Python]: visually simulate Git operations in your own repos with a single terminal command.
  - [git-xargs](https://github.com/gruntwork-io/git-xargs) [Go]: CLI for making updates across multiple Github repositories with a single command.
  - [gitflow](https://github.com/nvie/gitflow) [Shell]: git extensions to provide high-level repository operations for Vincent Driessen's branching model.
  - [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli) [JavaScript]: gitmoji interactive CLI tool for using emojis on commits.
  - [husky](https://github.com/typicode/husky) [JavaScript]: git hooks made easy.
  - [mergiraf](https://mergiraf.org)
  - [multi-gitter](https://github.com/lindell/multi-gitter) [Go]: update multiple repositories in with one command.
  - [opencommit](https://github.com/di-sukharev/opencommit) [JavaScript]: generate commit messages by an LLM in 1 sec.
- **Web**
  - [hey](https://github.com/rakyll/hey) [Go]: HTTP load generator, apachebench (ab) replacement.
  - [monolith](https://github.com/Y2Z/monolith) [Rust]: CLI tool and library for saving complete web pages as a single HTML file.
  - [oha](https://github.com/hatoo/oha) [Rust]: HTTP load generator, with tui animation.
- **zsh**
  - [zsh-auto-notify](https://github.com/MichaelAquilina/zsh-auto-notify)

Not using anymore:

- **Cloud**
  - [Cloudlens](https://github.com/one2nc/cloudlens) [Go]: k9s like CLI for AWS and GCP. **Reason**: missing a lot of features, no longer maintained.
  - [dog](https://github.com/ogham/dog) [Rust]: dig, with colorful output, DNS-over-TLS and DNS-over-HTTPS protocols support, JSON output, and more. **Reason**: no longer maintained.

## 2. Microsoft Windows

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
  - **Package Management**
    - [UniGetUI](https://github.com/marticliment/UniGetUI): unified graphical interface for package managers.
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
  - [Intel Unison](https://apps.microsoft.com/detail/9pp9gzm2gn26): seamlessly connects your PC and mobile devices. **Reason**: being deprecated.
  - [PDF Merger & Splitter](https://www.anywaysoft.com/pdf-merger-splitter/index.html): using pdftk in WSL2 instead.
- Other
  - [Google Chrome Desktop](https://remotedesktop.google.com): using RustDesk instead.

## 3. MacOS

Enhancements:

- [sps](https://github.com/alexykn/sps) [Rust]: package manager.


## 4. Browser extensions

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

## 5. Visual Studio Code extensions

Not using anymore:
