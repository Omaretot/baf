/*
		## British Armed Forces								
		## Programado por Omar Villalobos		
		## Ultima edicion: 18 de Agosto de 2018

		Ultimos cambios (18-07-2018) (R2.1 - Version final)
		* Cambió de la estructura en el codigo
		* Notas muy importante:
		- Se les hace saber desde antemano que el codigo no esta optimizado ni organizado, se les agradece que
		cualquier inconveniente o duda no concurrir con mi persona, este es un codigo el cual no desarollare mas y
		solo editare para conveniencia propia del clan British Armed Forces SA-MP (facebook.com/BAF.MOD) en 
		pequeños aspectos. ¿Por qué no lo editare más? = Estoy trabajando en un nuevo proyecto el cual SI esta
		estructurado y en caso que no tenga exito lo liberare al igual que hice con esta gamemode. Solo dare soporte
		via mi GitHub (Omaretot) en los casos de instalación de la gamemode, no dare soporte sobre instalación de
		sistemas, errores con sus codigos, optimización de los mismos u otros.

		- Filterscript que utiliza el servidor para funcionar correctamente:
		* badmin
		* ComandosAparte
		* Animaciones
		* CrearActors
		* baf_maps (Este lo pueden crear ustedes, los mapeos los cargo aparte)
		* Rappel

		Licencia:

		This program is free software: you can redistribute it and/or modify
	    it under the terms of the GNU General Public License as published by
	    the Free Software Foundation, either version 3 of the License, or
	    (at your option) any later version.

	    This program is distributed in the hope that it will be useful,
	    but WITHOUT ANY WARRANTY; without even the implied warranty of
	    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	    GNU General Public License for more details.

	    You should have received a copy of the GNU General Public License
	    along with this program.  If not, see <https://www.gnu.org/licenses/>.

	    Traducción NO OFICIAL de la licencia (Este texto no tendra un efecto legal ya que no es una traducción oficial
	    del GNU v3.0, guiarse por el texto oficial en ingles):

	    Este programa es software libre: puede redistribuirlo y / o modificar
		bajo los términos de la Licencia Pública General de GNU publicada por
		la Free Software Foundation, ya sea la versión 3 de la Licencia, o
		(a su elección) cualquier versión posterior.

		Este programa se distribuye con la esperanza de que sea útil,
		pero SIN NINGUNA GARANTÍA; sin siquiera la garantía implícita de
		COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Ver el
		Licencia pública general de GNU para más detalles.

		Deberías haber recibido una copia de la Licencia Pública General de GNU
		junto con este programa. De lo contrario, consulte <https://www.gnu.org/licenses/>.

		* Se debe tener en claro que este codigo tiene codigos externos liberados, como lo son include y plugins no creados
		o originados por el autor original de esta obra, lo cuales estan sin protección de la licencia, para tener en cuenta
		mas información sobre la licencia, vease el archivo "LICENSE" en la carpeta raíz.

		* Obra baf2 escrito en el codigo de PAWNO para el videojuego virtual San Andreas Multi:Player, realizado por
		Omar Villalobos, Discord: (Omaretot) y GitHub: --- | Todos los derechos reservados 2017-2018
*/

#include <a_samp>
#include <sscanf2>
#include <YSI\y_ini>
#include <YSI\y_iterate>
#include <zcmd>
#include <streamer>

#undef 	MAX_PLAYERS	
#define MAX_PLAYERS			50

// Teams
#define TEAM_RECLUTAS 		0
#define TEAM_UKRM 			1
#define TEAM_RAF 			2
#define TEAM_UKBA 			3
#define TEAM_USAF 			4
#define TEAM_RANGERS		5
#define TEAM_SPT            7

// Colores
#define COLOR_GREEN 		0x00C200FF
#define COLOR_ROJO  		0xFF000000
#define COLOR_PURPLE        0xC2A2DAAA
#define COLOR_OOC           0xAFAFAFAA
#define COLOR_PINKLIGHT     0xFF9B6AFF
#define COLOR_CRIMSON 		0xDC143CFF
#define COLOR_MEDIUMPURPLE  0x9370DBFF

// Dialogos
#define DIALOGO_CREDITOS 	0
#define DIALOGO_MUSICA      1

