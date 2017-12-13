#if !defined(DEBUG_FAULT_HELPERS_H)
#define DEBUG_FAULT_HELPERS_H

/*
 *  Copyright (c) 2016, The OpenThread Authors.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. Neither the name of the copyright holder nor the
 *     names of its contributors may be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 *  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *  POSSIBILITY OF SUCH DAMAGE.
 */

#include <stddef.h>

#if __cplusplus
extern "C" {
#endif

/**
 * @file
 * @brief
 *   This file defines debug panic functions.
 *
 *
 * About this file:
 *   This file/implimentation purposely does not use 
 *   sprintf() nor anything else, it is purposely 100% 
 *   standalone and does not rely upon anything else.
 *
 * The idea is this: 
 *   Often tests run without a debugger attached.
 *   When a crash occurs, it is very helpful to 
 *   print the registers, stackdump, etc... out
 *   the debug serial port.
 *
 * In the "horrible crash" situation the gotyas are:
 *
 *   Because "all-hell-has-broken-loose" and we are dead
 *   We cannot rely upon any underlying infrastructure
 *   For example the stack is hozed... 
 *   Some implimentations of printf() use malloc()
 *   Some serial ports are interrupt driven.
 * 
 * When this code runs, we are generally quite "dead"
 *
 * This code can be used both at "runtime" and during a 
 * panic dump, all output character based, via either:
 *
 *     DEBUG_putc_raw()
 * or  DEBUG_putc_panic()
 *
 * The platform must supply these 4 functions, details are below.
 *
 * void DEBUG_putc_raw(int c);
 * void DEBUG_putc_panic(int c);
 * int  DEBUG_valid_mem_range( intptr_t addrlow, intptr_t addrhigh );
 */

#include <stdint.h>

typedef void DEBUG_putc_func(int c);
  
/**
 * Set the debug putc function
 *
 * @param[in] pFunc - must be exactly DEBUG_putc_raw() or DEBUG_putc_panic()
 *
 * Sets the internal output function used by the debug dump functions.
 *
 */
void DEBUG_putc_set( DEBUG_putc_func *pFunc );  
  
/** 
 * Output one byte to the DEBUG UART, in the standard way.
 * 
 * @param[in] c byte value to write to the DEBUG UART
 *  
 * Note: CR/LF mapping has already been performed.
 *
 * PLATFORM USAGE:
 *
 *    This function should print text "in the normal way" via the
 *    DEBUG_UART in the normal way, that means If the normal way is
 *    via fancy means (ie: Socket, DMA, or IRQs) then this function
 *    should do exactly that.
 *
 *    For example in the CLI application, this could call Uart::Output()
 */
void DEBUG_putc_raw( int c);
  
/** 
 * Output one byte to the DEBUG UART, in "panic" mode
 * 
 * @param[in] c byte value to write to the DEBUG UART
 *  
 * Note: CR/LF mapping has already been performed.
 *
 * PLATFORM USAGE:
 *
 *    Specifically - prior to this function being called
 *    the panic dump code should(must) have re-initlized 
 *    the DEBUG_UART to some "operational" state.
 *    
 *    This function should be implented as blocking/polling
 *    write to dump crash information to the DEBUG uart.
 *
 */
void DEBUG_putc_panic( int c);

/**
 * Output a byte to DEBUG UART, performing CR/LF mapping as needed.
 *
 * @param[in] c  byte value to be printed.
 *
 * This function will call either:
 *    DEBUG_putc_raw() or  DEBUG_panic_putc()
 */
void DEBUG_putc(int c);

/**
 * Output a null terminated string to the DEBUG UART
 *
 * @param[in] s string to be printed.
 */
void DEBUG_puts_no_nl(const char *s);

/**
 * Output a hex nibble to the DEBUG UART.
 *
 * @param[in] v value to be printed
 */
void DEBUG_hex4( int v );


/**
 * Output a 8bit hex value to the DEBUG UART.
 *
 * @param[in] v value to be printed
 */
void DEBUG_hex8( int v );

/**
 * Output a 16bit hex value to the DEBUG UART.
 *
 * @param[in] v value to be printed
 */
void DEBUG_hex16( int v );

/**
 * Output a 32bit hex value to the DEBUG UART.
 *
 * @param[in] v value to be printed
 */
void DEBUG_hex32( uint32_t v );

/**
 * Output a 64bit hex value to the DEBUG UART.
 *
 * @param[in] v value to be printed
 */
void DEBUG_hex64( uint64_t v );

/**
 * Output a n integer (decimal) value to the DEBUG UART.
 *
 * @param[in] v value to be printed
 */
void DEBUG_hex32( uint32_t v );

/**
 * Output a label, colon, a 32bit value and a newline to the DEBUG_UART
 *
 * @param[in] s text of the label
 * @param[in] v value to be printed
 *
 * Usage example, dumping CPU registers.
 *       DEBUG_label32(  " r3",  pRegs->r3 );
 *
 * Results a string like below beign printed on the DEBUG UART
 *       " r3: deadbeef\r\n"
 */
void DEBUG_label32( const char *s, uint32_t v );


/**
 * Output a label, colon, a 16bit value and a newline to the DEBUG_UART
 *
 * @param[in] s text of the label
 * @param[in] v value to be printed
 *
 * Usage example, dumping CPU registers.
 *       DEBUG_label16(  "abc",  1234 );
 *
 * Results a string like below beign printed on the DEBUG UART
 *       "abc: 04d2\r\n"
 */
void DEBUG_label16( const char *s, int v );

/**
 * Output a label, colon, a 8bit value and a newline to the DEBUG_UART
 *
 * @param[in] s text of the label
 * @param[in] v value to be printed
 *
 * Usage example, dumping CPU registers.
 *       DEBUG_label8(  "foo",  123 );
 *
 * Results a string like below beign printed on the DEBUG UART
 *       "foo: 7b\r\n"
 */
void DEBUG_label8( const char *s, int v );

/**
 * Output a label, colon, a integer (decimal) value and a newline to the DEBUG_UART
 *
 * @param[in] s text of the label
 * @param[in] v value to be printed
 *
 * Usage example, dumping CPU registers.
 *       DEBUG_labelInt(  "foo",  123 );
 *
 * Results a string like below beign printed on the DEBUG UART
 *       "foo: 123\r\n"
 */
void DEBUG_labelInt( const char *s, int v );

/**
 * Output a label, colon, and a string followed by newline to the DEBUG_UART
 *
 * @param[in] s text of the label.
 * @param[in] v text to print
 */
void DEBUG_labelStr( const char *s, const char *v );  
  
/**
 * Output a traditional hex/memory dump of a memory address range.
 *
 * @param[in] addr address to print to the left.
 * @param[in] data data pointer for bytes to print
 * @param[in] len  count of bytes to print.
 */
void DEBUG_memdump( uintptr_t addr, const void *data, size_t len );

/**
 * Return true (non-zero) if this memory range is valid to dump  
 * 
 * @param[in] addrLo low address of range in question
 * @param[in] addrHi high address of range in question
 *
 * This function is used by various panic code prior to performing
 * a memory dump/hexdump of a region. If this function returns
 * false (zero), a message is printed instead of the hexdump.
 */
int DEBUG_valid_mem_range( uintptr_t addrLow, uintptr_t addrHi );  
  
#if __cplusplus
}
#endif
    
  
#endif
