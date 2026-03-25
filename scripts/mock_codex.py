#!/usr/bin/env python3
import sys
import json
import re
import os

def main():
    if len(sys.argv) < 2:
        sys.exit(1)
    
    # 1. Resolve prompt from different CLI signatures
    prompt = ""
    # Go worker style: llm generate --prompt "..."
    if sys.argv[1] == "llm" and len(sys.argv) > 2 and sys.argv[2] == "generate":
        for i in range(len(sys.argv)):
            if sys.argv[i] == "--prompt":
                prompt = sys.argv[i+1]
                break
    # Python Librarian style: "..." --model "..."
    elif not sys.argv[1].startswith("-"):
        prompt = sys.argv[1]
    
    if not prompt:
        return

    # 2. Process based on prompt content
    resp = None
    
    # Node Role Classification Detection (High Priority)
    if "Classify the following code symbol into one or more architectural roles" in prompt or "architectural roles" in prompt.lower():
        name_m = re.search(r"- Name: ([^\n]+)", prompt)
        name = name_m.group(1) if name_m else "unknown"
        roles = ["security_gate", "validation_gate", "entry_point", "orchestrator", "data_boundary", "external_client", "utility"]
        role_idx = len(name) % len(roles)
        resp = [{
            "role_label": roles[role_idx],
            "confidence": 0.95,
            "rationale": f"The symbol {name} serves as a structural hub. It performs coordination and logic management."
        }]

    # Intended Truth Discovery Detection
    elif "Classify the intent of the file" in prompt:
        resp = [
            {"label": "api_contract", "confidence": 0.9},
            {"label": "implementation", "confidence": 0.8}
        ]

    # Scenario Enrichment Detection
    elif "Architectural path detected:" in prompt or "expert software architect analysing a codebase knowledge graph" in prompt:
        path_m = re.search(r"Path label: ([^\n]+)", prompt)
        label = path_m.group(1) if path_m else "unknown path"
        resp = {
            "summary": f"This architectural path represents a critical flow through {label}.",
            "implied_contract": "Valid interface adherence required.",
            "risk_flags": ["tight_coupling"] if "handler" in prompt.lower() else []
        }

    # Neural Seeding Detection
    elif "symbol_name" in prompt:
        symbols = re.findall(r'"symbol_name":"([^"]+)"', prompt)
        if not symbols:
            symbols = re.findall(r'"symbol_name": "([^"]+)"', prompt)
        
        if len(symbols) >= 2:
            resp = {
                "predicate": "DEPENDS_ON",
                "confidence": 0.85,
                "rationale": f"Relationship between {symbols[0]} and {symbols[1]} detected. Based on structural signals.",
                "reject": False
            }
        else:
            resp = {"predicate": "DEPENDS_ON", "confidence": 0.5, "reject": True}

    if resp:
        print(json.dumps(resp))

if __name__ == "__main__":
    main()