// Otros

main( ) { }

new gTeam[MAX_PLAYERS]; // Esta variable contiene los equipos
new gPlayerClass[MAX_PLAYERS];

new UltimaCura[MAX_PLAYERS];

new szString[256];
new nombre[24];

public OnGameModeInit()
{	
	SendRconCommand("loadfs gcm_maps");
			   // skin				posiciones y angulo				armas y balas
	AddPlayerClass(96,	2161.5742,	1905.0181,	10.8203,  35.7537,	0,0,0,0,0,0); // Reclutas
	AddPlayerClass(23,	2496.5444,	-1670.4746,	13.3359,  84.2291,	0,0,0,0,0,0); // UKRM
	AddPlayerClass(160,	2496.5444,	-1670.4746,	13.3359,  84.2291,	0,0,0,0,0,0); // RAF
	AddPlayerClass(287,	800.7412,	-1394.9552,	13.4432,  336.0926,	0,0,0,0,0,0); // UKBA
	AddPlayerClass(287,	2485.0122,	-1677.2888,	13.3373,  110.6219,	0,0,0,0,0,0); // USAF
	AddPlayerClass(51,	-816.08185, 1560.31079, 27.40987, 5.0265,	0,0,0,0,0,0); // RANGERS
	AddPlayerClass(7,  2358.9395,	-655.7584,128.1792,   300.2022,	0,0,0,0,0,0); // SPT
	
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	UsePlayerPedAnims();
	SetGameModeText("Entrenamiento");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	switch(gTeam[playerid])
	{
		case TEAM_RECLUTAS:
		{
			SetPlayerPos(playerid,     215.85483, 1922.27759, 17.13356);// Le damos un spawn
			SetPlayerColor(playerid,   0xFFFFFFAA);// Le damos un color
			GivePlayerWeapon(playerid, 23,2000);// Pistola silenciada
			SetPlayerSkin(playerid,    96);
		}
		case TEAM_UKRM:
		{
			SetPlayerArmour(playerid,  20);
			SetPlayerColor(playerid,   0x0000FFFF);//le damos un color
			SetPlayerPos(playerid,     215.85483, 1922.27759, 17.13356);// Le damos un spawn
			GivePlayerWeapon(playerid, 24,2000);// Deagle
			GivePlayerWeapon(playerid, 29,2000);// Mp5
			GivePlayerWeapon(playerid, 31,2000);// Fusil de asalto (M4)
			GivePlayerWeapon(playerid, 34,500);// Rifle (Sniper)
			GivePlayerWeapon(playerid, 16,5);//Explosivos (c4)
			GivePlayerWeapon(playerid, 25,500);//Escopeta
			GivePlayerWeapon(playerid, 1, 1);
			SetPlayerSkin(playerid,    23);
		}
		case TEAM_RAF:
		{
			SetPlayerColor(playerid,   0x00A200FF);// Le damos un color
			SetPlayerPos(playerid,     -1396.7592, 504.7343, 3.0996);// Le damos un spawn
			GivePlayerWeapon(playerid, 24,2000);// Deagle
			GivePlayerWeapon(playerid, 29,2000);// MP5
			GivePlayerWeapon(playerid, 31,2000);// M4	
			GivePlayerWeapon(playerid, 34,500);// Rifle (Sniper)
			GivePlayerWeapon(playerid, 16,5);// Explosivos (c4)
			GivePlayerWeapon(playerid, 25,500);// Escopeta
			GivePlayerWeapon(playerid, 1, 1);
			SetPlayerSkin(playerid,    160);
		}
		case TEAM_UKBA:
		{
			SetPlayerColor(playerid,   0xFF01FFFF);// Le damos un color
			SetPlayerPos(playerid, 	   -688.9371, 953.4271, 12.1842);// Le damos un spawn
			GivePlayerWeapon(playerid, 24,2000);// Deagle
			GivePlayerWeapon(playerid, 29,2000);// MP5
			GivePlayerWeapon(playerid, 31,2000);// M4
			GivePlayerWeapon(playerid, 34,500);// Rifle (Sniper)
			GivePlayerWeapon(playerid, 16,5);// Explosivos (c4)
			GivePlayerWeapon(playerid, 25,500);// Escopeta
			GivePlayerWeapon(playerid, 1, 1);
		}
		case TEAM_USAF:
		{
			SetPlayerColor(playerid,   0x00A200FF);//	Le damos un color
			SetPlayerPos(playerid, 	   1545.6431,-1676.0101,13.5608);// Le damos un spawn
			GivePlayerWeapon(playerid, 24,2000);// Deagle
			GivePlayerWeapon(playerid, 29,2000);// MP5
			GivePlayerWeapon(playerid, 31,2000);// M4
			GivePlayerWeapon(playerid, 34,500);// Rifle (Sniper)
			GivePlayerWeapon(playerid, 16,5);// Explosivos (c4)
			GivePlayerWeapon(playerid, 25,500);// Escopeta
			GivePlayerWeapon(playerid, 1, 1);
		}
		case TEAM_RANGERS:
		{
			SetPlayerColor(playerid,   0xFFFF00AA);// Le damos un color
		}
		case TEAM_SPT:
		{
			SetPlayerColor(playerid,   0x000000FF);// Le damos un color
			SetPlayerPos(playerid,     -1384.8566, -540.1075, 14.1484);// Le damos un spawn
		}
	}
	SetPlayerTime(playerid, 10, 0);
	SetPlayerWeather(playerid, 7);
	SetPlayerArmour(playerid,20);
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 500);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 500);
	
	
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	gPlayerClass[playerid] = classid;

	switch (classid)
	{
		case 0:
		{
			gTeam[playerid] = TEAM_RECLUTAS;
			GameTextForPlayer(playerid, "~b~RECLUTAS", 2000, 5);//
		}
		case 1:
		{
			gTeam[playerid] = TEAM_UKRM;
			GameTextForPlayer(playerid, "~b~UKRM", 2000, 5);//
		}
		case 2:
		{
			gTeam[playerid] = TEAM_RAF;
			GameTextForPlayer(playerid, "~b~RAF", 2000, 5);//
		}
		case 3:
		{
			gTeam[playerid] = TEAM_UKBA;
			GameTextForPlayer(playerid, "~g~UKBA", 2000, 5);//
		}
		case 4:
		{
			gTeam[playerid] = TEAM_USAF;
			GameTextForPlayer(playerid, "~g~USAF", 2000, 5);//
		}
		case 5:
		{
			gTeam[playerid] = TEAM_RANGERS;
			GameTextForPlayer(playerid, "~r~RANGERS", 2000, 5);//
		}
		case 6:
		{
			gTeam[playerid] = TEAM_SPT;
			GameTextForPlayer(playerid, "~l~SPT", 2000, 5);//
		}
	}
	SetPlayerPos(playerid, 1108.9287,-1413.3531,13.5839);
	SetPlayerFacingAngle(playerid, 4.9588);
	SetPlayerCameraPos(playerid, 1113.2992,-1407.1909,13.4056);
	SetPlayerCameraLookAt(playerid, 1108.9287,-1413.3531,13.5839);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if( gPlayerClass[playerid] == 7 && !IsPlayerAdmin(playerid)) {
		GameTextForPlayer(playerid, "~l~SPT ~n~~r~No puedes acceder a este spawn", 2000, 5);//
		return 0;
	}
	gPlayerClass[playerid] = -1;
	return 1;
}
		
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID) // Detecta si el que produce el daÃ±o es un jugador fÃ­sico.
	{
        if(weaponid > 21 && weaponid < 35) // Detecta si el daÃ±o es producido por un arma del ID 22 al ID 34 (armas de fuego).
 		{
		    PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0); // Reproduce el sonido ID 17802 al jugador que efectÃºa el disparo (issuerid).
        }
		else if( (weaponid == 34 || weaponid == 33) && bodypart == 9)
		{
			SetPlayerHealth(playerid, 0.0);
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendBAFMessage(playerid, COLOR_CRIMSON, "Bienvenido a los entrenamientos de Royal Marines - 2018");
	SetNameTagDrawDistance(8.0);
	UltimaCura[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		SetPlayerScore(killerid,(GetPlayerScore(killerid))+1); //Esto da al asesino 1 punto de score.
		GivePlayerMoney(killerid, 1000);
		GameTextForPlayer(killerid, "~r~Abatido +1", 1000, 5);
		SendDeathMessage(killerid, reason, playerid);
	}
	GivePlayerMoney(playerid, 1000);
	GameTextForPlayer(playerid, "~r~Abatido", 1000, 0);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOGO_MUSICA)
 	{
 		if(response)
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOGO_MUSICA, DIALOG_STYLE_INPUT,"Audio MP3","{FF0000}Debes colocar un link","Colocar","Cancelar");
			format(szString, sizeof(szString), "{00BCFF}* Un administrador colocó un audio para todo el servidor!");
			SendClientMessageToAll(-1, szString);
			
			for(new i; i < MAX_PLAYERS; i ++)
			{
				PlayAudioStreamForPlayer(i,inputtext);
			}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/help", true))
    {
        SendClientMessage(playerid, -1, "SERVER: This is the /help command!");
        return 1;
	}
    return SendBAFMessage(playerid, COLOR_CRIMSON, "Este comando es inexistente");
}

