#!/bin/python

# -*- coding:utf-8 -*-
# Author: Jesús Mager
# GPL v.3+
# 2015

import graphviz as gv

# Todos los parámetros son listas o tuplas
# donde:
#  * alfabeto:  es el alfabeto aceptado por el 
#               autómata.
#  * estados:   es una lista de estados aceptados
#               por el autómata.
#  * inicio:    Son los estados de inicio del fsm.
#  * trans:     Es una tupla de funciones de transición
#               con tres elementos que son: (a,b,c) donde
#               (a,b) son los estados de partida y llegada;
#               mientras que c es la letra que acepta.
#  * final      Son los estados finales del autómata.

def draw(alfabeto, estados, inicio, trans, final):
        print("inicio:", str(inicio))
            g = gv.Digraph(format='svg')
                g.graph_attr['rankdir'] = 'LR'
                    g.node('ini', shape="point")
                        for e in estados:
                                    if e in final:
                                                    g.node(e, shape="doublecircle")
                                                            else:
                                                                            g.node(e)
                                                                                    if e in inicio:
                                                                                                    g.edge('ini',e)

                                                                                                        for t in trans:
                                                                                                                    if t[2] not in alfabeto:
                                                                                                                                    return 0
                                                                                                                                        g.edge(t[0], t[1], label=str(t[2]))
                                                                                                                                            g.render(view=True)

                                                                                                                                            # Ejemplo de uso

                                                                                                                                            if __name__ == '__main__':
                                                                                                                                                    estados = ["A","B","C","E","F"]
                                                                                                                                                        trans = [("A","B", 1),("A","E",0),("A","E",1),("A","A",1),("A","D",1),("F","F",1),("D","C",1),("B","A",0), ("E","C",0),("F","D",0), ("C","A",0), ("B","B", 1)]
                                                                                                                                                            inicial = ["A"]
                                                                                                                                                                alf = [0,1]
                                                                                                                                                                    terminal = ("C",)

                                                                                                                                                                        draw(alf, estados, inicial, trans, terminal):q
