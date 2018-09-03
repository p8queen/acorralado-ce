//+------------------------------------------------------------------+
//|                                                acorralado-CE.mq4 |
//|                                                        Close Even|
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+



//+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict
#include "acorralado.mqh"

//          (name, magicNumber)
Acorralado bot("bot",1500), tob("tob",1600);
double botBalance=0;
double tobBalance=0;
string out;
enum btc {
      bbot=0, //bot
      btob=1, //tob
};

input bool restart = true;
input btc botToClose=bbot;
input double profitToClose = -1;
input double microLotes = 0.03;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  Comment(Point);
  bot.loadTicketArray();
  tob.loadTicketArray();   
  
  return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
   //get balance & close for bot or tob
   if(botToClose == 0){
      //get commision+swap+rpofit running orders
      botBalance = bot.getBalance();
      Comment("bot balance: ",botBalance);
      if(botBalance >= profitToClose){
         bot.close(microLotes); 
         if(restart)
            bot.restart();
         }
      }else{
      tobBalance = tob.getBalance();
      Comment("tob balance: ",tobBalance);
      if(tobBalance >= profitToClose){
         tob.close(microLotes);   
         if(restart)
            tob.restart();
         }
      
      }
   
   Sleep(750);   
   
      
}      
      
    