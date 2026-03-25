# Artificial Intelligence <!-- omit in toc -->

Here is a list of libraries and frameworks that could be interesting to use in the context of artificial intelligence development.

## Table of Contents <!-- omit in toc -->

- [Glossary](#glossary)
- [List](#list)
  - [Agents](#agents)
  - [App Builder](#app-builder)
  - [Claude Code](#claude-code)
  - [Diffusion](#diffusion)
  - [Infrastructure](#infrastructure)
  - [LLM](#llm)
  - [MCP](#mcp)
  - [OpenClaw](#openclaw)
  - [Prompt](#prompt)
  - [RAG](#rag)
  - [Skills](#skills)
  - [Speech-to-Text](#speech-to-text)
  - [Text-to-Image](#text-to-image)
  - [Text-to-Speech](#text-to-speech)
  - [Use Cases](#use-cases)

## Glossary

- *LLM*: Large Language Model.
- *MCP*: Model Context Protocol.
- *RAG*: Retrieval-Augmented Generation.

## List

### Agents

- [1code](https://github.com/21st-dev/1code) - orchestration layer for coding agents. `TypeScript`
- [agents.md](https://github.com/agentsmd/agents.md) - simple, open format for guiding coding agents. `TypeScript`
- [beads](https://github.com/steveyegge/beads) - memory upgrade for your coding agent. `Go`
- [browser-agent](https://github.com/magnitudedev/browser-agent) - vision-first browser agent. `TypeScript` `JavaScript`
- [crewai](https://github.com/crewAIInc/crewAI) - framework for orchestrating role-playing, autonomous AI agents. `Python`
- [coder](https://github.com/coder/coder) - secure environments for developers and their agents. `Go` `TypeScript`
- [cua](https://github.com/trycua/cua) - infrastructure for computer-use agents. Sandboxes, SDKs, and benchmarks to train and evaluate AI agents that can control full desktops. `Python` `TypeScript`
- [dify](https://github.com/langgenius/dify) - production-ready platform for agentic workflow development. `TypeScript` `Python`
- [entire-cli](https://github.com/entireio/cli) - hooks into your git workflow to capture AI agent sessions on every push, unifying your code with its context and reasoning. `Go`
- [kimi-cli](https://github.com/MoonshotAI/kimi-cli) - CLI agent. `Python` `TypeScript`
- [lobehub](https://github.com/lobehub/lobehub) - space for work and life — to find, build, and collaborate with agent teammates that grow with you. `TypeScript`
- [mini-agi](https://github.com/muellerberndt/mini-agi) - simple general-purpose AI agent based on the OpenAI API. `Python`
- [opencode](https://github.com/anomalyco/opencode) - open source coding agent. `TypeScript`
- [ralph](https://github.com/snarktank/ralph) - autonomous AI agent loop that runs repeatedly until all PRD items are complete. `TypeScript` `Shell`
- [repoaudit](https://github.com/PurCL/RepoAudit) - autonomous LLM-agent for large-scale, repository-level code auditing. `Python`
- [sim](https://github.com/simstudioai/sim) - build, deploy, and orchestrate AI agents, this is the central intelligence layer for your AI workforce. `TypeScript`
- [vibe-kanban](https://github.com/BloopAI/vibe-kanban) - use kanban issues to plan work, and when you're ready create workspaces where coding agents can execute. `Rust` `TypeScript`
- [web-ui](https://github.com/browser-use/web-ui) - AI agent in your browser. `Python`

### App Builder

- [gradio](https://github.com/gradio-app/gradio) - build and share delightful machine learning apps. `Python` `Svelte` `TypeScript`

### Claude Code

- [claude-code](https://github.com/anthropics/claude-code) - agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster by executing routine tasks, explaining complex code, and handling git workflows - all through natural language commands. `Shell` `Python` `TypeScript`
- [claude-mem](https://github.com/thedotmack/claude-mem) - plugin that automatically captures everything Claude does during your coding sessions, compresses it with AI (using Claude's agent-sdk), and injects relevant context back into future sessions. `TypeScript`
- [opcode](https://github.com/winfunc/opcode) - GUI app and toolkit for Claude Code, create custom agents, manage interactive Claude Code sessions, run secure background agents, and more. `TypeScript` `Rust`

### Diffusion

- [comfyui](https://github.com/Comfy-Org/ComfyUI) - powerful and modular diffusion model GUI, api and backend with a graph/nodes interface. `Python`
- [flux](https://github.com/black-forest-labs/flux) - official inference repo for FLUX.1 models. `Python`
- [stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) - stable diffusion web UI. `Python` `JavaScript`
- [stable-diffusion-webui-docker](https://github.com/AbdBarho/stable-diffusion-webui-docker) - docker setup for stable diffusion with user-friendly UI. `Shell`

### Infrastructure

- [exo](https://github.com/exo-explore/exo) - connects all your devices into an AI cluster. Not only does exo enable running models larger than would fit on a single device, but makes models run faster as you add more devices. `Python` `Svelte`

### LLM

- [anything-llm](https://github.com/Mintplex-Labs/anything-llm) - all-in-one desktop & docker AI application with built-in RAG, AI agents, no-code agent builder, MCP compatibility, and more. `JavaScript`
- [localai](https://github.com/mudler/LocalAI) - free & open source alternative to OpenAI, Claude and others. Drop-in replacement for OpenAI, running on consumer-grade hardware. No GPU required. Runs gguf, transformers, diffusers and many more. `Go`
- [onyx](https://github.com/onyx-dot-app/onyx) - open source AI platform, AI chat with advanced features that works with every LLM. `Python`
- [pathway](https://github.com/pathwaycom/pathway) - ETL framework for stream processing, real-time analytics, LLM pipelines, and RAG. `Python`
- [recall](https://github.com/joseairosa/recall) - redis-powered persistent memory for LLMs. `TypeScript` `JavaScript`

### MCP

- [codemcp](https://github.com/ezyang/codemcp) - coding assistant MCP for Claude desktop. `Python`
- [gitmcp](https://github.com/idosal/git-mcp) - free, open-source, remote MCP server for any GitHub project. `TypeScript`
- [mcp](https://github.com/BrowserMCP/mcp) -  MCP server that allows AI applications to control your browser. `TypeScript`

### OpenClaw

- [aionui](https://github.com/iOfficeAI/AionUi) - local,open-source cowork app, and OpenClaw for Gemini CLI, Claude Code, Codex, OpenCode, Qwen Code, Goose CLI, Auggie, and more. `TypeScript` `Python`
- [moltworker](https://github.com/cloudflare/moltworker) - run openclaw on Cloudflare Workers. `TypeScript` `Shell`
- [nemoclaw](https://github.com/NVIDIA/NemoClaw) - NVIDIA plugin for secure installation of OpenClaw. `JavaScript` `TypeScript` `Shell`
- [openclaw](https://github.com/openclaw/openclaw) - your own personal AI assistant, any OS, any platform. `TypeScript`

### Prompt

- [system-prompts-and-models-of-ai-tools](https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools) - system prompts, internal tools & AI models.
- [system_prompts_leaks](https://github.com/asgeirtj/system_prompts_leaks) - collection of extracted system prompts from popular chatbots like ChatGPT, Claude & Gemini.

### RAG

- [DeepSeek-RAG-Chatbot](https://github.com/SaiAkhil066/DeepSeek-RAG-Chatbot) - private deepSeek’s advanced RAG: boost Your RAG chatbot: hybrid retrieval (BM25 + FAISS) + neural reranking + hyde. `Python`
- [PageIndex](https://github.com/VectifyAI/PageIndex) - document index for vectorless, reasoning-based RAG. `Python`

### Skills

- [skills](https://github.com/anthropics/skills) - public repository for agent skills. `Python`
- [skills](https://github.com/huggingface/skills) - give your agents the power of the Hugging Face ecosystem. `Python`
- [superpowers](https://github.com/obra/superpowers) - agentic skills framework & software development methodology that works. `Shell` `JavaScript`

### Speech-to-Text

- [handy](https://github.com/cjpais/Handy) - extensible speech-to-text application that works completely offline. `Rust` `TypeScript`

### Text-to-Image

- [fooocus](https://github.com/lllyasviel/Fooocus) - focus on prompting and generating. `Python`

### Text-to-Speech

- [TTS](https://github.com/coqui-ai/TTS) - deep learning toolkit for Text-to-Speech, battle-tested in research and production. `Python`

### Use Cases

- [RedditVideoMakerBot](https://github.com/elebumm/RedditVideoMakerBot) - create Reddit videos with just one command.
- [worldmonitor](https://github.com/koala73/worldmonitor) - real-time global intelligence dashboard, AI-powered news aggregation, geopolitical monitoring, and infrastructure tracking in a unified situational awareness interface. `TypeScript` `JavaScript`
