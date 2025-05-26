/*
*   Legt allgemeine Information über die Mission fest.
*/

author = "nomisum für Gruppe Adler";                                               // Missionsersteller
onLoadName = "Co Poseidon's Pike";                                                   // Name der Mission
onLoadMission = "";                                                             // Beschreibung der Mission (wird im Ladebildschirm unterhalb des Ladebildes angezeigt)
loadScreen = "data\loadpic.paa";                                                // Ladebild
overviewPicture = "";                                                           // Bild, das in der Missionsauswahl angezeigt wird
overviewText = "";                                                              // Text, der in der Missionsauswahl angezeigt wird

class CfgIdentities
{
	class BinHoden
	{
		face = "PersianHead_A3_01";
		glasses = "";
		name = "Osama Bin Hoden";
		nameSound = "Adams";
		pitch = 1.0;
		speaker = "Male01ENG";
	};
};



class CfgSFX
{
    sounds[] = {};

   

    class prayer2
    {
        name = "prayer2";
        sounds[]={sfxsound};
        sfxsound[]={"USER\sounds\prayer2.ogg",100,1,500,1,1,1,0};
        empty[]= {"",0,0,0,0,0,0,0};
    };    

    

     class arabicsong1
    {
        name = "arabicsong1";
        sounds[]={sfxsound};
        sfxsound[]={"USER\sounds\arabicsong1.ogg",35,1,150,1,1,1,0};
        empty[]= {"",0,0,0,0,0,0,0};
    };
        
    class arabicsong2
    {
        name = "arabicsong2";
        sounds[]={sfxsound};
        sfxsound[]={"USER\sounds\arabicsong2.ogg",35,1,150,1,1,1,0};
        empty[]= {"",0,0,0,0,0,0,0};
    };
};

class CfgVehicles
{
  
  

    class prayer2 // class name to be used with createSoundSource
    {
        sound = "prayer2"; // reference to CfgSFX class
    };


    class arabicsong1 // class name to be used with createSoundSource
    {
        sound = "arabicsong1"; // reference to CfgSFX class
    };

    class arabicsong2 // class name to be used with createSoundSource
    {
        sound = "arabicsong2"; // reference to CfgSFX class
    };

 


};