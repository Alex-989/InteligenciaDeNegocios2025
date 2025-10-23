## Comando para ejecutar en Linux 2022
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Mipassw0rd123!" \
-p 1422:1433 --name sqlserverBI2 \
-v sqlserver-volume:/var/opt/mssql \
-d mcr.microsoft.com/mssql/server:2022-latest


## Comando para ejecutar en Windows 2025
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=passw0rd123456" `
-p 1423:1433 --name sqlserverBI `
-v sqlserver-volume:/var/opt/mssql `
-d mcr.microsoft.com/mssql/server:2025-latest


## Comando para ejecutar en Windows 2022
docker run -d --name sqlserverBI2 `
  -p 1422:1433 `
  -e 'ACCEPT_EULA=Y' `
  -e 'MSSQL_SA_PASSWORD=S3guro!2025' `
  -v mssql2022-data:/var/opt/mssql `
  -d mcr.microsoft.com/mssql/server:2022-latest