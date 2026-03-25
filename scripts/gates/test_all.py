#!/usr/bin/env python3
"""
Master test runner for the Cortex project.
Coordinates Python tests (pytest) and Go tests (go test).
Exit Codes: 0 = Pass, 1 = Tests Failed, 2 = Script Error
"""
import subprocess
import sys
import os
from pathlib import Path

def load_env(root):
    manifest = root / "ai" / "manifest.md"
    env_file = root / ".cortex" / "env"
    if not manifest.exists():
        raise RuntimeError("ai/manifest.md missing")
    if not env_file.exists():
        raise RuntimeError(".cortex/env missing. Run 'make doctor' first.")
    if manifest.stat().st_mtime > env_file.stat().st_mtime:
        raise RuntimeError(".cortex/env is stale relative to ai/manifest.md. Run 'make doctor'.")
    env_vars = {}
    for line in env_file.read_text().splitlines():
        if "=" in line and not line.startswith("#"):
            k, v = line.split("=", 1)
            env_vars[k.strip()] = v.strip()
    return env_vars

def run_command(command, cwd=None, name=""):
    print(f"\n>>> Running {name} tests...")
    print(f"Command: {' '.join(command)}")
    try:
        result = subprocess.run(
            command,
            cwd=cwd,
            check=True,
            text=True
        )
        print(f"OK: {name} tests passed.")
        return True
    except subprocess.CalledProcessError as e:
        print(f"ERROR: {name} tests failed with exit code {e.returncode}.", file=sys.stderr)
        return False
    except FileNotFoundError:
        print(f"ERROR: Command '{command[0]}' not found. Is it installed?", file=sys.stderr)
        return False

def main():
    try:
        # Resolve the project root (assuming this script is in project-root/scripts/gates/)
        script_path = Path(__file__).resolve()
        project_root = script_path.parent.parent.parent
        
        env_vars = load_env(project_root)
        py_bin = env_vars.get("PYTHON_BIN", "python3")
        go_bin = env_vars.get("GO_BIN", "go")
        
        python_test_dir = project_root / "tests"
        go_test_dir = project_root / "native-worker"
        
        # Check for specific targets (incremental mode)
        targets = sys.argv[1:]
        is_incremental = len(targets) > 0
        
        success = True
        
        # 1. Run Python Tests
        if python_test_dir.exists():
            py_cmd = [py_bin, "-m", "pytest"]
            if is_incremental:
                py_cmd.append("tests/") 
            else:
                py_cmd.append("tests/")
                
            py_success = run_command(
                py_cmd,
                cwd=project_root,
                name="Python"
            )
            if not py_success:
                success = False
        else:
            print(f"Warning: Python test directory not found at {python_test_dir}")

        # 2. Run Go Tests (Recursive or Targeted)
        if go_test_dir.exists():
            if is_incremental:
                # Map file paths to packages
                packages = set()
                for t in targets:
                    path = Path(t).resolve()
                    if str(go_test_dir) in str(path):
                        rel = path.relative_to(go_test_dir)
                        packages.add(f"./{rel.parent}...")
                
                if packages:
                    for pkg in packages:
                        go_success = run_command(
                            [go_bin, "test", pkg],
                            cwd=go_test_dir,
                            name=f"Go (Incremental: {pkg})"
                        )
                        if not go_success: success = False
                else:
                    print("No relevant Go tests found for changed files.")
            else:
                go_success = run_command(
                    [go_bin, "test", "./..."],
                    cwd=go_test_dir,
                    name="Go (Recursive)"
                )
                if not go_success: success = False

        if success:
            print("\n✅ ALL TESTS PASSED")
            sys.exit(0)
        else:
            print("\n❌ SOME TESTS FAILED")
            sys.exit(1)
            
    except Exception as e:
        print(f"\n🛑 SCRIPT ERROR in test_all.py: {e}", file=sys.stderr)
        sys.exit(2)

if __name__ == "__main__":
    main()
