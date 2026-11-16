# Agent Smith

## English

A coding agent that asks a language model to write Python, executes it in an isolated sandbox, and uses the result to decide the next step. It supports short MBPP problems and repository fixes for SWE-bench.

### Layout

| Path | Contents |
| --- | --- |
| `agent_mbpp.py / agent_swebench.py` | Task input and result output |
| `orchestrator.py` | Reasoning and execution loop |
| `sandbox/` | Process isolation and MCP tool connections |
| `llm/` | Providers, retries, and key rotation |
| `tests/` | Tools, isolation, error handling, and shutdown |

### Run and test

Requires Python 3.10, uv, Make, and Linux with unshare and bwrap. Run from the repository root.

```sh
make test
make install
make run
make sandbox
```

`make test` prepares a cached environment and runs 103 tests. Provider and Docker calls use test doubles; sandbox tests execute real isolated worker processes. No API key or running Docker daemon is needed for these tests. Real agent runs need provider credentials; SWE-bench also needs Docker. Configure `.env` locally using `.env.example`. See [BENCHMARK_REPORT.md](BENCHMARK_REPORT.md) for existing model comparisons.

See [the detailed guide](docs/GUIDE.md) for the original setup and implementation notes.

## 日本語

言語モデルにPythonを書かせ、隔離したサンドボックスで実行し、その結果から次の操作を決める開発支援エージェントです。短いMBPP問題と、リポジトリ修正を行うSWE-benchに対応しています。

### 構成

| パス | 内容 |
| --- | --- |
| `agent_mbpp.py / agent_swebench.py` | 課題の読込と結果出力 |
| `orchestrator.py` | 推論と実行を繰り返す処理 |
| `sandbox/` | プロセス隔離とMCPツール接続 |
| `llm/` | プロバイダ・再試行・APIキー切替 |
| `tests/` | ツール・隔離・エラー処理・終了処理の検証 |

### 実行とテスト

Python 3.10・uv・Makeと、unshare・bwrapを利用できるLinux環境が必要です。 リポジトリ直下で実行します。

```sh
make test
make install
make run
make sandbox
```

`make test` はキャッシュ上に環境を用意して103テストを実行します。API呼出しとDocker操作には代替実装を使い、サンドボックスは実際の隔離ワーカープロセスで検証します。このテストにAPIキーや起動中のDockerは不要です。実際のエージェント実行には認証情報、SWE-benchにはDockerも必要です。`.env.example`を基にローカルで設定します。既存のモデル比較は[BENCHMARK_REPORT.md](BENCHMARK_REPORT.md)にあります。

元の構築手順と設計の説明は[詳細ガイド](docs/GUIDE.md)にまとめています。
