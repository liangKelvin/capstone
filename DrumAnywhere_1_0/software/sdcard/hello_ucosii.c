/*************************************************************************
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.      *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
**************************************************************************
* Description:                                                           *
* The following is a simple hello world program running MicroC/OS-II.The * 
* purpose of the design is to be a very simple application that just     *
* demonstrates MicroC/OS-II running on NIOS II.The design doesn't account*
* for issues such as checking system call return codes. etc.             *
*                                                                        *
* Requirements:                                                          *
*   -Supported Example Hardware Platforms                                *
*     Standard                                                           *
*     Full Featured                                                      *
*     Low Cost                                                           *
*   -Supported Development Boards                                        *
*     Nios II Development Board, Stratix II Edition                      *
*     Nios Development Board, Stratix Professional Edition               *
*     Nios Development Board, Stratix Edition                            *
*     Nios Development Board, Cyclone Edition                            *
*   -System Library Settings                                             *
*     RTOS Type - MicroC/OS-II                                           *
*     Periodic System Timer                                              *
*   -Know Issues                                                         *
*     If this design is run on the ISS, terminal output will take several*
*     minutes per iteration.                                             *
**************************************************************************/


#include <stdio.h>
#include "includes.h"

// All EFSL files are in a source folder "efsl" in the Eclipse project
	// with no further directory nesting underneath.
#include <efs.h>
#include <ls.h>

int main(void)
	{
	    // Create EFSL containers
	    EmbeddedFileSystem efsl;

	    char fileName[LIST_MAXLENFILENAME] = {"out.txt"};
	    File outFile;

	    // Initialises the filesystem on the SD card, if the filesystem does not
	    // init properly then it displays an error message.
	    printf("Attempting to init filesystem");
	    int ret = efs_init(&efsl, SD_CARD_SPI_MASTER_NAME);

	    // Initialize efsl
	    if(ret != 0)
	    {
		printf("...could not initialize filesystem.\n");
		return(1);
	    }
	    else
		printf("...success!\n");

	    // Open/create the output file. Check the documentation for
	    // possible error codes (e.g. file already exists, etc.)
	    printf("\nAttempting to open file: \"%s\"\n", fileName);

	    if (file_fopen(&outFile, &efsl.myFs, fileName, 'w') != 0)
	    {
		printf("Error:\tCould not open file for output\n");
		return(1);
	    }
	    else
	    {
		printf("File open for output...\n");
	    }

	    // Set up the data we want to write out. We'll use two strings here.
	   // char msg1[MSG_LEN] = {"Hello "};
	   // char msg2[MSG_LEN] = {"World!"};

	    // Write each message, taking care to store the return value, which is the
	    // offset for the next write. In real code, be sure to check that the offset
	    // is not 0 each time, indicating a write error.
	    unsigned int offset1 = file_fwrite(&outFile, 0, 5, "Hello");
	    unsigned int offset2 = file_fwrite(&outFile, offset1, 7, "World!");

	    if (!offset1 || !offset2)
            {
                printf("Error:\tWrite did not succeed\n");
                return(1);
            }
            else
                printf("Output written successfully.\n");

	    // Close the file
	    if (file_fclose(&outFile) != 0)
	    {
		printf("Error:\tCould not close file properly\n");
		return(1);
	    }

	    // Unmount the file system
	    fs_umount(&efsl.myFs);

	    return(0);
	}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
