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
```
sudo nano /usr/local/sbin/auto-update.sh
```
```
chmod +x /usr/local/sbin/auto-update.sh
```
#### IMPORTANT POSAR EL CRONTAB
```
crontab -e
```
```
0 2 * * 0 [ $(($(date +\%U) \% 2)) -eq 0 ] && /usr/local/sbin/auto-update.sh
```
