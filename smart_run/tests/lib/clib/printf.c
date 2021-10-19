/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
#include "stdio.h"
#include "uart.h"

//extern t_ck_uart_device uart0;
////t_ck_uart_device uart0;
////
//int fputc(int ch, FILE *stream)
//{
//   return(ck_uart_putc(&uart0, ch));
//}

//int fputc(int ch, FILE *stream) {
////    int a = ch;
//    asm("subi sp, 4 \n"
//        "st.w r13, (sp, 0) \n"
//        "lrw  r13, 0x6000fff8 \n"
//        "st.b %0, (r13, 0) \n"
////        "\n"
//        "ld.w r13, (sp, 0) \n"
//        "addi sp, 4 \n"
//    : :"r"(ch));
//    return ch;
//}

#define  write_char(x) asm("lrw  r13, 0x6000fff8; st.w %0, (r13, 0)" : :"r" (x) )
int fputc(int ch, FILE *stream) {
    write_char(ch);
    return ch;
}
