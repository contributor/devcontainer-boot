docs-all:
    @just docs-gemini
    @just docs-github
    @just docs-kiro

docs-gemini:
    @just _copy-all ".gemini"

docs-github:
    @just _copy-all ".github/instructions"

docs-kiro:
    @just _copy-all ".kiro/steering"

_copy-docs DIR:
    @mkdir -p {{DIR}}
    cp -rv ~/ai-docs/.gen/{{DIR}}/. {{DIR}}/

_copy-all DIR-DOCS:
    @just _copy-docs {{DIR-DOCS}}

