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
   out = "";
   //get commision+swap+rpofit running orders
   botBalance = bot.getBalance();
   out = bot.getBotName()+", "+DoubleToStr(botBalance,4)+"\n";
   
   tobBalance = tob.getBalance();
   out += tob.getBotName()+", "+DoubleToStr(tobBalance,4);
   Comment(out);
   Sleep(750);
   if((botBalance + tobBalance)>-1){
      bot.close();
      tob.close();
      }
      
}      
      
    