


//#include "stdafx.h"
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include "FTD2XX.h"		
#include <string>
#include <vector>
using namespace std;
#pragma comment(lib, "FTD2XX.lib")


int main2(int argc, char* argv[])
{
	FT_HANDLE fthandle;
	FT_STATUS status;
	DWORD data_out;
	DWORD data_written;
	DWORD EventDWord;
	DWORD Rx_data_len;
	DWORD TxBytes;
	HANDLE hEvent;
	DWORD EventMask;
	unsigned char Rx_data_in[65536]; // declare a large buffer for incoming data
	DWORD data_read;

	hEvent = CreateEvent(NULL,       // Default Security Attributes
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


	//unsigned char Tx_data_buf[9] = { 00,'$','D',00,00,00,8,'W','#' };
	//unsigned char Tx_data_buf[9] = { 00,'$','B',00,00,00,64,'W','#' };



	//unsigned char Tx_data_buf1[64] = { 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
	//	'1','2','3','4','5','6','7','8','9','0','@','#'};
	//unsigned char   Rx_CMD[9] =    { 00,'$','D',00,00,00,8,'R','#' };// '*', '*', 'F', 'P', 'G', 'A', 'T', 'E', 'C', 'H', 'S', 'O', 'L', 'U', 'T', 'I', 'O', 'N', '.', 'C', 'O', 'M', ' '};
	//unsigned char   Rx_CMD[9] = { 00,'$','B',00,00,00,64,'R','#' };// '*', '*', 'F', 'P', 'G', 'A', 'T', 'E', 'C', 'H', 'S', 'O', 'L', 'U', 'T', 'I', 'O', 'N', '.', 'C', 'O', 'M', ' '};

	//status = FT_Write(fthandle, &Tx_data_buf, sizeof(Tx_data_buf), &data_written);

	//status = FT_Write(fthandle, &Tx_data_buf1, sizeof(Tx_data_buf1), &data_written);

	//status = FT_Write(fthandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);



	////////////four user reg 

	unsigned char Tx_data_buf[9] = { 00,'$','G',16,17,00,00,'W','#' };
	status = FT_Write(fthandle, &Tx_data_buf, sizeof(Tx_data_buf), &data_written);


	unsigned char Tx_data_buf2[9] = { 00,'$','G',16,99,55,'E','W','#' };
	status = FT_Write(fthandle, &Tx_data_buf2, sizeof(Tx_data_buf2), &data_written);



	unsigned char   Rx_CMD[9] = { 00,'$','G',16,99,00,00,'R','#' };
	status = FT_Write(fthandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);

	for (int ii = 0; ii < 20; ii++)
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

int main1111(int argc, char* argv[])
{
	FT_HANDLE fthandle;
	FT_STATUS status;
	DWORD data_out;
	DWORD data_written;
	DWORD EventDWord;
	DWORD Rx_data_len;
	DWORD TxBytes;
	HANDLE hEvent;
	DWORD EventMask;
	unsigned char Rx_data_in[65536]; // declare a large buffer for incoming data
	DWORD data_read;

	hEvent = CreateEvent(NULL,       // Default Security Attributes
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



	// BURST 2
	// DATA WIDTH 32 MINS 4 BYTES	
	// START ADDRESS 00 00


	unsigned char Tx_big_buff[4096];

	// memcpy 
	//Tx_big_buff[i]=;
	// 00 01 00 02

	short int ij = 0;
	for (int i1 = 0; i1 < 4096; i1 += 2)
	{

		Tx_big_buff[i1] = ij;
		Tx_big_buff[i1 + 1] = ij >> 8;// << 8 | ij;
		ij = ij + 1;

	}


	int iTotalRXLength = 0;
	unsigned char Tx_data_buf1[64] = { 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
		'1','2','3','4','5','6','7','8','9','0','@','#' };

	unsigned char Tx_data_buf[9] = { 00,'$','D',00,00,0,8,'W','#' };

	unsigned char   Rx_CMD[9] =    { 00,'$','D',00,00,0,8,'R','#' };// '*', '*', 'F', 'P', 'G', 'A', 'T', 'E', 'C', 'H', 'S', 'O', 'L', 'U', 'T', 'I', 'O', 'N', '.', 'C', 'O', 'M', ' '};



	status = FT_Write(fthandle, &Tx_data_buf, sizeof(Tx_data_buf), &data_written);

	status = FT_Write(fthandle, &Tx_data_buf1, sizeof(Tx_data_buf1), &data_written);

	status = FT_Write(fthandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);


	for (int ii = 0; ii < 2000; ii++)
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
				iTotalRXLength += Rx_data_len;
				printf("Bytes In RX Queue %d\n", iTotalRXLength);
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
				//printf("%c", Rx_data_in[i]);
				printf("%x ", Rx_data_in[i]);
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


int main100(int argc, char* argv[])
{
	FT_HANDLE fthandle;
	FT_STATUS status;
	DWORD data_out;
	DWORD data_written;
	DWORD EventDWord;
	DWORD Rx_data_len;
	DWORD TxBytes;
	HANDLE hEvent;
	DWORD EventMask;
	unsigned char Rx_data_in[65536]; // declare a large buffer for incoming data
	DWORD data_read;

	hEvent = CreateEvent(NULL,       // Default Security Attributes
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
	////////////four user reg 

	unsigned char Tx_data_buf[9] = { 00,'$','G',16,17,00,00,'W','#' };
	status = FT_Write(fthandle, &Tx_data_buf, sizeof(Tx_data_buf), &data_written);


	unsigned char Tx_data_buf2[9] = { 00,'$','G',16,99,55,'E','W','#' };
	status = FT_Write(fthandle, &Tx_data_buf2, sizeof(Tx_data_buf2), &data_written);



	unsigned char   Rx_CMD[9] = { 00,'$','G',16,99,00,00,'R','#' };
	status = FT_Write(fthandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);

	for (int ii = 0; ii < 20; ii++)
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

		printf("\n\n");
	}

	system("PAUSE");
	getchar();
	status = FT_Close(fthandle);
	return 0;
}
FT_STATUS MySLTLReadRegister(FT_HANDLE hHandle, HANDLE hEvent, unsigned long iRegNo, unsigned char &bData)
{
	DWORD data_written;
	FT_STATUS status;
	DWORD dwSttime = GetTickCount();
	unsigned char   Rx_CMD[9] = { 00,'$','G',16,99,00,00,'R','#' };
	status = FT_Write(hHandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);
	status = FT_SetEventNotification(hHandle, FT_EVENT_RXCHAR, hEvent);
	DWORD data_read;
	DWORD EventDWord;
	DWORD Rx_data_len;
	DWORD TxBytes;
	while (1)
	{
		FT_GetStatus(hHandle, &Rx_data_len, &TxBytes, &EventDWord);
		// wait for data to receive
		if (Rx_data_len > 0)
			break;
	}
	status = FT_Read(hHandle, Rx_CMD, Rx_data_len, &data_read);
	bData = Rx_CMD[1];
	dwSttime = GetTickCount()- dwSttime;
	return status;
}
FT_STATUS MySLTLWriteRegister(FT_HANDLE hHandle, unsigned long iRegNo, unsigned char bData)
{
	DWORD dwSttime = GetTickCount();
	BYTE iLByte = (BYTE)iRegNo;
	BYTE iUByte = (BYTE)(iRegNo>>8);

	FT_STATUS status;
	DWORD data_written;
	unsigned char Tx_data_buf2[9] = { 00,'$','G',iUByte,iLByte,0,bData,'W','#' };
	status = FT_Write(hHandle, &Tx_data_buf2, sizeof(Tx_data_buf2), &data_written);
	dwSttime = GetTickCount() - dwSttime;
	return status;
}
FT_STATUS MySLTLWriteDDRMemory(FT_HANDLE hHandle, vector<unsigned char>vaBuffer, long lSize)
{
	FT_HANDLE fthandle;
	FT_STATUS status;	
	DWORD data_written;

	BYTE iLByte = (BYTE)lSize;
	BYTE iUByte = (BYTE)(lSize >> 8);

	
	unsigned char Tx_data_buf[9] = { 00,'$','D',00,00,iUByte,iLByte,'W','#' };

	status = FT_Write(hHandle, &Tx_data_buf, sizeof(Tx_data_buf), &data_written);
	status = FT_Write(hHandle, &vaBuffer[0], lSize * 8, &data_written);

	return status;
}
FT_STATUS MySLTLReadDDRMemory(FT_HANDLE hHandle, HANDLE hEvent, vector<unsigned char>&vaBuffer,long lSize)
{
	DWORD data_written;
	FT_STATUS status;

	BYTE iLByte = (BYTE)lSize;
	BYTE iUByte = (BYTE)(lSize >> 8);
	
	unsigned char   Rx_CMD[9] = { 00,'$','D',00,00,iUByte,iLByte,'R','#' };
	status = FT_Write(hHandle, &Rx_CMD, sizeof(Rx_CMD), &data_written);

	status = FT_SetEventNotification(hHandle, FT_EVENT_RXCHAR, hEvent);

	DWORD data_read;
	DWORD EventDWord;
	DWORD Rx_data_len;
	DWORD TxBytes;
	int iSize = 0;
	unsigned char Rx_data_in[65535];
	DWORD dwStTime = GetTickCount();
	int iReadTImeOut = 8000;

	for (int ii = 0; ii < 1000; ii++)
	{
		while (1)
		{
			FT_GetStatus(hHandle, &Rx_data_len, &TxBytes, &EventDWord);
			// wait for data to receive
			if (Rx_data_len > 0)
				break;

			if ((GetTickCount() - dwStTime) > iReadTImeOut)
				break;
		}
		status = FT_Read(hHandle, Rx_data_in, Rx_data_len, &data_read);
		iSize += Rx_data_len;
		for (size_t i = 0; i < Rx_data_len; i++)
		{
			vaBuffer.push_back(Rx_data_in[i]);
		}
		if (iSize >= lSize*8)
			break;

		if ((GetTickCount() - dwStTime) > iReadTImeOut)
			break;
	}
	return status;
}
int main(int argc, char* argv[])
{
	FT_HANDLE fthandle;
	FT_STATUS status;
	DWORD data_out;
	DWORD data_written;
	DWORD EventDWord;
	DWORD Rx_data_len;
	DWORD TxBytes;
	HANDLE hEvent;
	DWORD EventMask;
	unsigned char Rx_data_in[65536]; // declare a large buffer for incoming data
	DWORD data_read;

	hEvent = CreateEvent(NULL,       // Default Security Attributes
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

	int iSize = 8;//509 bram 
	
	vector<unsigned char> Tx_data_buf1;
	char cCH = 48;
	for (size_t i = 0; i < iSize*8; i++)
	{
		if (i % 10 == 0 && i > 0)
			cCH++;

		Tx_data_buf1.push_back(cCH);
		if (cCH > 120)
			cCH = 0;
	}
	unsigned char iCh = 48;
	MySLTLWriteRegister(fthandle, 0x1063, iCh);
	unsigned char bData;
	MySLTLReadRegister(fthandle, hEvent, 0x1063, bData);
	iCh++;
	if(iCh== bData)
		printf("Register TEST Pass\n \n");
	else
		printf("Register TEST Fail\n \n");

	MySLTLWriteDDRMemory(fthandle, Tx_data_buf1, iSize);

	vector<unsigned char> Rx_data_buf1;
	MySLTLReadDDRMemory(fthandle, hEvent, Rx_data_buf1, iSize);

	BOOL bRamTestPass = 1;
	for (size_t i = 0; i < iSize*8; i++)
	{
		int iRxBit = Rx_data_buf1[i];
		int iTxBit = Tx_data_buf1[i];
		if (iRxBit != iTxBit)
		{
			printf("Ram TEST Fail\n \n");
			bRamTestPass = 0;
			break;
		}
	}
	if(bRamTestPass)
		printf("Ram TEST Pass\n \n");
	
	system("PAUSE");
	getchar();
	status = FT_Close(fthandle);
	return 0;
}