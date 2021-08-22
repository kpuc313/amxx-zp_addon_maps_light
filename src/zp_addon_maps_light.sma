/*****************************************************************
*                            MADE BY
*
*   K   K   RRRRR    U     U     CCCCC    3333333      1   3333333
*   K  K    R    R   U     U    C     C         3     11         3
*   K K     R    R   U     U    C               3    1 1         3
*   KK      RRRRR    U     U    C           33333   1  1     33333
*   K K     R        U     U    C               3      1         3
*   K  K    R        U     U    C     C         3      1         3
*   K   K   R         UUUUU U    CCCCC    3333333      1   3333333
*
******************************************************************
*                       AMX MOD X Script                         *
*     You can modify the code, but DO NOT modify the author!     *
******************************************************************
*
* Description:
* ============
* This is a plugin for Counte-Strike 1.6's Zombie Plague Mod which allows admins to set specific light for every map.
*
*****************************************************************/

#include <amxmodx>
#include <amxmisc>

#define MAX_STRING_LEN 256
#define MAX_LINES 64

new map_name[MAX_LINES][MAX_STRING_LEN]
new map_light[MAX_LINES][MAX_STRING_LEN]

public plugin_init() {
	register_plugin("[ZP] Addon: Maps Light", "1.0", "kpuc313")

	load_settings("addons/amxmodx/configs/zp_addon_maps_light.ini")
	
	register_event("HLTV", "maps", "a", "1=0", "2=0");
}

load_settings(szFilename[]) {
	if (!file_exists(szFilename))
		return 0

	new num = 0
	new szText[MAX_STRING_LEN], setname[MAX_STRING_LEN], setlight[MAX_STRING_LEN]
	new a, pos = 0
	while (num < MAX_LINES && read_file(szFilename, pos++, szText, sizeof(szText), a)) {         
		if (szText[0] == ';' || szText[0] == '#')
			continue
		if (parse(szText,setname,sizeof(setname),setlight,sizeof(setlight)) < 2)
			continue

		copy(map_name[num], MAX_STRING_LEN - 1, setname) 
		copy(map_light[num], MAX_STRING_LEN - 1, setlight)
		num++
	}
	return 1
}

public maps() {
	new map[32]
	get_mapname(map, 31)

	for (new i = 0; i <= (MAX_LINES-1); i++) {
		if(map_name[i][0]){
			if(equali(map, map_name[i]))
			set_cvar_string("zp_lighting", map_light[i])
		}
	}
}
