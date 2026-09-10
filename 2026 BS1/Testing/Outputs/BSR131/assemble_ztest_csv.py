#!/usr/bin/env python3
import base64, gzip, pathlib
d = pathlib.Path(__file__).resolve().parent
parts = sorted(d.glob("zTest_variable_comments.part*.b64"))
raw = "".join(p.read_text().strip() for p in parts)
(d/"zTest_variable_comments.csv").write_bytes(gzip.decompress(base64.b64decode(raw)))
print("wrote zTest", (d/"zTest_variable_comments.csv").stat().st_size)
