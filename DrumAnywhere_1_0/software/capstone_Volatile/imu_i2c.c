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

/*************************************************************************

Drum Anywhere - G4
Created By - Shivansh Singla and Jake Davidson
Date Created - 20th Feb, 2016
Description - This program uses the MPU9250 library along with the I2C
communication library to establish a connection to the MPUs and start 
reading raw data from the registers anfter proper self tests, initialization 
and calibration. Once the raw data is read, it is converted to meaningful 
acceleration and gyration values using appropriate resolution functions.


**************************************************************************/

#include "DrumAnyWhere.h"

/* This task initializes the IMUs using I2C communication and reads data from the registers */
void pollIMU(void* pdata){

	//Temporary buffer to read into
	alt_u8 ReadBuf[6];
	//Device address
	alt_u8 deviceAddress = 0xD0;
	//WHO AM I Register
	alt_u8 whoamireg = 0x75;
	alt_u16 buflen = 1;
	// Self tests, biases and resolution for DPS conversions
	float selfTest[6];
	float aRes, gRes;

    // WHO AM I testing
  	I2C_Start(I2C_SCL_BASE,I2C_SDA_BASE);
    if(!I2C_ReadFromDeviceRegister(I2C_SCL_BASE,I2C_SDA_BASE, deviceAddress, whoamireg, (alt_u8*)&ReadBuf, buflen, true)){

	  }
    I2C_Stop(I2C_SCL_BASE, I2C_SDA_BASE);
    printf("DrumStick #1 - WHO AM I: %0x\n", ReadBuf[0]);

    printf("Starting Self Tests - DrumStick #1\n");

    //Self Testing
    MPU9250SelfTest(selfTest, I2C_SCL_BASE,I2C_SDA_BASE);
    printf("x-axis self test: acceleration trim within : ");
   	printf("%.1f", selfTest[0]); printf("%% of factory value\n");
  	printf("y-axis self test: acceleration trim within : ");
  	printf("%.1f", selfTest[1]); printf("%% of factory value\n");
  	printf("z-axis self test: acceleration trim within : ");
  	printf("%.1f", selfTest[2]); printf("%% of factory value\n");
  	printf("x-axis self test: gyration trim within : ");
  	printf("%.1f", selfTest[3]); printf("%% of factory value\n");
  	printf("y-axis self test: gyration trim within : ");
  	printf("%.1f", selfTest[4]); printf("%% of factory value\n");
  	printf("z-axis self test: gyration trim within : ");
  	printf("%.1f", selfTest[5]); printf("%% of factory value\n");


  	printf("DrumStick #1 initialized for active data mode....\n");

  	// Get sensor resolutions
  	getAres(&aRes);
  	getGres(&gRes);

	int hit_flag_1 = 0;
	int gz_hit_flag_1 = 0;
	int gy_hit_flag_1 = 0;

	int drum1_index = 1;
	int drum1_gy_count_up = 0;
	int drum1_gy_count_down = 0;

	// WHO AM I testing
	I2C_Start(I2C_SCL_2_BASE, I2C_SDA_2_BASE);
	if(!I2C_ReadFromDeviceRegister(I2C_SCL_2_BASE, I2C_SDA_2_BASE, deviceAddress, whoamireg, (alt_u8*)&ReadBuf, buflen, true)){

	}
	I2C_Stop(I2C_SCL_2_BASE, I2C_SDA_2_BASE);
	printf("DrumStick #2 - WHO AM I: %0x\n", ReadBuf[0]);

	printf("Starting Self Tests - DrumStick #2\n");

	//Self Testing
	MPU9250SelfTest(selfTest, I2C_SCL_2_BASE, I2C_SDA_2_BASE);
	printf("x-axis self test: acceleration trim within : ");
	printf("%.1f", selfTest[0]); printf("%% of factory value\n");
	printf("y-axis self test: acceleration trim within : ");
	printf("%.1f", selfTest[1]); printf("%% of factory value\n");
	printf("z-axis self test: acceleration trim within : ");
	printf("%.1f", selfTest[2]); printf("%% of factory value\n");
	printf("x-axis self test: gyration trim within : ");
	printf("%.1f", selfTest[3]); printf("%% of factory value\n");
	printf("y-axis self test: gyration trim within : ");
	printf("%.1f", selfTest[4]); printf("%% of factory value\n");
	printf("z-axis self test: gyration trim within : ");
	printf("%.1f", selfTest[5]); printf("%% of factory value\n");


	printf("DrumStick #2 initialized for active data mode....\n");
	int hit_flag_2 = 0;
	int gz_hit_flag_2 = 0;
	int gy_hit_flag_2 = 0;

	int drum2_index = 1;
	int drum2_gy_count_up = 0;
	int drum2_gy_count_down = 0;


	int i;
	int k;
	int temp;

  while (1) {
//	 Variables to hold latest sensor data values
	float ax, ay, az, gx, gy, gz, d1_az_old, d2_az_old;

	// Stores the 16-bit signed accelerometer and gyroscope sensor output
	alt_16 accelCount[3];
	alt_16 gyroCount[3];
	d1_az_old = 0;
	d2_az_old = 0;

	//********************* DRUMSTICK #1 *********************************************
	// Read the x/y/z accelerometer values
	readAccelData(accelCount, I2C_SCL_BASE,I2C_SDA_BASE);
	 // Read the x/y/z gyroscope values
	readGyroData(gyroCount, I2C_SCL_BASE,I2C_SDA_BASE);

	// Calculating the acceleration values into actual g's
	// Depends on scale being set
	ax = (float)accelCount[0]*aRes;
	ay = (float)accelCount[1]*aRes;
	az = (float)accelCount[2]*aRes;

	// Calculating the gyro values into actual degrees per second
	// Depends on scale being set
	gx = (float)gyroCount[0]*gRes;
	gy = (float)gyroCount[1]*gRes;
	gz = (float)gyroCount[2]*gRes;

	//printf("gx =  %f, gy = %f, gz = %f \n", gx, gy, gz);
	//printf("%f\n", gy);

	// Horizontal Tracking
	if((gz) < -200){
		if(!gz_hit_flag_1 && drum1_index != 2 && drum1_index != 5){
			drum1_index += 1;
			gz_hit_flag_1 = 1;
		}
	}
	else if (gz < 30){
		gz_hit_flag_1 = 0;
	}

	if((gz) > 200){
		if(!gz_hit_flag_1 && drum1_index != 0 && drum1_index != 3){
			drum1_index -= 1;
			gz_hit_flag_1 = 1;
		}
	}
	else if (gz > 30){
		gz_hit_flag_1 = 0;
	}

	// Vertical shift tracking
	if(gy < -70){
		drum1_gy_count_up++;
	}
	else{
		drum1_gy_count_up = 0;
	}

	if(gy > 50){
		drum1_gy_count_down++;
	}
	else{
		drum1_gy_count_down = 0;
	}

	if(drum1_gy_count_up > 14 && drum1_index < 3 ){
		drum1_index += 3;
	}
	if(drum1_gy_count_down > 13 && drum1_index > 2){
		drum1_index -= 3;
	}

	// Hits
	if((((az - d1_az_old)*1000) < -1000)){
		if(!hit_flag_1){
			//printf("Hit One: Position %d\n", drum1_index);
			hit_flag_1 = 1;
			setDrum(drum1_index);
		}
	}
	else if ((((az - d1_az_old)*1000) > 1000)){
		hit_flag_1 = 0;
	}
	d1_az_old =az;

	// ************************ DRUMSTICK #2 **********************************
	// Read the x/y/z accelerometer values
	readAccelData(accelCount, I2C_SCL_2_BASE, I2C_SDA_2_BASE);
	 // Read the x/y/z gyroscope values
	readGyroData(gyroCount, I2C_SCL_2_BASE, I2C_SDA_2_BASE);

	// Calculating the acceleration values into actual g's
	// Depends on scale being set
	ax = (float)accelCount[0]*aRes;
	ay = (float)accelCount[1]*aRes;
	az = (float)accelCount[2]*aRes;

	// Calculating the gyro values into actual degrees per second
	// Depends on scale being set
	gx = (float)gyroCount[0]*gRes;
	gy = (float)gyroCount[1]*gRes;
	gz = (float)gyroCount[2]*gRes;

	// Horizontal Tracking
	if((gz) < -200){
		if(!gz_hit_flag_2 && drum2_index != 2 && drum2_index != 5){
			drum2_index += 1;
			gz_hit_flag_2 = 1;
		}
	}
	else if (gz < 30){
		gz_hit_flag_2 = 0;
	}

	if((gz) > 200){
		if(!gz_hit_flag_2 && drum2_index != 0 && drum2_index != 3){
			drum2_index -= 1;
			gz_hit_flag_2 = 1;
		}
	}
	else if (gz > 30){
		gz_hit_flag_2 = 0;
	}

	// Vertical shift tracking
	if(gy < -70){
		drum2_gy_count_up++;
	}
	else{
		drum2_gy_count_up = 0;
	}

	if(gy > 50){
		drum2_gy_count_down++;
	}
	else{
		drum2_gy_count_down = 0;
	}

	if(drum2_gy_count_up > 14 && drum2_index < 3 ){
		drum2_index += 3;
	}
	if(drum2_gy_count_down > 13 && drum2_index > 2){
		drum2_index -= 3;
	}

	// Hits
	if((((az - d2_az_old)*1000) < -1000)){
		if(!hit_flag_2){
			//printf("Hit two: Position %d\n", drum2_index);
			hit_flag_2 = 1;
			setDrum(drum2_index);
		}
	}
	else if ((((az - d2_az_old)*1000) > 1000)){
		hit_flag_2 = 0;
	}
	d2_az_old =az;

//	if(sem == 0) {
//		for(i = 0; i < 7; i++) {
//			if(isPlaying[i] == 1) {
//				// append waveforms if needed
//				for(k = 0; k < SAMPLE_SIZE; k++) {
//					temp = drums[i]->waveform[drums[i]->index + k];
//					if(temp > 32768) {
//						temp = 65535 - temp;
//						temp *= drums[i]->scale;
//						temp = 65535 - temp;
//					} else {
//						temp *= drums[i]->scale;
//					}
//					nextToPlay[k] += temp;
//				}
//
//				drums[i]->index += SAMPLE_SIZE;
//				if(drums[i]->index >= drums[i]->numberOfSamples - SAMPLE_SIZE) {
//					drums[i]->index = 0;
//					isPlaying[i] = 0;
//				}
//			}
//		}
//		//alt_up_audio_enable_write_interrupt(audio_dev);
//		sem = 1;
//	}
//	alt_up_audio_enable_write_interrupt(audio_dev);
	OSTimeDlyHMSM(0, 0, 0, 1);
  }
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
