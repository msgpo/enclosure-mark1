#include "MycroftDisplay.h"
#include "MycroftEncoder.h"
#include "MycroftEyes.h"

class MycroftMenu {
public:
    MycroftMenu(int pinCS1, int pinWR, int pinDATA, int pinENC1, int pinENC2, int pinBUTTON);
    enum menuState {
        MAIN, BRIGHTNESS, RESETMODE
    };
    menuState getCurrentMenu();
    void run();
    void enter();
    void finishTest();
    void updateOptionIndex(bool up);
    bool isEntered();
    bool checkTest();
    bool withinUpperBound();
    bool withinLowerBound();
    void checkButton();
    void syncBrightness();

private:
    MycroftDisplay display;
    MycroftEncoder encoder;
    bool entered, shouldTest, resetVal;
    struct OptionContainer {
        enum Option{
            WIFI, RESET, REBOOT, SHUTDOWN, TEST, EXIT, ILLUM, SSH, DEMO
        };
        Option option;
    };
    menuState currentState;
    OptionContainer menuOptions[9];
    uint8_t optionIndex;
    const uint8_t maxIndex = 8;
    const uint8_t resetIndex = maxIndex;
    void insertOptions();
    void drawOption(bool leftArrow, const String& option, bool rightArrow);
};
