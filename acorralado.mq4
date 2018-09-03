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
input btc botToClose=bbot;
input double panicProfit = -1;
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
   if(botToClose == 0){
      //get commision+swap+rpofit running orders
      botBalance = bot.getBalance();
      Comment("bot balance: ",botBalance);
      if(botBalance >= panicProfit)
         bot.close(); 
      }else{
      tobBalance = tob.getBalance();
      if(tobBalance >= panicProfit)
         tob.close();   
      Comment("tob balance: ",tobBalance);
      }
   
   Sleep(750);   
   
      
}      
      
    