/* Sistema de radios por equipos /t */
CMD:r(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/r [MENSAJE - RADIO]");
	new text[128];
	if(sscanf(params, "s[128]", text)) SendBAFMessage(playerid, COLOR_CRIMSON, "/r <texto>");
	
	GetPlayerName(playerid, nombre, 24);
	format(text, 128, "[R] %s: %s", nombre, text);
	
	foreach(new i:Player)
	{
		if(gTeam[i] == gTeam[playerid] || GetPVarInt(playerid, "EscucharRadios") == 1 )
		{
			SendBAFMessage(i, 0x87CEEBFF, text);
		}
	}
	return 1;
}

CMD:base(playerid, params[])
{
	SetPlayerPos(playerid, 274.94855, 1989.24670, 17.02209);
	return 1;
}

CMD:creditos(playerid, params[])
{
	return ShowPlayerDialog(playerid, DIALOGO_CREDITOS, DIALOG_STYLE_MSGBOX, "Creditos", "Omar Adrian Villalobos - [UKRM]Sgt.Andrew", "Cerrar", "");
}

CMD:estado(playerid, params[])
{
	SetPlayerHealth(playerid, 100);
	SendBAFMessage(playerid, COLOR_GREEN, "Usted ha regenerado su vida");
	return 1;
}

