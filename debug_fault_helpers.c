#include "debug_fault_helpers.h"


DEBUG_putc_func * volatile  _fpDebug_putc;

/* set the DEBUG putc function */
void DEBUG_putc_set( DEBUG_putc_func *pFunc )
{
  if( (pFunc == DEBUG_putc_panic) || (pFunc == DEBUG_putc_raw) ){
    /* all is well */
    _fpDebug_putc = pFunc;
  } else {
    _fpDebug_putc = NULL;
    while( _fpDebug_putc == NULL ){
      /* spin */
    }
  }
}

/* map cr/lf for debug uart */
void DEBUG_putc(int c)
{
  void (*f)(int c);

  f = _fpDebug_putc;
  if( (f == DEBUG_putc_raw) || (f == DEBUG_putc_panic) ){
    /* all is well */
  } else {
    /* 
     * Hmm problem or never initialized
     * FIX THIS by assuming all is ok
     */
    f = DEBUG_putc_raw;
    _fpDebug_putc = f;
  }

  if(c=='\n'){
    (*f)('\r');
  }
  (*f)(c);
}

/* These static functions exist to reduce code size. */
static void _virt_bar(void)
{
  DEBUG_putc('|');
}

static void _hyphen(void)
{
  DEBUG_putc('-');
}

static void _newline(void)
{
  DEBUG_putc('\n');
}

static void _colon(void)
{
  DEBUG_putc(':');
}

static void _space(void)
{
  DEBUG_putc(' ');
}


/* output string without a newline to debug uart */
void DEBUG_puts_no_nl(const char *s)
{
  while(*s){
    DEBUG_putc(*s);
    s++;
  }
}

/* output a 4bit hex nibble to debug uart */
void DEBUG_hex4( int v )
{
  v = v & 0x0f;
  v = v + '0';
  if( v > '9' ){
    v = v - 10 - '0' + 'a';
  }
  DEBUG_putc(v);
}


/* output a 8bit hex value to debug uart */
void DEBUG_hex8( int v )
{
  DEBUG_hex4( v >> 4 );
  DEBUG_hex4( v >> 0 );
}

/* output a 16bit hex value to debug uart */
void DEBUG_hex16( int v )
{
  DEBUG_hex8( v >> 8 );
  DEBUG_hex8( v >> 0 );
}


/* output a 32bit hex value to debug uart */
void DEBUG_hex32( uint32_t v )
{
  DEBUG_hex16( (int)(v >> 16) );
  DEBUG_hex16( (int)(v >>  0) );
}

/* output a 32bit hex value to debug uart */
void DEBUG_hex64( uint64_t v )
{
  DEBUG_hex32( (uint32_t)(v >> 32) );
  DEBUG_hex32( (uint32_t)(v >>  0) );
}

/* output an integer vaule to debug uart */
void DEBUG_decimal( int v )
{
  char numbuf[ 16 ];
  char *cp;

  /* inline atoi() not relying on any library function 
   * Remember: The system is dead.... 
   */
  if (v < 0){
    _hyphen();
    v = -v;
  }

  /* generate ascii number */
  cp = numbuf;
  do {
    *cp = (v % 10) + '0';
    v = v / 10;
    cp++;
  } while(v)
    ;

  /* reverse/print */
  do {
    cp--;
    DEBUG_putc(*cp);
  } while( cp >= numbuf )
    ;
}

/* common function for various label items */
static void _debug_label( const char *s, void (*func)(int v), int v )
{
  DEBUG_puts_no_nl(s);
  _colon();
  _space();
  (*func)( v );
  _newline();
}

/* print label followed by 32bit hex value */
void DEBUG_label32( const char *s, uint32_t v )
{
  _debug_label( s, (void (*)(int))DEBUG_hex32, v );
}

/* print label followed by 16bit hex value */
void DEBUG_label16( const char *s, int v )
{
  _debug_label( s, (void (*)(int))DEBUG_hex16, v );
}

/* print label followed by 8bit hex value */
void DEBUG_label8( const char *s, int v )
{
  _debug_label( s, (void (*)(int))DEBUG_hex8, v );
}

/* print label followed by integer (decimal) value */
void DEBUG_labelInt( const char *s, int v )
{
  _debug_label( s, (void (*)(int))DEBUG_decimal, v );
}


/* print label followed by string value */
void DEBUG_labelStr( const char *s, const char *v )
{
  DEBUG_puts_no_nl(s);
  _colon();
  _space();
  DEBUG_puts_no_nl(v);
  _newline();
}

/* print 1 line of a memory dump */
static void _dumpline(intptr_t addr, const uint8_t *p8, size_t len )
{
  int c;
  size_t x;
  size_t start;

  /* print address */
  if( sizeof(intptr_t) == 4 ){
    DEBUG_hex32(addr & (~0x0f));
  } else {
    DEBUG_hex64(addr & (~0x0f));
  }
  _colon();
  _space();
 

  /* determine start address of memory dump */
  start = addr & 0x0f;

  /* hex component */
  for( x = 0 ; x < 16 ; x++ ){
    if( (x >= start) && (x < len) ){
      DEBUG_hex8( p8[x] );
    } else {
      _space();
      _space();
    }
    if( x == 7 ){
      /* visual seperator */
      _hyphen();
    } else {
      _space();
    }
  }

  /* ascii component */
  _virt_bar();
  for( x = 0 ; x < 16 ; x++ ){
    if( (x >= start) && (x < len) ){
      c = p8[x] & 0x0ff;
      /* inline: "isascii()" */
      if( (c < 0x20) || (c >= 0x7f) ){
	c = '.';
      }
    } else {
      c = ' ';
    }
    DEBUG_putc(c);
    /* visual seperator */
    if( x == 7 ){
      _hyphen();
    }
  }
  _virt_bar();
  _newline();
}

    
    
/* Perform a hexdump */  
void DEBUG_memdump( uintptr_t addr, const void *data, size_t len )
{
  size_t n;
  const uint8_t *p8;
  p8 = (const uint8_t *)(data);
  size_t start_offset;

  /* handle starting at non-multiple of 16 */
  start_offset = (addr & 0x0f);
  if( start_offset ){
    n = start_offset + len;
    if( n > 16 ){
      n = 16;
    }
    _dumpline( addr, p8-start_offset, n );
    n = n - start_offset;
    addr += n;
    p8   += n;
    len  -= n;
  }

  /* the bulk of the data */
  while( len > 0 ){
    n = len;
    if(n > 16){
      n = 16;
    }
    _dumpline( addr, p8, n );
    addr += n;
    p8 += n;
    len = len - n;
  }
}
 
