//+------------------------------------------------------------------+
//|                                                Acorralado-CE.mqh |
//|                                                        Close Even|
//|                                  Copyright 2018, Gustavo Carmona |
//|                                           http://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "http://www.awtt.com.ar"
#property version   "1.00"
#property strict



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Acorralado
  {
private:
   string name, cad;
   double deltaTips, lots, deltaStTp, deltaOrders;
   double priceBuys, priceSells;
   double balance;
   bool botIsOpen;
   int firstOrderOP;
   int p, magicNumber;
   int lsNumOrder[10];
   
   
public:
                     Acorralado(string robotName, int robotMagicNumber);
                    ~Acorralado();
   void              loadTicketArray(void);
   double            getBalance();
   string            getBotName(void){return name;}
   void              close();
   
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Acorralado::Acorralado(string robotName, int robotMagicNumber)
  {
   name = robotName+"-"+Symbol();
   magicNumber = robotMagicNumber;
   ArrayInitialize(lsNumOrder, -1);
   cad = "";
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Acorralado::~Acorralado()
  {
  }
//+------------------------------------------------------------------+

void Acorralado::loadTicketArray(void){
   int itotal, i;
   p=0;
   itotal=OrdersTotal();
   cad = "Orders: "+IntegerToString(itotal)+"\n";
   
   
   for(i=0;i<itotal;i++){
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
       // check for opened position, symbol & MagicNumber
       if (OrderSymbol()== Symbol() && OrderMagicNumber() == magicNumber){
         lsNumOrder[p] = OrderTicket();
         Comment(lsNumOrder[p]);
         Sleep(500);
         p++;
         }
      }
      
  
   p=0;
   cad += "TicketArray: ";
   
   while(lsNumOrder[p]>-1){
      cad += IntegerToString(lsNumOrder[p])+", ";   
      p++;
      }
   cad += "\n";
   Comment(cad);


   }

double Acorralado::getBalance(void){
   double dBalance;
   dBalance = 0;
   p=0;
   while(lsNumOrder[p]>-1){
      OrderSelect(lsNumOrder[p],SELECT_BY_TICKET);
      if(OrderType()<=1){
         dBalance += OrderCommission()+OrderSwap()+OrderProfit();
         }
      p++;
      }   



   return dBalance;
   }
   
 void Acorralado::close(void){
   p=0;
   while(lsNumOrder[p]>-1){
      OrderSelect(lsNumOrder[p],SELECT_BY_TICKET);
      if(OrderType()==OP_BUY || OrderType()==OP_SELL)
         OrderClose(lsNumOrder[p],OrderLots(),OrderClosePrice(),10);      
      else
         OrderDelete(lsNumOrder[p]); //buystop, sellstop, etc
   
      p++;
   }
 
    }