include 'include/win32ax.inc'


section '.data' readable writeable



section '.code' code readable executable
start:




section '.idata' import data readable writeable
	
    library wininet, 'wininet.dll', \
    kernel32, 'kernel32.dll', \

    import kernel32, \
    CreateFile, 'CreateFileA',\
    WriteFile, 'WriteFile',\
    lstrlen, 'lstrlenA',\
    ExitProcess, 'ExitProcess'
 
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
