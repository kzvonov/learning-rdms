## Functional Dependency

`Table = {A, B, C}`

`B -> C` if in all rows where `B` column has the same value `C` column has the same value too, 
and there's no way that two rows have equal `B`, but `C` is different for them.

### Decomposition

1. T = {A, B, C}
2. if `B -> C` then T1 = {A,B} and T2 = {B,C}
3. T = T1 JOIN T2

## Boyce–Codd Normal Form

1. Trivial dependency: `X -> X`
2. `X -> Y` means X is the determinant
3. => "In any non trivial functional dependency key is the determinant"

## Surrogate Key

* RBMS generates regular primary keys ids. Thay are surrogate keys.
* This key doesn't relate to the data in a row, but it's uniq for the row.

## How to make a good schema

1. Make essential keys
2. Use Boyce-Codd normal form
3. Add & check foreign keys
4. Don't forget about essential keys when use surrogate