CMD:chaleco(playerid, params[])
{
	SetPlayerArmour(playerid, 20);
	SendBAFMessage(playerid, COLOR_GREEN, "Usted ha generado blindaje");
	return 1;
}

CMD:piloto(playerid, params[])
{
	SetPlayerHealth(playerid, 100);
	ResetPlayerWeapons(playerid);
	SetPlayerSkin(playerid, 61);
	GivePlayerWeapon(playerid, 23, 500);
	SendBAFMessage(playerid, COLOR_GREEN, "Usted cogio el kit de piloto");
	return 1;
}

CMD:kill(playerid, params[])
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:sandstorm(playerid, params[])
{
	SetPlayerWeather(playerid, 19);
	return 1;
}

CMD:lluvia(playerid, params[])
{
	SetPlayerWeather(playerid, 8);
	return 1;
}

CMD:neblina(playerid, params[])
{
	SetPlayerWeather(playerid, 9);
	return 1;
}

CMD:dia(playerid, params)
{
	SetPlayerTime(playerid, 10, 0);
	SendBAFMessage(playerid, COLOR_GREEN, "Has puesto de dia");
	return 1;
}

CMD:noche(playerid, params)
{
	SetPlayerTime(playerid, 0, 0);
	SendBAFMessage(playerid, COLOR_GREEN, "Has puesto de noche");
	return 1;
}

CMD:anochecer(playerid, params)
{
	SetPlayerTime(playerid, 20, 0);
	SendBAFMessage(playerid, COLOR_GREEN, "Has puesto la hora en el anochecer");
	return 1;
}

CMD:amanecer(playerid, params)
{
	SetPlayerTime(playerid, 5, 30);
	SendBAFMessage(playerid, COLOR_GREEN, "Has puesto la hora en el amanecer");
	return 1;
}

