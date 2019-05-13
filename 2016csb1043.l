D  int|float|char|bool
key for|if|else|switch|const|struct
op  [+\-*/%<>=]|"++"|"--"|"=="|"||"|"&&"|&
vname [*]*[a-z]([a-z]|[0-9])*?("[".*"]")?
nvname1 ({vname}*[_#%$?@A-Z]+{vname}*)+
nvname2 ([*]*[0-9]+[^ \n;]*({vname}|{nvname1})+)

fname [a-z_]+
nfname {fname}*[0-9A-Z#%$?@]+{fname}*
%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdbool.h>
/* Struct for identifying the type of declaration*/  
  struct check{
    
      bool isComment ;
      bool isFun ;
      bool isVar_Dec ;
      bool isStruct;
  
  };
  
  
  
  typedef struct check id;
  id* parse;
  int counter = 0,check=0;
  
  //vector<id> parse;
%}
 
%%
        int line_num = 1;
  /* To know all the line numbers */
\n   line_num++;

  /* For passing on headers */
^[ ]*"#".*        ;
  


 /* Verifying for correct variable declarartion */
[ ]*{D}[*]*[ ]+([ ]*({vname})[ ]*([=][ ]*([0-9]+|(["'].*["']))?)?[,]?)+";"        {
                                                                         
                                                              /*Check for Documentation */
                                                          
                                                              if(counter==0 || (!parse[counter-1].isComment && !parse[counter-1].isStruct)){
                                                                check++;
                                                                 if(check == 1)
                                                                   printf("Coding conventions are violated at : \n");
                                                                 printf("Line %d Variable declaration is not documented.\n",line_num);
                                                              }
                                                              //cout<<"Line "<<line_num<<" Variable declaration is not documented"<<endl;
                                                              //parse.push_back(id(3));
                                                              if(counter>0 && parse[counter-1].isStruct)
                                                                 parse[counter].isStruct = true;                                                              
                                                              parse[counter++].isVar_Dec = true;
                                                              
                                                              
                                                              }
                   
 /* Verifying for incorrect variable declaration */                                                                         
[ ]*{D}[ ]+([ ]*(({nvname1}|{nvname2})|{vname})[ ]*([=][ ]*([0-9]+|(["'].*["']))?)?[,]?)+";"     {
                                                                                check++;
                                                                               if(check == 1)
                                                                                 printf("Coding conventions are violated at : \n");
                                                                             //cout<<"Line "<<line_num<<" Variable name are of invalid syntax"<<endl;
                                                                             printf("Line %d Variable names are of invalid syntax.\n",line_num);               
                                                                             /*Check for Documentation */
                                                                             //varDefect(yytext);   
                                                                              if(counter==0 || (!parse[counter-1].isComment && !parse[counter-1].isStruct))
                                                                                 printf("Line %d Variable declaration is not documented.\n",line_num);
                                                                                 
                                                                              if(counter>0 && parse[counter-1].isStruct)
                                                                                parse[counter].isStruct = true;  
                                                                             parse[counter++].isVar_Dec = true;
                                                                             //printf("%s",yytext);
                                                                             }
                                                                             
                                                                             
  /* For knowing statements are comments */                            
"/*"([^*]|"*"+[^/])*"*"+"/"   { 
                                   /*To keep check of line numbers */
                                   int i ;
                                   for(i=0;i<yyleng;i++){
                                      if(yytext[i] == '\n')
                                         line_num++;
                                   }
                                   
                                   /* Pushing is comment to vector list for checking of
                                      proper documentation */
                                   if(counter>0 && parse[counter-1].isStruct)
                                       parse[counter].isStruct = true; 
                                   parse[counter++].isComment = true;

                               } 
                               
  /* Verifying for proper function names */                             
^[ ]*{D}[' ']+{fname}[ ]*"("([ ]*{D}[*]*[ ]+{vname}[,]?)*")"    {  /* Check for Documentation */
                                                      if(counter==0 || !parse[counter-1].isComment){
                                                         check++;
                                                        if(check == 1)
                                                        printf("Coding conventions are violated at : \n");
                                                          printf("Line %d Function is not documented.\n",line_num);
                                                      }
                                                     parse[counter++].isFun = true;
                                                  }
                                                  
 /*Using special declaration of struct */
[ ]*struct[ ]*                  {
                                    /* Check for Documentation */
                                   if(counter==0 || !parse[counter-1].isComment){
                                          check++;
                                          if(check == 1)
                                            printf("Coding conventions are violated at : \n");
                                          printf("Line %d Structure is not documented.\n",line_num);
                                   }
                                   parse[counter++].isStruct = true;
                                     

                                }
                                                   
 /*Verifying for invalid function name */                                                 
^[ ]*{D}[' ']+{nfname}[ ]*"("([ ]*{D}[*]*[ ]+{vname}[,]?)*")"    {
                                                                    check++;
                                                                 if(check == 1)
                                                                   printf("Coding conventions are violated at : \n");
                                                     printf("Line %d Function name has invalid syntax\n",line_num);
                                                     /* Check for Documentation */
                                                      if(counter==0 || !parse[counter-1].isComment)
                                                           printf("Line %d Function is not documented.\n",line_num);
                                                     parse[counter++].isFun = true;
                                                   }
                                                   
 /*Verifying for invalid params */
^[ ]*{D}[' ']+{fname}[ ]*"("([ ]*{D}[*]*[ ]+(({nvname2}|{nvname1})|{vname})[,]?)*")"  {
                                                                           check++;
                                                                           if(check == 1)
                                                                                printf("Coding conventions are violated at : \n");
                                                                           printf("Line %d Parameters passed has invalid syntax\n",line_num);
                                                                           /* Check for Documentation */
                                                                           if(counter==0 || !parse[counter-1].isComment)
                                                                                printf("Line %d Function is not documented.\n",line_num); 
                                                                          parse[counter++].isFun = true;
                                                                       }
                                                                       
 /*Verifying for both invalid params and funvtion name */                                                                      
^[ ]*{D}[' ']+[^(;]+"(".*")"   {
                                     check++;
                                     if(check == 1)
                                        printf("Coding conventions are violated at : \n");
                                     printf("Line %d Function name has invalid syntax\n",line_num);                              
                                     printf("Line %d Parameters passed has invalid syntax\n",line_num);
                                     /* Check for Documentation */
                                     if(counter==0 || !parse[counter-1].isComment)
                                        printf("Line %d Function is not documented.\n",line_num);
                                     parse[counter++].isFun = true;

                               }
 

 /*Parsing out names written in double quotes or single */
 
[ ]*(\"|\').*(\"|\')     ; 
 /* Parsing out valid identifers opeartors and numbers */ 
([0-9]+("."[0-9]+)?)|{op}|{vname}         ;

 /* To classify Invalid identifers */                             
({nvname1}|{nvname2})*       {
                           check++;
                           if(check == 1)
                             printf("Coding conventions are violated at : \n");
                           printf("Line %d Not a valid Identifier name\n",line_num);
                          } 
 
 /* for passing on braces and whitespaces*/                                                                        
[{} \t();:,"']           ;
 
%%


int main(int argc,char* argv[]){
    parse = (id*)malloc(1000*sizeof(id));
    yyin = fopen(argv[1],"r");
    yyout = fopen("./c.txt","w");
    yylex();
    if(check == 0)
      printf("Program meets the coding conventions !\n");
    return 0;
}
