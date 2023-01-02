"%plesk_dir%\MySQL\bin\mysql.exe" -uadmin -p<password_for_mysql> -P3306 -Ne"SHOW DATABASES" > "%plesk_dir%\Databases\MySQL\backup\db_list.txt"
cd %plesk_dir%\Databases\MySQL\backup
for /F "tokens=1,2* " %%j in (db_list.txt) do "%plesk_dir%\MySQL\bin\mysqldump.exe" -uadmin -p<password_for_mysql> -P3306 --routines --databases %%j > "%plesk_dir%\Databases\MySQL\backup\%%j.sql"