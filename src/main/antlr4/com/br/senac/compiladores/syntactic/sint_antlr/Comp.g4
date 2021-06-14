grammar Comp;

programa
	: 'programa' STR bloco | expressao EOF 
	;
	
	bloco	: (begin)+
		;
 
decl    :  (declaravar)+
        ;

declaravar	: VAR  ID  (  VIR ID )* CL type SC
			;

type      	: INT	 
           	;
		 
cmd 	: declaravar 
		| cmdleitura 
		| cmdescrita 
		| cmdattrib  
		| ID
		;
		
begin	: (declaravar)*
		BEGIN 
		(cmd)+ 
		END 
		;	

cmdleitura	: READ		AP 
						expressao 
						FP 
						SC
			;
			

cmdescrita	returns  [ int val ]:			
						WRITE AP 
						expressao { $val = $expressao.val; }
						FP 
						SC
			;
cmdattrib 	: ID ATTR expressao SC
;

expressao returns  [ int val ]
	:	termo expressao2[$termo.val] { $val = $expressao2.sint; }
	;
	
expressao2 [ int her ] returns [ int sint ]
	:	'+' termo exp=expressao2[$termo.val+$her] { $sint = $exp.sint; }
	|	'-' termo exp=expressao2[$her-$termo.val] { $sint = $exp.sint; }
	|	{ $sint = $her; }
	;
	
termo returns [ int val ]
	:	fator termo2[$fator.val] { $val = $termo2.sint; }
	;
	
termo2 [ int her ] returns [ int sint ]
	:	'*' fator term=termo2[$fator.val*$her] { $sint = $term.sint; }
	|	{ $sint = $her; }
	;
	
fator returns [ int val ]
	:	'(' expressao ')' { $val = $expressao.val; }
	|	NUM { $val = Integer.parseInt($NUM.getText()); }
	;
AP	: '('
	;
	
FP	: ')'
	;
	
SC	: ';'
	;

CL	: ':'
	;

OP	: '+' | '-' | '*' | '/'
	;
	
ATTR : ':='
	 ;
	 
VIR  : ','
     ;
     
ACH  : '{'
     ;
     
FCH	 : '}'
     ;
  
DOT	 : '.'
	 ;

//KEYWORDS
VAR		:	'var'		;
IF		:	'if'		;
ELSE	:	'else'		;
BEGIN	:	'begin'		;
END		:	'end'		;
READ	:	'read'		;
WRITE	:	'write'		;
INT		:	'int'		;
FLOAT	:	'float'		;
BOOL	:	'boolean'	;
WHILE	: 	'while'		;
DO		:	'do'		;
NUM		:	'0'..'9'+
;

ID	: [a-z] ([a-z] | [A-Z] | [0-9])*
;

STR  : '"'[a-zA-Z0-9\t ]*'"'
;
	
WS	:	( ' ' | '\n' | '\r' | '\t' ) { skip(); }
	;
