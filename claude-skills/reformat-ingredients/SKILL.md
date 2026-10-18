---
name: reformat-ingredients
description: Reformat a recipe ingredient list into "thing, characteristics, amount" lines with standardized units and fractions, salt removed, and pantry staples marked with a question mark. Use when the user pastes an ingredient list and asks to reformat, clean up, or convert it.
argument-hint: "[ingredient list, or leave blank and paste it]"
---

# Reformat a recipe ingredient list

The ingredient list comes from the argument or the user's message. If there isn't one, ask for it.

## 1. Line format

Write each ingredient as one line of comma-separated fields in this order: thing, characteristics, amount.

- **Thing**: the ingredient noun, e.g. `Onion`, `Olive oil`, `Chicken thighs`, `Tomatoes`.
- **Characteristics**: everything else that describes it, in this order: variety or color, form (`canned`, `fresh`, `dried`, `ground`), size, preparation (`diced`, `minced`), then notes like `divided` or `optional`. Size words like "medium" are characteristics, not amounts.
- **Amount**: the quantity with its unit, always last. Keep a parenthetical package size as part of the amount, e.g. `1 (15 oz) can`.

Use sentence case: capitalize the first word of the line and proper nouns (`Parmesan`, `Dijon`), nothing else.

Example: `1 medium yellow onion, diced` → `Onion, yellow, medium, diced, 1`.

## 2. Units and numbers

- Abbreviate units as `tsp`, `tbsp`, `oz`, `lb`, `g`, `ml`, `qt`, with no periods and no plural `s`. Write `cup`/`cups` in full, and pluralize count nouns (`cans`, `bunches`) naturally.
- Don't convert between measurement systems.
- Turn Unicode fractions into ASCII: `½` → `1/2`, `1½` → `1 1/2`.
- Turn decimals that are common fractions into fractions: `0.5` → `1/2`, `0.25` → `1/4`, `0.33` → `1/3`.
- Write ranges with a hyphen: `2-3`.

## 3. Removals

- **Salt** of any kind (kosher, sea, table, flaky). In "salt and pepper to taste", drop the salt part.
- **Black pepper** when the recipe gives no amount ("to taste", "freshly ground black pepper"). If an amount is given, keep it.
- **Quality qualifiers** that don't change what to buy: `extra-virgin` (olive oil), `good-quality`, `freshly` in "freshly ground", and similar.

## 4. Garlic and ginger

- **Garlic** that is minced, chopped, grated, or pressed and measured in cloves: convert at 1 clove = 1/2 tsp. Use tbsp when the result is a multiple of 1/2 tbsp (6 cloves = 1 tbsp, 9 cloves = 1 1/2 tbsp); otherwise stay in tsp (8 cloves = 4 tsp). Whole, smashed, or sliced cloves stay in cloves.
- **Ginger** that is grated or minced and measured as a piece: convert at 1 inch = 1 tbsp (1/2 inch = 1 1/2 tsp, 2 inches = 2 tbsp). Sliced or whole ginger stays as written.

## 5. Pantry staples

Append `?` directly to the end of the line, with no space, for ingredients the user usually has on hand:

- Herbs (fresh or dried), spices, and spice blends, including black pepper with an amount
- Oils and vinegars
- Dried pasta, rice, flour, and sugar of any kind
- Garlic and ginger
- Lemons and limes, including their juice and zest
- Sauces and condiments (soy sauce, Worcestershire sauce, hot sauce, mustard, ketchup)
- Stock and broth

Don't mark canned goods (tomatoes, beans, coconut milk), even though they're shelf-stable.

## 6. Sections and repeated ingredients

Drop section headings like "For the sauce:" and flatten everything into one list in the original order.

Whenever the same ingredient appears more than once, within a section or across sections, combine it into one line at its first position. Sum the amounts, converting to a common unit if needed (3 tsp = 1 tbsp), and drop notes like `divided` that only described the split. If the characteristics differ in a way that changes what to buy (e.g. `diced` vs. `crushed` canned tomatoes), keep separate lines.

## 7. Output

Give the result as plain lines, one ingredient per line with no bullets, inside a single code block. Also copy the list to the clipboard without asking: pipe the exact lines, without the code fences, to `pbcopy`. Whenever the list changes later in the conversation, copy the new version too. After the code block, briefly note any judgment calls (an ambiguous staple, a conversion, something removed) and say that the list was copied.

## Example

Input:

```
2 tablespoons extra-virgin olive oil
1 medium yellow onion, diced
4 garlic cloves, minced
1-inch piece fresh ginger, grated
1 (14.5-ounce) can diced tomatoes
1½ teaspoons ground cumin
Kosher salt and freshly ground black pepper
```

Output:

```
Olive oil, 2 tbsp?
Onion, yellow, medium, diced, 1
Garlic, minced, 2 tsp?
Ginger, fresh, grated, 1 tbsp?
Tomatoes, canned, diced, 1 (14.5 oz) can
Cumin, ground, 1 1/2 tsp?
```
