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
#include <stdio.h>
int fputc(int ch, FILE *stream)
{ 
  asm(
      "li   x13, 0x10015000 \n\t" 
      "sw   %0, 0(x13) \n\t"
      : :"r" (ch): "x13" );
}

void os_critical_enter(void)
{
}

void os_critical_exit(void)
{
}

