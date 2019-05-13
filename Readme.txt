--------------------------------------------

Assignment1 : Lex for matching Regular exp
Author: Siddharth Nahar
Entry no.: 2016csb1043
Date: 25/1/18

--------------------------------------------
Commands to execute code:

username:~folder_path$ lex 2016csb1043.l
username:~folder_path$ gcc lex.yy.c -lfl
username:~folder_path$ ./a.out Testfilepath


*I have executed first command and generated equivalent C code you can use it  or recompile it.
*I have tested my code on some sample test cases please check the output for error msg understanding
--------------------------------------------------------------------------------------------------

Proper Conventions rules/Error messages :

1. Variable names must be alphanumeric without first letter as digit.
     ex.  ab23 - Valid .char* argv[] - Valid, 2ab3 - Invalid(First letter digit) , _a#b-Invalid(Special Symbol)
   *Taken care of pointers and arrays declaration

2. Function names must contain letters and underscore.
     ex.  _ab - Valid , ab2 - Invalid(Contains digit) , ab#- Invalid(Special Symbol)
     
3. Comments are any statements contained in  /*---------*/ 
   * may contain multiple lines.
   * may contain any characters except * followed by /
   
4. Each function declaration and variable declaration must be preceded by comments.

5. struct must be preceded by comments but its member variables may not be.
   i.e   Is valid struct          Is valid struct                Is invalid          
                                        
                                        
        /*Struct documentation*/  /*Struct dcumentation*/                                                            
        struct name{              struct name{                    struct name{
        
                                      /*variable initalise*/        int a,b;
                                      int a,b;
            int a,b;              };                              };
        
        };   
        
           
6. All declaration not preceded by comments gives     "name Declartion has not been Documented" error

7. If function name is invalid or parameters are invalid   prompts each for each case/can propmt both if both are invalid

8. All identifiers invalid are prompted as many times they are used.
   * Each time they are used error will be prompted specifying line numbers.
   
-----------------------------------------------------------------------------------------------------------------------

Some cases:

1. typedef data types are not taken in consideration because dynamic contet cant be loaded in regular expressions

2. Invalid identifiers dont specify specific reasons because it just matches expression and prompts for its validity

3. C is used only to print and to check for precedence of comments.

-----------------------------------------------------------------------------------------------------------------------        
