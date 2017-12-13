#ifndef UART_BUFFER_H_
#define UART_BUFFER_H_

typedef struct {
    //bool transmit_buffer;
    uint8_t* pBuffer;
    int readIndex;
    int writeIndex;
    int length;
    int bufferSize;
    int offset;
} UART_buffer;







UART_buffer* UART_BufferInit(UART_buffer* newBuff, int bufferSize);
int UART_BufferPut( UART_buffer* pBufferStruct, uint8_t newByte );
int UART_BufferPuts( UART_buffer* pBufferStruct, uint8_t* buffer, int length );
int UART_BufferGet( UART_buffer* pBufferStruct );
int* UART_BufferGets( UART_buffer* pBufferStruct, int length );
int UART_SpaceAvailable( UART_buffer* pBufferStruct );
int UART_DataAvailable( UART_buffer* pBufferStruct );

#endif