CMD:rep(playerid, params)
{
	SetPlayerPos(playerid, -593.7208, 636.6063, 15.6960);
	return 1;
}

CMD:musicall(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOGO_MUSICA, DIALOG_STYLE_INPUT,"{00FF0D}Musica MP3","{FFFFFF}Coloca el link de la cancion\n{FFFFFF}Debe ser en mp3","Aceptar","Cancelar");
    return 1;
}

CMD:anfibio(playerid, params)
{
	SetPlayerPos(playerid, 257.6411, 2902.6387, 8.4388);
	return 1;
}

CMD:monte(playerid, params)
{
	SetPlayerPos(playerid, -2322.30396, -1634.84583, 483.18939);
	return 1;
}

CMD:gym(playerid, params)
{
	SetPlayerPos(playerid, 2218.5071, -1728.9443, 12.8937);
	return 1;
}

CMD:campo1(playerid, params)
{
	SetPlayerPos(playerid, 802.0491, 1698.0173, 5.5374);
	return 1;
}

CMD:angelpine(playerid, params)
{
	SetPlayerPos(playerid, -2252.1396, -2547.6367, 32.9373);
	return 1;
}

CMD:negro (playerid, params)
{
   SetPlayerColor(playerid, 0x000000FF);
   SendBAFMessage(playerid, COLOR_GREEN, "Tu nuevo color es negro");
   return 1;
}

CMD:azul(playerid, params)
{
   SetPlayerColor(playerid, 0x0000FFFF);
   SendBAFMessage(playerid, COLOR_GREEN, "Tu nuevo color es azul");
   return 1;
}

CMD:verde(playerid, params)
{
   SetPlayerColor(playerid, 0x006900FF);
   SendBAFMessage(playerid, COLOR_GREEN, "Tu nuevo color es verde");
   return 1;
}

CMD:amarillo(playerid, params)
{
   SetPlayerColor(playerid, 0xFFFF00AA);
   SendBAFMessage(playerid, COLOR_GREEN, "Tu nuevo color es amarillo");
   return 1;
}


CMD:rojo(playerid, params)
{
   SetPlayerColor(playerid, 0xFF000044);
   SendBAFMessage(playerid, COLOR_GREEN, "Tu nuevo color es rojo");
   return 1;
}

CMD:paracaidas(playerid, params)
{
	GivePlayerWeapon(playerid, 46, 1);
	SendBAFMessage(playerid, COLOR_GREEN, "Has generado un paracaidas");
	return 1;
}

CMD:camara(playerid, params)
{
	GivePlayerWeapon(playerid, 43, 500);
	SendBAFMessage(playerid, COLOR_GREEN, "Has generado un camara fotografica");
	return 1;
}

CMD:version(playerid, params)
{
	SendBAFMessage(playerid, COLOR_GREEN, "v2.0");
	return 1;
}

CMD:vnocturna(playerid, params)
{
	GivePlayerWeapon(playerid, 44, 1);
	SendBAFMessage(playerid, COLOR_GREEN, "Has generado un visor nocturno");
	return 1;
}

CMD:vtermica(playerid, params)
{
	GivePlayerWeapon(playerid, 45, 1);
	SendBAFMessage(playerid, COLOR_GREEN, "Has generado un visor termico");
	return 1;
}

CMD:aerosf(playerid, params)
{
	SetPlayerPos(playerid, -1362.2463, -247.2097, 14.1440);
	SendBAFMessage(playerid, COLOR_GREEN, "Has sido teleportado al Aeropuerto de San Fierro");
	return 1;
}

CMD:aerols(playerid, params)
{
	SetPlayerPos(playerid, 1928.8539, -2472.3022, 13.5391);
	SendBAFMessage(playerid, COLOR_GREEN, "Has sido teleportado al Aeropuerto de Los Santos");
	return 1;
}

CMD:aerolv(playerid, params)
{
	SetPlayerPos(playerid, 1507.3119, 1492.0270, 10.8344);
	SendBAFMessage(playerid, COLOR_GREEN, "Has sido teleportado al Aeropuerto de Las Venturas");
	return 1;
}

