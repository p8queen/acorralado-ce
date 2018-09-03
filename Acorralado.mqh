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
   int lastOrderOP;
   int p, magicNumber;
   int lsNumOrder[20];
   
   double            maxMicrolotesOpen(void);
   
public:
                     Acorralado(string robotName, int robotMagicNumber);
                    ~Acorralado();
   void              loadTicketArray(void);
   double            getBalance();
   string            getBotName(void){return name;}
   void              close(double microLotes);
   void              restart(void);
   
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
   
 void Acorralado::close(double microLotes){
   if(maxMicrolotesOpen()>=microLotes){
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
    }
 
 double Acorralado::maxMicrolotesOpen(void){
   double maxMicroLotes;
   maxMicroLotes = 0.01;
   p=0;
   while(lsNumOrder[p]>-1){
      OrderSelect(lsNumOrder[p],SELECT_BY_TICKET);
      if(OrderType()==OP_BUY || OrderType()==OP_SELL){
         if(OrderLots()>maxMicroLotes){
            maxMicroLotes=OrderLots();
            lastOrderOP = OrderType();
            }
         }
       p++;
       }
    
    return maxMicroLotes;
   }
   
 void Acorralado::restart(void){
   Comment("restart ..., last OP: ", lastOrderOP);
   Sleep(1000);
 
 }  