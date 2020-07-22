


#include "stdafx.h"
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include "FTD2XX.h"		
#pragma comment(lib, "FTD2XX.lib")


int main(int argc, char* argv[])
	{
		FT_HANDLE fthandle;
		FT_STATUS status;
		DWORD data_out ;
		DWORD data_written;
		DWORD EventDWord;
		DWORD Rx_data_len;
		DWORD TxBytes;
		HANDLE hEvent;
		DWORD EventMask;	
		unsigned char Rx_data_in[65536]; // declare a large buffer for incoming data
		DWORD data_read;

		hEvent = CreateEvent(	NULL,       // Default Security Attributes
								FALSE,      // Auto Reset Event
								FALSE,      // Initial State is Non Signaled
								FALSE // Name of the event (optional)
									);


				printf("This exe is Design & Developed By FPGATECHSOLUTION \n");
				printf("Visit US WWW.FPGATECHSOLUTION.COM \n \n \n");


				status = FT_Open(1, &fthandle);
				if (status != FT_OK)
				{
					printf("open device status not ok %d\n", status);
					return 0;
				}



				unsigned char Tx_data_buf[9] = { 00,'$','B',00,00,00,30,'W','#' };
				unsigned char Tx_data_buf1[30] = {'*', '*', 'F', 'P', 'G', 'A', 'T', 'E', 'C', 'H', 'S', 'O', 'L', 'U', 'T', 'I', 'O', 'N', '.', 'C', 'O', 'M', '1','2','3','4','5','6','7','8' };
				unsigned char   Rx_CMD[9] =    { 00,'$','B',00,00,00,30,'R','#' };// '*', '*', 'F', 'P', 'G', 'A', 'T', 'E', 'C', 'H', 'S', 'O', 'L', 'U', 'T', 'I', 'O', 'N', '.', 'C', 'O', 'M', ' '};

				status = FT_Write(fthandle, &Tx_data_buf, sizeof(Tx_data_buf), &data_written);

				status = FT_Write(fthandle, &Tx_data_buf1, sizeof(Tx_data_buf1), &data_written);

				status = FT_Write(fthandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);


				
				//if (status != FT_OK)
				//{
				//	printf("status not ok %d\n", status);
				//}
			//	else
			//	{
			//		printf("data written %d \n \n", data_written);
					//printf("Waiting for Receiving Data %d \n\n", data_written);

				//}

				for (int ii = 0; ii < 10; ii++)
				{
					printf("Waiting for Receiving Data \n");


					EventMask = FT_EVENT_RXCHAR;// | FT_EVENT_MODEM_STATUS;
					status = FT_SetEventNotification(fthandle, EventMask, hEvent);

					
					while (1)
					{

						FT_GetStatus(fthandle, &Rx_data_len, &TxBytes, &EventDWord);
						// wait for data to receive
						if (Rx_data_len > 0)
						{
							printf("Bytes In RX Queue %d\n", Rx_data_len);
							break;
						}

					}


					
					
					status = FT_Read(fthandle, Rx_data_in, Rx_data_len, &data_read);

					if (status != FT_OK)
						printf("status not ok %d\n", status);
					else {
						printf("Total %d Bytes Received As Follows \n \n", data_read);


						for (int i = 0; i < Rx_data_len; i++)
						{
							printf("%c", Rx_data_in[i]);
							//printf("%x ", Rx_data_in[i]);
						}
				
					
					}



					
						//printf(" loop nmber %d \n \n", ii);

					printf("\n\n");

				}
				
				system("PAUSE");
				getchar();
				status = FT_Close(fthandle);
				return 0;
			}

			//OPTPUT 
			///M1**FPGATECHSOLUTION.CO