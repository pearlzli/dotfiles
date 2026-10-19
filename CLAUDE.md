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

In Julia docstrings, put the signature on its own line, then a blank line, then the description. The signature counts as its own paragraph, so every Julia docstring is multiline, with the triple quotes on their own lines. Never write `"""`f(x)`: does something."""`. For a single method, wrap the signature in one pair of backticks; for several methods, use a code block with one signature per line.

````julia
"""
`merge_st(y::AxisArray)`

Description.
"""

"""
```
f(x::Int)
f(x::Float64, y)
```

Description.
"""
````

Keep docstrings and comments self-contained: describe what the code itself does. Mention another function, type, setting, or variable only when it's essential to understanding the code (e.g. an argument's type, or a key the function reads or writes). No "see `foo`" pointers, no contrasts like "as opposed to `Bar`", and no notes on which other function consumes the result; such references go stale whenever names or structure change.

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

- For a function call or signature that doesn't fit on one line, use the first of these layouts whose lines all fit:
    1. All arguments on a single line.
    2. Positional arguments on one line and keyword arguments on the next (in Julia, end the positional line with `;`).
    3. If only one of those two groups is too long for its line, put that group one argument per line and keep the other group on a single line.
    4. One argument per line.
- For a collection that doesn't fit on one line, put one element per line.
- Indent continuation lines **one level (4 spaces)** from the statement that opens the bracket. Do *not* vertically align arguments with the opening bracket; Blue Style explicitly rejects that.
- **Trailing comma** after the last argument or element of the expanded form. Never a trailing comma in the single-line form.
- **Closing bracket on its own line**, at the indentation of the statement that opened it.
- Nested collections keep their opening and closing brackets at the same indentation level.
- Keep code lines within **92 characters**; exceeding that limit is what triggers the expansion. The limit applies to code, not to prose inside docstrings or comments.

```python
result = compute_thing(
    first_argument, second_argument, keyword=value,
)

items = [
    1,
    2,
    3,
]

# Single line, so no trailing comma
items = [1, 2, 3]
```

```julia
# Layout 1: all arguments on one line
function market_size_weights(
    Q0::AxisArray2D{:m,:t}, t_weights::AxisArray1D{:t}; normalize::Symbol = :mean,
)

# Layout 2: positional arguments, then keyword arguments
function draw_drivers_by_market_carpool(
    q0::AxisArray3D{:i,:m,:t};
    i_axis, m_axis, carpool_flags, t_weights, seed, other_attrs...,
)

# Layout 3: positional arguments one per line, keyword arguments still on one line
function demand_moment_errors(
    mom::DemandShocksMeanZeroByMarketWeightBySize,
    attrs::AbstractDict,
    data::AbstractDict,
    endog::AbstractDict;
    drop_moments::Tuple = (), verbose = true,
)
```

# Julia

## Packages

Never install Julia packages (`Pkg.add` or otherwise) on my behalf, in a project environment or a scratch one. Write the code and the `using` line, then tell me which package to install.

## Scripts outside the repo

`include("x.jl")` resolves a relative path against the directory of the calling file, not the working directory, so `cd(...)` beforehand doesn't help. Scratch scripts outside the repo must include project code by absolute path, e.g. `include(joinpath(repo_dir, "source", "main.jl"))`. After launching a background run, check the log's first lines for a load error before waiting on it.

With stdout redirected to a file (`julia script.jl > out.log 2>&1`), output stays buffered and the log can sit empty for the whole run. In scripts meant for long background runs, call `flush(stdout)` after each step, or print progress to stderr. Put slow, optional steps after cheap checks so the cheap results arrive first.

# Shell

My `.bashrc` aliases `mv` to `mv -i` and `cp` to `cp -i`, so overwriting an existing file prompts for confirmation; in a non-interactive command the prompt gets no answer, the overwrite is silently skipped, and the command still exits 0. To overwrite deliberately, bypass the alias with `\mv -f` or `\cp -f`, and check the result before relying on it.
