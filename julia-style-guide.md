# Personal Julia style guide

In general, follow the [Invenia Blue style guide](https://github.com/invenia/BlueStyle).

## Exceptions to the Blue style guide

### Method definitions

Use spaces around equals signs in keyword arguments.

```julia
# Bad:
foo(x; y="hello", b="world") = ...

# Good:
foo(x; y = "hello", b = "world") = ...
```

When using the expanded function notation, include a comma after the last
argument, even if all arguments fit on one indented line.

```julia
# Bad:
function foo(
    df::DataFrame, id::Symbol, variable::Symbol, value::AbstractString
)
    # ...
end

# Good:
function foo(
    df::DataFrame, id::Symbol, variable::Symbol, value::AbstractString,
)
    # ...
end
```

## Cases not covered by the Blue style guide

### Method type parameters

When a method definition is too long to include type parameter restrictions on
the same line, use curly braces and expanded notation.

```julia
# Good:
function foo(x::T, y::T) where T<:Real
    # ...
end

# Good:
function foo(x::S, y::T) where {S<:AbstractString,T<:Real}
    # ...
end

# Bad:
function foo(my_first_long_argument::S, my_second_long_argument::T) where
    S<:AbstractString where
    T<:Real
    # ...
end

# Good:
function foo(my_first_long_argument::S, my_second_long_argument::T) where {
    S<:AbstractString,T<:Real,
}
    # ...
end
```

### Functions called with only keyword arguments

If a function is called with only keyword arguments (i.e., without any
positional arguments) and the line exceeds the character limit, include the
semicolon on the same line as the open parenthesis and start the first keyword
argument (indented one level) on the next line.

```julia
# Bad:
plot(
    ;
    title = "My title",
    xlabel = "My horizontal axis label",
    ylabel = "My vertical axis label",
    legend = false,
)

# Bad:
plot(
    ; title = "My title",
    xlabel = "My horizontal axis label",
    ylabel = "My vertical axis label",
    legend = false,
)

# Good:
plot(;
    title = "My title",
    xlabel = "My horizontal axis label",
    ylabel = "My vertical axis label",
    legend = false,
)
```

### Macros

If a macro is longer than the character limit, call it using parentheses and
expanded function notation.

```julia
# Good:
@assert x == 0 "My short message"

# Bad:
@assert my_very_very_very_long_condition() "My very very very long message, to be printed in the event that the assertion is false"

# Good:
@assert(
    my_very_very_very_long_condition(),
    "My very very very long message, printed when the assertion is false",
)
```
