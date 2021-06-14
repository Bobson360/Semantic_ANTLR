/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.br.senac.compiladores.syntactic.sint_antlr;

import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;


//import java.io.IOException;
//import org.antlr.v4.runtime.CharStream;
//import org.antlr.v4.runtime.CharStreams;
//import org.antlr.v4.runtime.CommonTokenStream;



/**
 *
 * @author robson
 */
public class Main {
    public static void main(String[] args) throws IOException {
        CharStream cs = CharStreams.fromFileName(args[0]);
        CompLexer lexer = new CompLexer(cs);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        CompParser parser = new CompParser(tokens);
        int val = parser.cmdescrita().val;
        System.out.println("Valor = " + val);

    }
}
