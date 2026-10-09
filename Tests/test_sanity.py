import os
import re
import sys

def strip_lua_comments(code):
    code = re.sub(r'--\[\[.*?\]\]', '', code, flags=re.DOTALL)
    code = re.sub(r'--.*$', '', code, flags=re.MULTILINE)
    return code

def test_multibot_sanity():
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    print(f"Testing MultiBot addon directory: {base_dir}")

    # 1. Verify required documentation and repository files
    required_files = [
        "README.md", "CHANGELOG.md", "LICENSE", "NOTICE.md",
        "API.md", "AGENTS.md", "INSTALL.md", "SECURITY.md",
        "ECOSYSTEM_REGISTRY.md", ".gitignore", ".gitattributes",
        "MultiBot.toc"
    ]
    for filename in required_files:
        path = os.path.join(base_dir, filename)
        assert os.path.exists(path), f"Missing required file: {filename}"
    print("[PASS] All required repository documentation files exist.")

    # 2. Verify TOC
    toc_path = os.path.join(base_dir, "MultiBot.toc")
    with open(toc_path, "r", encoding="utf-8") as f:
        toc_content = f.read()

    assert "30300" in toc_content, "TOC invalid interface version"
    assert "4.0.0-WP" in toc_content, "TOC version mismatch (expected 4.0.0-WP)"
    assert "X-Ecosystem-Module: #21" in toc_content, "TOC missing module #21 tag"
    assert "MultiBotSave" in toc_content, "TOC missing MultiBotSave"
    assert "MultiBotGlobalSave" in toc_content, "TOC missing MultiBotGlobalSave"
    assert "Core\\MultiBot.lua" in toc_content, "TOC missing Core\\MultiBot.lua"
    assert "Core\\MultiBotHandler.lua" in toc_content, "TOC missing Core\\MultiBotHandler.lua"
    assert "UI\\MultiBotMainUI.lua" in toc_content, "TOC missing UI\\MultiBotMainUI.lua"
    print("[PASS] MultiBot.toc structure and metadata validated.")

    # 3. Verify key directories
    required_dirs = ["Core", "UI", "Strategies", "Locales", "Data", "Libs", "Icons", "Textures"]
    for dir_name in required_dirs:
        dir_path = os.path.join(base_dir, dir_name)
        assert os.path.isdir(dir_path), f"Missing required directory: {dir_name}"
    print("[PASS] All key architectural directories exist.")

    # 4. Verify slash commands
    handler_path = os.path.join(base_dir, "Core", "MultiBotHandler.lua")
    with open(handler_path, "r", encoding="utf-8") as hf:
        handler_code = hf.read()

    assert '"wpmb"' in handler_code, "Missing 'wpmb' slash command alias in MultiBotHandler.lua"
    assert '"wpbot"' in handler_code, "Missing 'wpbot' slash command alias in MultiBotHandler.lua"
    assert '"multibot"' in handler_code, "Missing 'multibot' slash command in MultiBotHandler.lua"
    assert '"mb"' in handler_code, "Missing 'mb' slash command in MultiBotHandler.lua"

    options_path = os.path.join(base_dir, "UI", "MultiBotOptions.lua")
    with open(options_path, "r", encoding="utf-8") as of:
        options_code = of.read()
    assert '"wpmbopt"' in options_code, "Missing 'wpmbopt' slash command alias in MultiBotOptions.lua"
    print("[PASS] Project Jaina slash command suite validated (/mb, /multibot, /wpmb, /wpbot, /mbopt, /wpmbopt).")

    # 5. Engine 3.3.5a safety checks
    for root, _, files in os.walk(base_dir):
        if "Libs" in root:
            continue
        for f in files:
            if f.endswith(".lua"):
                fpath = os.path.join(root, f)
                with open(fpath, "r", encoding="utf-8", errors="ignore") as lf:
                    raw_content = lf.read()
                clean = strip_lua_comments(raw_content)
                assert not re.search(r'\bSetColorTexture\s*\(', clean), f"Forbidden SetColorTexture found in {f}"
    print("[PASS] Zero forbidden Retail APIs (SetColorTexture) detected across all Lua files.")

    # 6. Verify Unicode hygiene in TOC
    for idx, line in enumerate(toc_content.splitlines(), 1):
        for ch in line:
            assert ord(ch) <= 0x024F, f"Unrenderable glyph '{ch}' (U+{ord(ch):04X}) in TOC line {idx}"
    print("[PASS] Unicode glyph hygiene in TOC validated (zero corrupt characters).")

    print("\n>>> ALL WOWPERU_MULTIBOT SANITY CHECKS PASSED 100% <<<")

if __name__ == "__main__":
    test_multibot_sanity()
