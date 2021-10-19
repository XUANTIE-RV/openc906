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
/*
 * minilibc stdio
 *
 */

#ifndef _MINILIBC_STDIO_H_
#define _MINILIBC_STDIO_H__

#include <stdarg.h>

#define BUFSIZE 2048

struct __stdio_file {
	int fd;
	int flags;
	unsigned int bs;	/* read: bytes in buffer */
	unsigned int bm;	/* position in buffer */
//	unsigned int buflen;	/* length of buf */
//	char *buf;
	struct __stdio_file *next;	/* for fflush */
	unsigned char ungetbuf;
	char ungotten;
	unsigned int lock;
};

#define ERRORINDICATOR 1
#define EOFINDICATOR 2
#define BUFINPUT 4
#define BUFLINEWISE 8
#define NOBUF 16
#define STATICBUF 32
#define FDPIPE 64
#define CANREAD 128
#define CANWRITE 256

#include <stdio.h>

/* ..scanf */
struct arg_scanf {
	void *data;
	int (*getch)(void*);
	int (*putch)(int,void*);
};

int __v_scanf(struct arg_scanf* fn, const char *format, va_list arg_ptr);

struct arg_printf {
	void *data;
	int (*put)(void*,size_t,void*);
};

int __v_printf(struct arg_printf* fn, const char *format, va_list arg_ptr);
int __isinf(double d);
int __isnan(double d);
int __dtostr(double d,char *buf,unsigned int maxlen,unsigned int prec,unsigned int prec2);
int __lltostr(char *s, int size, unsigned long long i, int base, char UpCase);
int __ltostr(char *s, unsigned int size, unsigned long i, unsigned int base, int UpCase);


#endif /*  _MINILIBC_STDIO_H_ */
