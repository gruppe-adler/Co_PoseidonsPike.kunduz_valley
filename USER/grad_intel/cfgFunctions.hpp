class grad_intel {
    class intel {
        file = USER\grad_intel;
        
        class addIntelDeadDrop;
        class addIntelFile;
        class addIntelPaper;
        class addIntelPaper2;
        class addIntelPaper3;

        class addTrackerAction { postinit = 1; };
        class addTrackerToVehicle;
        class addTrashBinAction;

        class addUploadAction;
        class initTrashBinAction { preInit = 1; };
        class showTracker;
        class walkToDeaddrop;
        
    };
};
