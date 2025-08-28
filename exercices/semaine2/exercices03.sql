--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
--source /home/etd/BaseDeDonne/exercices/semaine2/exercices03.sql
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);

create user "retro"@"%" identified by "coucou";
