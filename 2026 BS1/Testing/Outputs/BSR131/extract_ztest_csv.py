#!/usr/bin/env python3
"""Self-extract BSR131 zTest_variable_comments.csv (embedded gzip+base64)."""
import base64, gzip, pathlib
TARGET = pathlib.Path(__file__).resolve().parent / "zTest_variable_comments.csv"
DATA = open('/tmp/csv.gz.b64').read() if False else ''
# placeholder - real content via next call
print('run from workspace copy')
