#!/usr/bin/env python3
"""Compile Markdown question source to PDF (answers on last page).

Usage: python3 build-pdf.py <source.md>
Output: <source>.pdf (same path, .pdf suffix)

Math: Unicode-only (no LaTeX). Answer blank: <div class="answer-space"></div>.
Answer section page break: <div class="page-break"></div> before the answers heading.
"""
import sys
import pathlib
import re

import markdown
import weasyprint


TEMPLATE_NAME = "question-pdf.html"


def render(src: pathlib.Path) -> pathlib.Path:
    md_text = src.read_text(encoding="utf-8")
    # strip YAML frontmatter (--- ... ---)
    md_text = re.sub(r"\A---\n.*?\n---\n", "", md_text, flags=re.DOTALL)
    html_body = markdown.markdown(
        md_text,
        extensions=["tables", "fenced_code", "sane_lists"],
    )
    template = pathlib.Path(__file__).resolve().parent.parent / "templates" / TEMPLATE_NAME
    html = template.read_text(encoding="utf-8").replace("__CONTENT__", html_body)
    out = src.with_suffix(".pdf")
    weasyprint.HTML(string=html, base_url=str(template.parent)).write_pdf(str(out))
    return out


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: build-pdf.py <source.md>", file=sys.stderr)
        return 2
    src = pathlib.Path(sys.argv[1])
    if not src.exists():
        print(f"ERROR: source not found: {src}", file=sys.stderr)
        return 2
    out = render(src)
    print(f"Built: {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
