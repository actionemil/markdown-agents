# Implementation Strategy: Manifest-Phased Build + Model Plan

Status: Working plan aligned to `ai/manifest.md` sections `1..29`.

## Model Usage Policy

- `Codex` + `High` reasoning: security-critical logic, deterministic contracts, transaction/snapshot semantics, and test assertions.
- `Gemini Pro` + `Medium` reasoning: implementation planning, scaffolding, docs, integration wiring, and broad test-case generation.
- `Gemini Pro` + `Low` reasoning: repetitive boilerplate, metadata text, and non-critical refactors.

Use both models in each phase:
- Primary model writes core code.
- Secondary model performs adversarial review and gap checks before merge.

## Phase 1: Bootstrap, Trust, and Boundary Lock (MVP Gate)

- Manifest scope: `1, 2, 3, 9, 17`
- Primary model: `Codex` (`High`)
- Secondary model: `Gemini Pro` (`Medium`)
- Goal: secure startup and deterministic workspace anchoring.
- Deliverables:
  1. `cortex init` + immutable `workspace_root` lock.
  2. path boundary validator (`realpath`, traversal/symlink escape rejection).
  3. secure subprocess adapter (`shell=False`, allowlist, absolute paths, output caps).
  4. trust signing and verification (`salt` + HMAC signature, fail-closed startup).
- Exit criteria:
  1. pass tests for init fail-fast, subprocess security, path security, trust failure lockdown.

## Phase 2: Structural Graph Core and JIT Ingestion

- Manifest scope: `4, 5, 6, 7, 8`
- Primary model: `Codex` (`High`)
- Secondary model: `Gemini Pro` (`Medium`)
- Goal: deterministic structural indexing and safe query surface.
- Deliverables:
  1. state registry + scan filters (`.gitignore`, file caps, binary/vendor skips).
  2. atomic JIT ingestion (single transaction, version pointer switch, rollback).
  3. canonical schema + predicate quarantine + confidence thresholds.
  4. MCP server baseline with bounded query limits and governance tools.
- Exit criteria:
  1. pass core ingestion, rollback/idempotency, pagination, and governance tests.

## Phase 3: Reliability, Scheduler, and Runtime Safety

- Manifest scope: `10, 14, 15, 19, 20`
- Primary model: `Codex` (`High`)
- Secondary model: `Gemini Pro` (`Medium`)
- Goal: predictable behavior under load and failure.
- Deliverables:
  1. P0/P1/P2 scheduler with coalescing, debounce, and single-writer guarantee.
  2. snapshot isolation + versioned slice GC + crash recovery/replay.
  3. degraded-mode responses with deterministic metadata.
  4. runtime memory/CPU policies, log rotation, and OOM-safe restart handling.
- Exit criteria:
  1. pass scheduler/backpressure, recovery, runtime-budget, and snapshot consistency tests.

## Phase 4: Analysis Tools, UX Routing, and Inference Transparency

- Manifest scope: `11, 12, 13, 16`
- Primary model: `Codex` (`High`)
- Secondary model: `Gemini Pro` (`Medium`)
- Goal: production-safe analysis tools with deterministic contracts.
- Deliverables:
  1. `get_impact_radius`, `find_by_intent`, `get_logic_flow`, `get_branch_diff_context`.
  2. common response schema, bounded traversal/timeout behavior, streaming metadata.
  3. NL routing metadata, disambiguation, and missing-context handling.
  4. inferred-edge storage separation with explicit `include_inferred` semantics.
- Exit criteria:
  1. pass tool-contract, UX-routing, inference labeling, and bounds tests.

## Phase 5: Provider and Config Lifecycle (V4)

- Manifest scope: `21, 22, 23, 24`
- Primary model: `Gemini Pro` (`Medium`)
- Secondary model: `Codex` (`High`)
- Goal: provider-agnostic setup with trusted config lifecycle.
- Deliverables:
  1. adapter-driven provider init (`cli`, `ollama`, optional `openai_compat`).
  2. MCP registration/install flow with backup + merge and connectivity checks.
  3. `config_manager` atomic update/validate/sign/swap and policy introspection commands.
  4. endpoint safety defaults (`localhost` default, remote opt-in only).
- Exit criteria:
  1. pass provider-init, config lifecycle, endpoint safety, and policy-bound tests.

## Phase 6: Backends, Vector Optionality, and Benchmark Gates

- Manifest scope: `25, 26, 27, 28, 29`
- Primary model: `Codex` (`High`)
- Secondary model: `Gemini Pro` (`Medium`)
- Goal: extensibility without breaking deterministic/safe defaults.
- Deliverables:
  1. backend abstraction contract + migration metadata.
  2. optional vector contract with graph-primary safety.
  3. benchmark gate (`cortex bench`) for any default-change proposal.
  4. merged v6 clarifications (vector missing fallback, snapshot token integrity, score normalization, summary snapshot consistency).
- Exit criteria:
  1. pass backend parity/safety tests and v6 contract tests `132..139`.

## Phase 7: Acceptance Harness and Release Readiness

- Manifest scope: acceptance matrix (`1..139`) + phased gate policy.
- Primary model: `Codex` (`High`)
- Secondary model: `Gemini Pro` (`Medium`)
- Goal: harden release quality with staged gates.
- Deliverables:
  1. establish `Core Gate` (~25-35 blocking tests) mapped to shipped scope.
  2. keep remaining tests as non-blocking planned gates until feature activation.
  3. publish deterministic benchmark artifacts and security regression reports.
- Exit criteria:
  1. zero failures in blocking suite.
  2. known gaps documented with phase ownership and target milestone.

## Optional Phase 8: v7/v8 Enhancements (After Core Stability)

- Scope source: `docs/improvements/v7-ideas.md`.
- Primary model: `Codex` (`High`) for protocol/security contracts.
- Secondary model: `Gemini Pro` (`Medium`) for rollout plans and non-critical scaffolding.
- Candidates:
  1. payload compaction, inferred-edge lifecycle GC, power-throttling.
  2. native ingest sidecar (runtime worker + orchestrator) behind parity + benchmark gates.

## Practical Prompting Guidance Per Phase

1. Start phase planning with `Gemini Pro` (`Medium`) to produce task/checklist breakdown.
2. Implement core logic with `Codex` (`High`) in small, testable increments.
3. Run adversarial review with `Gemini Pro` (`Medium`), then patch with `Codex` (`High`).
4. Use `Gemini Pro` (`Low`) only for repetitive docs/metadata updates after tests pass.
