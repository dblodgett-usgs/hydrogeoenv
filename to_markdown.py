#!/usr/bin/env python3

from pytablewriter import MarkdownTableWriter
import subprocess


exit_code = subprocess.call("./get_versions.sh")

with open("docs/r_packages.txt", "r") as f:
    r_pkg = [l.strip().split() for l in f.readlines()]

writer = MarkdownTableWriter()
writer.table_name = "Available R Packages"
writer.headers = ["Package", "Version"]
writer.value_matrix = r_pkg

writer.dump("docs/r_table.md")

with open("docs/python_packages.txt", "r") as f:
    py_pkg = [l.strip().split("==") for l in f.readlines()]

writer = MarkdownTableWriter()
writer.table_name = "Available Python Packages"
writer.headers = ["Package", "Version"]
writer.value_matrix = py_pkg

writer.dump("docs/python_table.md")
