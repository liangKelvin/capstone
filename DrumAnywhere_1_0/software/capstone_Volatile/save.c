//while(1) {
//	// currently using magic number due to problems with system.h header
//		button = IORD_ALTERA_AVALON_PIO_DATA(BUTTONS_BASE);
//
//		if(buttonCount % 10 == 0) {
//			printf("count: %d\n", buttonCount);
//		}
//
//		switch (button) {
//
//			case 7 :
//				buttonCount++;
//				alt_up_character_lcd_init(myLCD);
//				alt_up_character_lcd_set_cursor_pos(myLCD, 0, 1);
//				alt_up_character_lcd_string(myLCD, "tom/Crash");
//
//				int k = 40000;
//				int kcrash = 0;
//				unsigned int tempArr[128];
//				while(kcrash <= crashNumberSamples - 128) {
//					addWav(tom + k, crash + kcrash, tempArr);
//					k += 128;
//					kcrash += 128;
//					if(k >= tomNumberSamples - 128) {
//						k = 0;
//					}
//					playSound(128, tempArr);
//				}
//				while(button == 7)button = IORD_ALTERA_AVALON_PIO_DATA(BUTTONS_BASE);
//				break;
//
//			case 11:
//				buttonCount++;
//				alt_up_character_lcd_init(myLCD);
//				alt_up_character_lcd_set_cursor_pos(myLCD, 0, 1);
//				alt_up_character_lcd_string(myLCD, "hihat Decay");
//
//				int kk = 0;
//				while(kk <= 60000) {
//					kk += 128;
//					playSound(128, hihat+kk);
//				}
//				int j;
//				for (j = 0; j < 3; j++) {
//					kk = 60000;
//					while(kk <= 70000) {
//						kk += 128;
//						playSound(128, hihat+kk);
//					}
//				}
//				while(k <= hihatNumberSamples - 128) {
//					k += 128;
//					playSound(128, hihat+k);
//				}
//				while(button == 11)button = IORD_ALTERA_AVALON_PIO_DATA(BUTTONS_BASE);
//				break;
//
//			case 13:
//				buttonCount++;
//				alt_up_character_lcd_init(myLCD);
//				alt_up_character_lcd_set_cursor_pos(myLCD, 0, 1);
//				alt_up_character_lcd_string(myLCD, "HiHat Amp");
//
//				int scale = 3;
//				playSoundAmp(hihatNumberSamples, hihat, scale);
//				while(button == 13)button = IORD_ALTERA_AVALON_PIO_DATA(BUTTONS_BASE);
//				break;
//
//			case 14:
//				buttonCount++;
//				alt_up_character_lcd_init(myLCD);
//				alt_up_character_lcd_set_cursor_pos(myLCD, 0, 1);
//				alt_up_character_lcd_string(myLCD, "Hi-Hat");
//
//				playSound(hihatNumberSamples, hihat);
//				while(button == 14)button = IORD_ALTERA_AVALON_PIO_DATA(BUTTONS_BASE);
//				break;
//		}
//	}
