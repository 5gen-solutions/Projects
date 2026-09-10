#!/usr/bin/env python3
"""Assemble zTest_variable_comments.csv from gzip+base64 part*.b64 files."""
import base64, gzip, pathlib
d = pathlib.Path(__file__).resolve().parent
parts = sorted(d.glob("zTest_variable_comments.part*.b64"))
if not parts:
    raise SystemExit("no zTest_variable_comments.part*.b64 found")
raw = "".join(p.read_text().strip() for p in parts)
out = d / "zTest_variable_comments.csv"
out.write_bytes(gzip.decompress(base64.b64decode(raw)))
print("wrote zTest", out.stat().st_size, "from", len(parts), "b64 parts")
