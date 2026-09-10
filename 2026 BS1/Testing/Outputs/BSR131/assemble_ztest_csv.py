#!/usr/bin/env python3
"""Assemble zTest_variable_comments.csv from part files.

Prefers gzip+base64 parts (zTest_variable_comments.part*.b64) if present;
otherwise concatenates plain CSV row chunks (zTest_variable_comments.part*.csv)
where only part00 includes the header row.
"""
import base64, gzip, pathlib
d = pathlib.Path(__file__).resolve().parent
out = d / "zTest_variable_comments.csv"
b64 = sorted(d.glob("zTest_variable_comments.part*.b64"))
csvp = sorted(d.glob("zTest_variable_comments.part*.csv"))
if b64:
    raw = "".join(p.read_text().strip() for p in b64)
    out.write_bytes(gzip.decompress(base64.b64decode(raw)))
    print("wrote zTest", out.stat().st_size, "from", len(b64), "b64 parts")
elif csvp:
    with out.open("wb") as w:
        for p in csvp:
            w.write(p.read_bytes())
    print("wrote zTest", out.stat().st_size, "from", len(csvp), "csv parts")
else:
    raise SystemExit("no zTest_variable_comments.part*.b64 or .csv found")
