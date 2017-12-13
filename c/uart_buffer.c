#include "UART_buffer.h"


UART_buffer* UART_BufferInit(UART_buffer* newBuff, int bufferSize) {
    newBuff->pBuffer = (uint8_t*)malloc(bufferSize * sizeof(uint8_t));
    newBuff->writeIndex = 0;
    newBuff->readIndex = 0;
    newBuff->length = 0;
    newBuff->bufferSize = bufferSize;
    newBuff->offset = 1;
    return newBuff;
}

int UART_BufferPut( UART_buffer* pBufferStruct, uint8_t newByte ) {
    uint8_t* pUpdatedBuffer = pBufferStruct->pBuffer;
    int tempLength = pBufferStruct->length;
    int tempWriteIndex = pBufferStruct->writeIndex;

    if (++tempLength > pBufferStruct->bufferSize) {
        return -1;
    }

    if ( ++tempWriteIndex == pBufferStruct->bufferSize ) {
        pBufferStruct->offset = -255;
    }
    else {
        pBufferStruct->offset = 1;
    }

    *(pUpdatedBuffer + pBufferStruct->writeIndex) = newByte;
    pBufferStruct->writeIndex += pBufferStruct->offset;
    pBufferStruct->length++;

    return 0;
}

int UART_BufferPuts( UART_buffer* pBufferStruct, uint8_t* buffer, int length ) {
    int error;
    int count = 0;

    while (count != length) {
        error = UART_BufferPut(pBufferStruct, *(buffer + count));
        count++;

        if (error) {
            return error;
        }
    }

    return 0;
}

int UART_BufferGet( UART_buffer* pBufferStruct ) {
    uint8_t* pUpdatedBuffer = pBufferStruct->pBuffer;
    uint8_t newValue;
    int tempReadIndex = pBufferStruct->readIndex;

    if (!pBufferStruct->length) {
        return -1;
    }

    if ( ++tempReadIndex == pBufferStruct->bufferSize ) {
        pBufferStruct->offset = -255;
    }
    else {
        pBufferStruct->offset = 1;
    }

    newValue = *(pUpdatedBuffer + pBufferStruct->readIndex);
    pBufferStruct->readIndex += pBufferStruct->offset;
    pBufferStruct->length--;

    return newValue;
}

int* UART_BufferGets( UART_buffer* pBufferStruct, int length ) {
    int value;
    int* result = (int*) malloc(length * sizeof(length));
    int count = 0;

    while (count != length) {
        value = UART_BufferGet(pBufferStruct);


        if (value == -1) {
            return NULL;
        }

        *(result+count) = value;
        count++;

    }

    return result;

}

int UART_SpaceAvailable( UART_buffer* pBufferStruct ) {
    return (pBufferStruct->bufferSize - pBufferStruct->length);
}

int UART_DataAvailable( UART_buffer* pBufferStruct ) {
    return (pBufferStruct->length);
}