CMD:lv(playerid, params)
{
	SetPlayerPos(playerid, 2031.9473, 1007.3376, 10.8203);
	SendBAFMessage(playerid, COLOR_GREEN, "Has sido teleportado a Las Venturas");
	return 1;
}

CMD:sf(playerid, params)
{
	SetPlayerPos(playerid, -2021.4829, 146.6924, 28.7517);
	SendBAFMessage(playerid, COLOR_GREEN, "Has sido teleportado a San Fierro");
	return 1;
}

CMD:ls(playerid, params)
{
	SetPlayerPos(playerid, 1479.5699,-1740.1569,13.5469);
	SendBAFMessage(playerid, COLOR_GREEN, "Has sido teleportado a Los Santos");
	return 1;
}

CMD:spawnear(playerid, params)
{
	switch(gTeam[playerid])
	{
		case TEAM_RECLUTAS:
		{
			SetPlayerPos(playerid,	215.85483, 1922.27759, 17.13356);
		}
		case TEAM_UKRM:
		{
			SetPlayerPos(playerid,	215.85483, 1922.27759, 17.13356);
		}
		case TEAM_RAF:
		{
			SetPlayerPos(playerid,	-1396.7592, 504.7343, 3.0996);
		}
		case TEAM_UKBA:
		{
			SetPlayerPos(playerid, -688.9371, 953.4271, 12.1842);
		}
		case TEAM_USAF:
		{
			SetPlayerPos(playerid, 1545.6431,-1676.0101,13.5608);
		}
		case TEAM_RANGERS:
		{
			SetPlayerPos(playerid, -816.08185, 1560.31079, 27.40987);
		}
		case TEAM_SPT:
		{
			SetPlayerPos(playerid, -1384.8566, -540.1075, 14.1484);
		}	
	}
	SendBAFMessage(playerid, 0x00C200FF, "Has sido teleportado al spawn de su rama");
	return 1;
}

CMD:gravedad(playerid, params[])
{
    SetGravity(0.001);
    return 1;
}

CMD:rgravedad(playerid, params[])
{
	SetGravity(0.008);
	return 1;
}

CMD:humo(playerid, params)
{
	GivePlayerWeapon(playerid, 17, 500);
	SendBAFMessage(playerid, COLOR_GREEN, "Has generado granada de humo");
	return 1;
}

CMD:cuchillo(playerid, params)
{
	GivePlayerWeapon(playerid, 4, 1);
	SendBAFMessage(playerid, COLOR_GREEN, "Has generado un cuchillo");
	return 1;
}

CMD:casino(playerid, params)
{
	SetPlayerPos(playerid, 1006.7594, 2521.5303, 10.7891);
	return 1;
}

CMD:entrels(playerid, params)
{
	SetPlayerPos(playerid, 1951.3647, -2052.5933, 13.3828);
	return 1;
}

CMD:parkour(playerid, params)
{
	SetPlayerPos(playerid, -3404.9995, 1569.8923, 18.5673);
	return 1;
}

CMD:favelas(playerid, params)
{
	SetPlayerPos(playerid, 2216.8501,-1125.9211,25.6250);
	return 1;
}

CMD:wingsuit(playerid, params)
{
	SetPlayerPos(playerid, -273.31302, -596.37622, 16526.75586);
	return 1;
}

CMD:equipo1(playerid, params)
{
	SetPlayerPos(playerid, -1485.9911, -321.1916, 266.5619);
	return 1;
}

CMD:equipo2(playerid, params)
{
	SetPlayerPos(playerid, -1649.7864, -447.4341, 266.5619);
	return 1;
}

CMD:tdm1(playerid, params)
{
	SetPlayerPos(playerid, 1131.9763, 531.7361, 1084.1134);
	return 1;
}

CMD:tdm2(playerid, params)
{
	SetPlayerPos(playerid, 1292.2911, 658.4146, 1084.1381);
	return 1;
}

CMD:skydiving(playerid, params)
{
	SetPlayerPos(playerid, 1856.00562, -147.40210, 2465.88940);
	return 1;
}

CMD:jungle(playerid, params)
{
	SetPlayerPos(playerid, 4206.760254, -1653.833740, 15.899881);
	return 1;
}

