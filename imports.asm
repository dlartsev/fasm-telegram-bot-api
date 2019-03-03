format  pe gui
entry   start

include 'D:\fasm\INCLUDE\win32ax.inc'
include 'D:\fasm\INCLUDE\ENCODING\utf8.inc'

section '.data' readable writeable

    INTERNET_OPEN_TYPE_PRECONFIG = 4
    INTERNET_DEFAULT_HTTP_PORT = 80
    INTERNET_SERVICE_HTTP = 3

    _PARAMETR_POST du 'POST', 0
    _PARAMETR_URL_SEND_MSG du '/bot605518208:AAFSLlZgGOu2yo22WoBZ_TMHX5Gyms8ZXts/sendMessage?chat_id=558829992&text=HELLOFASMBOT', 0
    _PARAMETR_HTTP du 'HTTP/1.1', 0

    _HTTP_CLIENT du 'Mozilla/4.0 (compatible; MSIE 6.0b; Windows NT 5.0; .NET CLR 1.0.2914)', 0
    _DOMAIN du 'www.api.telegram.org', 0

    _ERRMSG_RequestHandle du 'ОШИБКА: HttpOpenRequestHandle', 0
    _ERRMSG_InternetConnectHandle du 'ОШИБКА: InternetConnectHandle', 0
    _ERRMSG_InternetOpenHandle du 'ОШИБКА: InternetOpenHandle', 0
    _ERR_CAPTION du 'ОШИБКАОШИБКАОШИБКА', 0

    InternetOpenHandle dd ?
    InternetConnectHandle dd ?
    HttpOpenRequestHandle dd ?

section '.code' code readable executable

start:

    invoke InternetOpen, _HTTP_CLIENT, 0, NULL, NULL, 0
    mov [InternetOpenHandle], eax
    cmp eax, 0
    je errorInternetOpenHandle ; если InternetOpenHandle == 0 - плохо
    jmp ConnectToInternet ; если != 0 - хорошо

    ConnectToDomain:
	    invoke InternetConnect, eax, _DOMAIN, INTERNET_DEFAULT_HTTP_PORT, 0, 0, INTERNET_SERVICE_HTTP, 0, 0
	    mov [InternetConnectHandle], eax
	    cmp eax, 0
	    je errorInternetConnectHandle
	    jmp PostInform

		PostInform:
		    invoke HttpOpenRequest, eax, _PARAMETR_POST, _PARAMETR_URL_SEND_MSG, _PARAMETR_HTTP, 0, 0,  , 0
		    mov [HttpOpenRequestHandle], eax
		    cmp eax, 0
		    je errorHttpOpenRequestHandle

    errorInternetOpenHandle:
        invoke MessageBoxW, NULL, _ERRMSG_InternetOpenHandle, _ERR_CAPTION, MB_OK
        invoke InternetCloseHandle, [InternetOpenHandle]
        invoke ExitProcess, 0

    errorInternetConnectHandle:
        invoke MessageBoxW, NULL, _ERRMSG_InternetConnectHandle, _ERR_CAPTION, MB_OK
        invoke InternetCloseHandle, [InternetOpenHandle]
        invoke InternetCloseHandle, [InternetConnectHandle]
        invoke ExitProcess, 0

    errorHttpOpenRequestHandle:
        invoke MessageBoxW, NULL, _ERRMSG_RequestHandle, _ERR_CAPTION, MB_OK
        invoke InternetCloseHandle, [InternetOpenHandle]
        invoke InternetCloseHandle, [InternetConnectHandle]
        invoke InternetCloseHandle, [HttpOpenRequestHandle]
        invoke ExitProcess, 0


section '.idata' import data readable writeable
    
    library wininet, 'wininet.dll', kernel32, 'kernel32.dll', user32, 'user32.dll'
   
    import kernel32, \
    CreateFile, 'CreateFileA', \
    WriteFile, 'WriteFile', \
    lstrlen, 'lstrlenA', \
    ExitProcess, 'ExitProcess'
    
    import user32, \
    MessageBoxW, 'MessageBoxW', \
    wsprintfW, 'wsprintfW'
    
    import wininet, \
    HttpOpenRequest, 'HttpOpenRequestW', \
    InternetOpen, 'InternetOpenW', \
    HttpAddRequestHeaders, 'HttpAddRequestHeadersW', \
    InternetConnect, 'InternetConnectW', \
    HttpSendRequest, 'HttpSendRequestW', \
    InternetCloseHandle, 'InternetCloseHandle'
