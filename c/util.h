#define BIT(n)         					(1<<(n))
#define BIT_SET(n, mask)        (n |= (mask))
#define BIT_CLEAR(n, mask)      (n &= ~(mask))
#define BIT_FLIP(n, mask)       (n ^= (mask))

/* for ranges from 0-31 */
#define BIT_FIELD_MASK(a, b) (((0xffffffff >> (31-b)) >> a) << a)