CMD:jungle2(playerid, params)
{
	SetPlayerPos(playerid, 367.88101196, -2380.99096680, 20.11400032);
	return 1;
}

CMD:oceandocks(playerid, params)
{
	SetPlayerPos(playerid, 2753.7964, -2458.9495, 13.6432);
	return 1;
}

CMD:removerarmas(playerid, params[])
{
	ResetPlayerWeapons(playerid);
	return 1;
}

// CMD ROL

CMD:me(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/me [MENSAJE - ACCIONES]");
    GetPlayerName(playerid, nombre, 24);
    format(szString, 500, "%s %s", nombre, params);
    SendRangedMessage(playerid, COLOR_PURPLE, szString, 50);
    return 1;
}

CMD:d(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/d [MENSAJE - DECIR(IC)]");
    GetPlayerName(playerid, nombre, 24);
    format(szString, 500, "[IC]%s dice: %s", nombre, params);
    SendRangedMessage(playerid, -1, szString, 50);
    return 1;
}

CMD:g(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/g [MENSAJE - GRITAR]");
    GetPlayerName(playerid, nombre, 24);
    format(szString, 500, "[IC]%s grita: %s", nombre, params);
    SendRangedMessage(playerid, -1, szString, 100);
    return 1;
}

CMD:sus(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/s [MENSAJE - SUSURRAR]");
    GetPlayerName(playerid, nombre, 24);
    format(szString, 500, "[IC]%s susurra: %s", nombre, params);
    SendRangedMessage(playerid, -1, szString, 15);
    return 1;
}

CMD:do(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/do [MENSAJE - ENTORNO]");
    GetPlayerName(playerid, nombre, 24);
    format(szString, 500, "[IC] - %s ((%s))", params, nombre);
    SendRangedMessage(playerid, COLOR_PINKLIGHT, szString, 50);
    return 1;
}

CMD:b(playerid, params[])
{
	if( isnull( params ) ) return SendBAFMessage(playerid, COLOR_CRIMSON, "/b [MENSAJE - OOC]");
    GetPlayerName(playerid, nombre, 24);
    format(szString, 500, "[OOC] %s: %s", nombre, params);
    SendRangedMessage(playerid, COLOR_OOC, szString, 50);
    return 1;
}

//

CMD:sermedico(playerid, params[])
{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 4, 1);
	GivePlayerWeapon(playerid, 23, 500);
	GivePlayerWeapon(playerid, 29, 50000);
	SetPlayerSkin(playerid, 274);
	return 1;
}

CMD:curar(playerid, params[])
{
	new id;
	if(GetPlayerSkin(playerid) != 274) return SendBAFMessage(playerid, COLOR_CRIMSON, "No eres medico");
	if(sscanf(params, "u", id)) return SendBAFMessage(playerid, COLOR_CRIMSON, "No has ingresado a una ID");
	if(!IsPlayerConnected(id) || id == INVALID_PLAYER_ID) return SendBAFMessage(playerid, COLOR_CRIMSON, "Jugador no conectado o inexistente");
	if(id == playerid) return SendBAFMessage(playerid, COLOR_CRIMSON, "No puedes curarte a ti mismo");
	if(GetTickCount() - UltimaCura[playerid] < 120 * 1000) {
		format( szString, 80, "Faltan %d segundos para que puedas volver a curar.", ( GetTickCount() - UltimaCura[playerid] ) / 1000);
		SendBAFMessage(playerid, COLOR_CRIMSON, szString);
		return 1;
	}

	new Float:pHealth;
	GetPlayerHealth(id, pHealth); 
	if(pHealth >= 100) return SendBAFMessage(playerid, COLOR_CRIMSON, "Este jugador ya esta curado");
	{
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(id, X, Y, Z);
		if(IsPlayerInRangeOfPoint(playerid, 3.0, X, Y, Z))
		{
			new name1[MAX_PLAYER_NAME], name2[MAX_PLAYER_NAME];
			SetPlayerHealth(id, 100.0);
			UltimaCura[playerid] = GetTickCount();
			
			GetPlayerName(playerid, name1, MAX_PLAYER_NAME);
			GetPlayerName(id, name2, MAX_PLAYER_NAME);
			
			format(szString, 128, "Fuiste curado por %s", name1);
			SendBAFMessage(id, COLOR_GREEN, szString);
			format(szString, 128, "Curaste a %s", name2);
			SendBAFMessage(playerid, COLOR_GREEN, szString);
		}
		else SendBAFMessage(playerid, COLOR_CRIMSON, "No estas lo suficientemente cerca");
	}
	return 1;
}

