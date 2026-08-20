# Code style

## Docstrings

Do **not** wrap docstring text to a line-length limit. Write each paragraph as one long line and let the editor soft-wrap it; hard line breaks inside a paragraph make docstrings painful to edit and produce noisy diffs when a sentence changes. Line-length limits apply to code, not to prose.

Place the triple quotes by length: a single-paragraph docstring keeps its quotes on the same line as the text, and anything longer puts each set of quotes on its own line.

```python
def f():
    """One paragraph, quotes on the text's line."""

def g():
    """
    Summary paragraph, with the quotes on their own lines.

    Further paragraphs as needed.
    """
```

## Blank lines

Never leave two or more blank lines in a row. One blank line is the largest gap, everywhere — between top-level definitions, before section-header comments, and inside function bodies.

This departs from PEP 8, which asks for two blank lines between top-level definitions, so `black` and `ruff format` will reintroduce them if run with default settings.

## Inline comments

Put **exactly one space** between the end of the code and the `#` of an end-of-line comment.

```python
code = value # right
code = value  # wrong, two spaces
```

This departs from PEP 8 as well, and linters enforcing `E261` ("at least two spaces before inline comment") will flag it. Prefer the single space regardless.

## Multiline function calls, signatures, and collections

Follow the [Julia Blue Style guide](https://github.com/JuliaDiff/BlueStyle) for anything that does not fit on one line. This applies in every language with bracket-delimited calls and collections, Python included — not just Julia.

- One argument or element per line, indented **one level (4 spaces)** from the statement that opens the bracket. Do *not* vertically align arguments with the opening bracket; Blue Style explicitly rejects that.
- **Trailing comma** after the last element of the expanded form. Never a trailing comma in the single-line form.
- **Closing bracket on its own line**, at the indentation of the statement that opened it.
- Nested collections keep their opening and closing brackets at the same indentation level.
- Keep code lines within **92 characters**; exceeding that limit is what triggers the expansion. The limit applies to code, not to prose inside docstrings or comments.

```python
result = compute_thing(
    first_argument,
    second_argument,
    keyword=value,
)

items = [
    1,
    2,
    3,
]

# Single line, so no trailing comma
items = [1, 2, 3]
```
