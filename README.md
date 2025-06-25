# ProxmoxScript
Scripts Funcionals per la instal·lació i configuració de Proxmox

## Configuracio de xarxa (configurarbond.sh)
Aquest script serveix per configurar la xarxa del nostre proxmox una vegada instal·lat, ens crearà dos xarxes separades una per la nostra empresa i l'altre pel nostre NAS per fer les còpies de seguretat internament.
```
cat /usr/local/sbin/auto-update.sh
```
```
chmod +x /usr/local/sbin/auto-update.sh
```
## Configuracio d'actualitzacions (auto-update.sh)
Aquest script serveix per configurar les actualitzacions automàtiques al proxmox es revisa cada dos setmanes el diumenge a les 2 de la nit, també revisem si tenim que reiniciar, totes les accions es guarden en els logs per saber tot el que ha passat.

### Configuracio previa
```
nano /usr/local/sbin/auto-update.sh
```
```
chmod +x /usr/local/sbin/auto-update.sh
```
```
apt update
apt install msmtp msmtp-mta mailutils -y
```
```
nano /etc/msmtprc
```
```
  GNU nano 7.2                                                                 /etc/msmtprc                                                                          
defaults
auth           on
tls            on
tls_starttls   on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        /var/log/msmtp.log

account        adssl
host           smtp.adssl.com
port           587
from           avisosX@adssl.com
user           avisosX@adssl.com
password       tupassword
tls_certcheck  off

account default : adssl
```
```
chmod 600 /etc/msmtprc
touch /var/log/msmtp.log
chown root:root /var/log/msmtp.log
600 /var/log/msmtp.log
```

#### IMPORTANT POSAR EL CRONTAB
```
crontab -e
```
```
0 2 * * 0 [ $(($(date +\%U) \% 2)) -eq 0 ] && /usr/local/sbin/auto-update.sh
```