CMD:cuff(playerid, params[])
{ 
    new targetid;
    if(sscanf(params, "u", targetid)) return SendBAFMessage(playerid, COLOR_CRIMSON, "/cuff [Parte del nombre/Player ID]"); 
    if(!IsPlayerConnected(targetid)) return SendBAFMessage(playerid, COLOR_CRIMSON, "El jugador no se encuentra conectado o es inexistente");
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z)) return SendBAFMessage(playerid, COLOR_CRIMSON, "El jugador esta muy lejos de ti");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) return SendBAFMessage(playerid, COLOR_CRIMSON, "El jugador ya se encuentra esposado");
	
	SetPlayerAttachedObject(targetid, 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);
	SetPlayerSpecialAction(targetid,SPECIAL_ACTION_CUFFED);
	
	format(szString, 128, "Has esposado a %s!",GetName(targetid));
	SendBAFMessage(playerid, COLOR_GREEN, szString);
	format(szString, 128, "Has sido esposado por %s!",GetName(playerid));
	SendBAFMessage(targetid, COLOR_CRIMSON, szString);
	return 1; 
} 

CMD:uncuff(playerid, params[]) 
{
	new targetid;
	if(sscanf(params, "u", targetid)) return SendBAFMessage(playerid, COLOR_CRIMSON, "/uncuff [Parte del nombre/Player ID]"); 
	if(!IsPlayerConnected(targetid)) return SendBAFMessage(playerid, COLOR_CRIMSON, "El jugador no se encuentra conectado o es inexistente");

	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(!IsPlayerInRangeOfPoint(targetid, 5.0, pos[0], pos[1], pos[2])) return SendBAFMessage(playerid, COLOR_CRIMSON, "El jugador esta muy lejos de ti");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) return SendBAFMessage(playerid, COLOR_CRIMSON, "El jugador no se encuentra esposado");
 
	SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 0);
	
	format(szString, 128, "Has desesposado a %s!",GetName(targetid));
	SendBAFMessage(playerid, COLOR_GREEN, szString);
	format(szString, 128, "Has sido desesposado por %s!",GetName(playerid));
	SendBAFMessage(targetid, COLOR_CRIMSON, szString);
	return 1;
}	

CMD:color(playerid, params[])
{
	new color1, color2, vehicleid = GetPlayerVehicleID(playerid);
	if(sscanf(params, "dd", color1, color2))return SendBAFMessage(playerid, COLOR_CRIMSON, "/colorveh [color1] [color2]");
	ChangeVehicleColor(vehicleid, color1, color2);
	SendBAFMessage(playerid, COLOR_GREEN, "El color del vehiculo se ha cambiado exitosamente");
    return true;
}

CMD:soplar(playerid, params)
{
	SendClientMessageToAll(-1, "le sopla la polla a harold y le crece la polla");
	return 1;
}

stock SendBAFMessage(playerid, colorid, text[])
{
	new string[144];
	format(string, 144, "[BAF] {FFFFFF}%s", text);
	SendClientMessage(playerid, colorid, string);
	return 1;
}

stock GetName(id)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(id, name, MAX_PLAYER_NAME);
	return name;
}

stock SendRangedMessage(sourceid, color, message[], Float:range) {
    new Float:x, Float:y, Float: z;
    GetPlayerPos(sourceid, x, y, z);
    for (new ii = 0; ii < MAX_PLAYERS; ii++) {
            if(GetPlayerVirtualWorld(sourceid) == GetPlayerVirtualWorld(ii)) {
                if(IsPlayerInRangeOfPoint(ii, range, x, y, z)) {
                    SendClientMessage(ii, color, message);
                }
            }
        }
    }
	

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
***************************************************** FIN DE LA GAMEMODE - RESPETE LOS CREDITOS *****************************************************
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
