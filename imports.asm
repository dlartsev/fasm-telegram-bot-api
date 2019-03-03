format PE GUI
entry start

include 'INCLUDE\win32ax.inc'
include 'INCLUDE\encoding\utf8.inc'

section '.data' readable writeable

	INTERNET_OPEN_TYPE_PRECONFIG = 4
	INTERNET_DEFAULT_HTTP_PORT = 80
	InternetOpenHandle du ?

section '.code' code readable executable

start:

	invoke InternetOpen, 'FASMBOT', INTERNET_OPEN_TYPE_PRECONFIG, 0, 0, 0
	mov [InternetOpenHandle], eax
	cmp eax, 0
	je errorInternetOpenHandle
	; обработка ошибки
	
	invoke InternetConnect, InternetOpenHandle, 'www.api.telegram.org', INTERNET_DEFAULT_HTTP_PORT, 0, 0, INTERNET_SERVICE_HTTP, 0, 0
	mov [InternetConnectHandle], eax
	cmp eax, 0
	je errorInternetConnectHandle
	; обработка ошибки

	errorInternetOpenHandle:
		invoke MessageBoxW, 0, du 'ОШИБКА: InternetOpenHandle', du 'ОШИБКАОШИБКАОШИБКА', MB_OK

	errorInternetConnectHandle:
		invoke MessageBoxW, 0, du 'ОШИБКА: InternetInternetConnectHandle', du 'ОШИБКАОШИБКАОШИБКА', MB_OK


section '.idata' import data readable writeable
	
    library wininet, 'wininet.dll', \
    kernel32, 'kernel32.dll', \

    import kernel32, \
    CreateFile, 'CreateFileA',\
    WriteFile, 'WriteFile',\
    lstrlen, 'lstrlenA',\
    ExitProcess, 'ExitProcess'
 
 	import user32, \
 	MessageBoxW, 'MessageBoxW', \
    wsprintfW,   'wsprintfW'

    import wininet, \   
    HttpOpenRequest, 'HttpOpenRequestW', \
    InternetOpen, 'InternetOpenW', \
    HttpAddRequestHeaders, 'HttpAddRequestHeadersW', \
    HttpQueryInfo, 'HttpQueryInfoW', \
    InternetConnect, 'InternetConnectW', \
    HttpSendRequest, 'HttpSendRequestW', \
    InternetOpenUrl, 'InternetOpenUrlW', \
    InternetReadFile 'InternetReadFile', \
    InternetCloseHandle, 'InternetCloseHandle'
