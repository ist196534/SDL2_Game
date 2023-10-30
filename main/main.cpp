#include "Texture.h"
#include "Game.h"
#include <SDL.h>
#include <SDL_image.h>


int main(int argc, char* argv[]){

    Game FreeRuben;

    //Start up SDL and create window
    if(!FreeRuben.init())
    {
        printf("Failed to initialize!\n");
    }
    else
    {
        //Load media
        if(!FreeRuben.loadMedia())
        {
            printf("Failed to load media!\n");
        }
        else
        {   
            //Run program
            FreeRuben.run();
        }
    }

    //Free resources and close SDL
    FreeRuben.close();

    return 0;
}
