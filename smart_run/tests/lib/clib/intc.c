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
#include "datatype.h"
#include "uart.h"
#include "stdio.h"

#define TCIP_BASE                 0xE0000000
#define CLIC_BASE                 0xE0800000
#define INTIE                     0x400

//config the interrupt controller
void ck_intc_init()
{
	int *picr = TCIP_BASE;
        *picr = 0x0;
        
        // Write ISER
        int *piser = CLIC_BASE+INTIE+0x10;
        *piser = 0x810000;
}
