import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'componentes/player.dart';
import 'componentes/world.dart';
import 'package:flutter/material.dart';

class CobrasEscadas extends FlameGame {
  final Player _player1 = Player(pColor: Colors.blue);
  final Player _player2 = Player(pColor: Colors.red);
  final World _world = World();
  int turno = 1;
  bool inicio = true;
  static const double movimentacao = 56;
  static const double movimentacaoMin = 95;
  static const String escada = 'Oba! Casa com escada, você irá para a casa';
  static const String cobra =
      'Essa não! Casa com cobra, você irá voltar para a casa';
  int posicaoPlayer1 = 0;
  int posicaoPlayer2 = 0;

  void jogar(int dado1, int dado2) {
    if (posicaoPlayer1 == 100 || posicaoPlayer2 == 100) {
      msgAlerta('O jogo acabou!');
    } else {
      int dados = dado1 + dado2;
      msgAlerta("Dado 1: $dado1\nDado 2: $dado2\n\nSoma: $dados");
      switch (turno) {
        case 1:
          if (inicio && dado1 == 1 && dado2 == 1) {
            _player1.move(Vector2(movimentacaoMin, 0));
            posicaoPlayer1 = 2;
            cobrasOuEscadas();
            msgAlerta('Jogador Azul está na casa $posicaoPlayer1');
          } else if (inicio) {
            if (dados <= 10) {
              _player1
                  .move(Vector2(movimentacaoMin + movimentacao * (dados - 2), 0));
            } else {
              _player1.move(Vector2(movimentacaoMin + movimentacao * (8), 0));
              _player1.move(Vector2(0, -movimentacao));
              if (dados == 12) {
                _player1.move(Vector2(-movimentacao, 0));
              }
            }
            posicaoPlayer1 = dado1 + dado2;
            cobrasOuEscadas();
            msgAlerta('Jogador Azul está na casa $posicaoPlayer1');
            if (dado1 != dado2) {
              turno = 2;
              camera.followComponent(_player2);
            }
          } else {
            int casasAndadas = 0;
            if ((posicaoPlayer1 > 2 && posicaoPlayer1 <= 10) ||
                (posicaoPlayer1 > 20 && posicaoPlayer1 <= 30) ||
                (posicaoPlayer1 > 40 && posicaoPlayer1 <= 50) ||
                (posicaoPlayer1 > 60 && posicaoPlayer1 <= 70) ||
                (posicaoPlayer1 > 80 && posicaoPlayer1 <= 90)) {
              while ((posicaoPlayer1 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                _player1.move(Vector2(movimentacao, 0));
                casasAndadas++;
              }
              if (((posicaoPlayer1 + casasAndadas == 10)
                  || (posicaoPlayer1 + casasAndadas == 30)
                  || (posicaoPlayer1 + casasAndadas == 50)
                  || (posicaoPlayer1 + casasAndadas == 70)
                  || (posicaoPlayer1 + casasAndadas == 90))
                  && casasAndadas < dados) {
                _player1.move(Vector2(0, -movimentacao));
                casasAndadas++;
                if (casasAndadas < dados) {
                  while ((posicaoPlayer1 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                    _player1.move(Vector2(-movimentacao, 0));
                    casasAndadas++;
                  }
                  if (posicaoPlayer1 + casasAndadas == 100 && casasAndadas == dados) {
                    posicaoPlayer1 = 100;
                    msgAlerta('Jogador Azul Venceu!');
                    break;
                  } else if (posicaoPlayer1 + casasAndadas == 100 && casasAndadas < dados) {
                    while (casasAndadas < dados) {
                      _player1.move(Vector2(movimentacao, 0));
                      casasAndadas++;
                    }
                  } else if ((posicaoPlayer1 + casasAndadas) % 10 == 0 && casasAndadas < dados) {
                    _player1.move(Vector2(0, -movimentacao));
                    casasAndadas++;
                    if (casasAndadas < dados) {
                      _player1.move(Vector2(movimentacao, 0));
                    }
                  }
                }
              }
            } else if ((posicaoPlayer1 > 10 && posicaoPlayer1 <= 20) ||
                (posicaoPlayer1 > 30 && posicaoPlayer1 <= 40) ||
                (posicaoPlayer1 > 50 && posicaoPlayer1 <= 60) ||
                (posicaoPlayer1 > 70 && posicaoPlayer1 <= 80)) {
              while ((posicaoPlayer1 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                _player1.move(Vector2(-movimentacao, 0));
                casasAndadas++;
              }
              if (((posicaoPlayer1 + casasAndadas == 20)
                  || (posicaoPlayer1 + casasAndadas == 40)
                  || (posicaoPlayer1 + casasAndadas == 60)
                  || (posicaoPlayer1 + casasAndadas == 80))
                      && casasAndadas < dados) {
                _player1.move(Vector2(0, -movimentacao));
                casasAndadas++;
                if (casasAndadas < dados) {
                  while ((posicaoPlayer1 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                    _player1.move(Vector2(movimentacao, 0));
                    casasAndadas++;
                  }
                  if ((posicaoPlayer1 + casasAndadas) % 10 == 0 && casasAndadas < dados) {
                    _player1.move(Vector2(0, -movimentacao));
                    casasAndadas++;
                    if (casasAndadas < dados) {
                      _player1.move(Vector2(-movimentacao, 0));
                    }
                  }
                }
              }
            } else if (posicaoPlayer1 > 90) {
              while ((posicaoPlayer1 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                _player1.move(Vector2(-movimentacao, 0));
                casasAndadas++;
              }
              if (posicaoPlayer1 + casasAndadas == 100 && casasAndadas == dados) {
                posicaoPlayer1 = 100;
                msgAlerta('Jogador Azul Venceu!');
                break;
              } else if (casasAndadas < dados) {
                posicaoPlayer1 = 100 - (dados - casasAndadas);
                if (dados - casasAndadas == 10) {
                  _player1.move(Vector2(-movimentacao * 9, movimentacao));
                } else {
                  while (casasAndadas < dados) {
                    _player1.move(Vector2(movimentacao, 0));
                    casasAndadas++;
                  }
                }
                cobrasOuEscadas();
                msgAlerta('Jogador Azul está na casa $posicaoPlayer1');
                if (dado1 != dado2) {
                  turno = 2;
                  camera.followComponent(_player2);
                }
                break;
              }
            }
            posicaoPlayer1 += dado1 + dado2;
            cobrasOuEscadas();
            msgAlerta('Jogador Azul está na casa $posicaoPlayer1');
            if (dado1 != dado2) {
              turno = 2;
              camera.followComponent(_player2);
            }
          }
          break;
        case 2:
          if (inicio && dado1 == 1 && dado2 == 1) {
            _player2.move(Vector2(movimentacaoMin, 0));
            posicaoPlayer2 = 2;
            cobrasOuEscadas();
            msgAlerta('Jogador Vermelho está na casa $posicaoPlayer2');
            inicio = false;
          } else if (inicio) {
            if (dados <= 10) {
              _player2
                  .move(Vector2(movimentacaoMin + movimentacao * (dados - 2), 0));
            } else {
              _player2.move(Vector2(movimentacaoMin + movimentacao * (8), 0));
              _player2.move(Vector2(0, -movimentacao));
              if (dados == 12) {
                _player2.move(Vector2(-movimentacao, 0));
              }
            }
            posicaoPlayer2 = dado1 + dado2;
            cobrasOuEscadas();
            msgAlerta('Jogador Vermelho está na casa $posicaoPlayer2');
            if (dado1 != dado2) {
              turno = 1;
              camera.followComponent(_player1);
            }
            inicio = false;
          } else {
            int casasAndadas = 0;
            if ((posicaoPlayer2 > 2 && posicaoPlayer2 <= 10) ||
                (posicaoPlayer2 > 20 && posicaoPlayer2 <= 30) ||
                (posicaoPlayer2 > 40 && posicaoPlayer2 <= 50) ||
                (posicaoPlayer2 > 60 && posicaoPlayer2 <= 70) ||
                (posicaoPlayer2 > 80 && posicaoPlayer2 <= 90)) {
              while ((posicaoPlayer2 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                _player2.move(Vector2(movimentacao, 0));
                casasAndadas++;
              }
              if (((posicaoPlayer2 + casasAndadas == 10)
                  || (posicaoPlayer2 + casasAndadas == 30)
                  || (posicaoPlayer2 + casasAndadas == 50)
                  || (posicaoPlayer2 + casasAndadas == 70)
                  || (posicaoPlayer2 + casasAndadas == 90))
                      && casasAndadas < dados) {
                _player2.move(Vector2(0, -movimentacao));
                casasAndadas++;
                if (casasAndadas < dados) {
                  while ((posicaoPlayer2 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                    _player2.move(Vector2(-movimentacao, 0));
                    casasAndadas++;
                  }
                  if (posicaoPlayer2 + casasAndadas == 100 && casasAndadas == dados) {
                    posicaoPlayer2 = 100;
                    msgAlerta('Jogador Vermelho Venceu!');
                    break;
                  } else if (posicaoPlayer2 + casasAndadas == 100 && casasAndadas < dados) {
                    while (casasAndadas < dados) {
                      _player2.move(Vector2(movimentacao, 0));
                      casasAndadas++;
                    }
                  } else if ((posicaoPlayer2 + casasAndadas) % 10 == 0 && casasAndadas < dados) {
                    _player2.move(Vector2(0, -movimentacao));
                    casasAndadas++;
                    if (casasAndadas < dados) {
                      _player2.move(Vector2(movimentacao, 0));
                    }
                  }
                }
              }
            } else if ((posicaoPlayer2 > 10 && posicaoPlayer2 <= 20) ||
                (posicaoPlayer2 > 30 && posicaoPlayer2 <= 40) ||
                (posicaoPlayer2 > 50 && posicaoPlayer2 <= 60) ||
                (posicaoPlayer2 > 70 && posicaoPlayer2 <= 80)) {
              while ((posicaoPlayer2 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                _player2.move(Vector2(-movimentacao, 0));
                casasAndadas++;
              }
              if (((posicaoPlayer2 + casasAndadas == 20)
                  || (posicaoPlayer2 + casasAndadas == 40)
                  || (posicaoPlayer2 + casasAndadas == 60)
                  || (posicaoPlayer2 + casasAndadas == 80))
                      && casasAndadas < dados) {
                _player2.move(Vector2(0, -movimentacao));
                casasAndadas++;
                if (casasAndadas < dados) {
                  while ((posicaoPlayer2 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                    _player2.move(Vector2(movimentacao, 0));
                    casasAndadas++;
                  }
                  if ((posicaoPlayer2 + casasAndadas) % 10 == 0 && casasAndadas < dados) {
                    _player2.move(Vector2(0, -movimentacao));
                    casasAndadas++;
                    if (casasAndadas < dados) {
                      _player2.move(Vector2(-movimentacao, 0));
                    }
                  }
                }
              }
            } else if (posicaoPlayer2 > 90) {
              while ((posicaoPlayer2 + casasAndadas) % 10 != 0 && casasAndadas < dados) {
                _player2.move(Vector2(-movimentacao, 0));
                casasAndadas++;
              }
              if (posicaoPlayer2 + casasAndadas == 100 && casasAndadas == dados) {
                posicaoPlayer2 = 100;
                msgAlerta('Jogador Vermelho Venceu!');
                break;
              } else if (casasAndadas < dados) {
                posicaoPlayer2 = 100 - (dados - casasAndadas);
                if (dados - casasAndadas == 10) {
                  _player2.move(Vector2(-movimentacao * 9, movimentacao));
                } else {
                  while (casasAndadas < dados) {
                    _player2.move(Vector2(movimentacao, 0));
                    casasAndadas++;
                  }

                }
                cobrasOuEscadas();
                msgAlerta('Jogador Vermelho está na casa $posicaoPlayer2');
                if (dado1 != dado2) {
                  turno = 1;
                  camera.followComponent(_player1);
                }
                break;
              }
            }
            posicaoPlayer2 += dado1 + dado2;
            cobrasOuEscadas();
            msgAlerta('Jogador Vermelho está na casa $posicaoPlayer2');
            if (dado1 != dado2) {
              turno = 1;
              camera.followComponent(_player1);
            }
          }
          break;
      }
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    _world.add(_player1);
    _world.add(_player2);

    _player1.size = Vector2(_world.width * 0.02, _world.height * 0.04);
    _player1.position = Vector2(-15, _world.height - _player1.height - 4);
    _player2.size = Vector2(_world.width * 0.02, _world.height * 0.04);
    _player2.position = Vector2(-15, _world.height - _player2.height * 2 - 7);

    camera.followComponent(_player1);
  }

  void cobrasOuEscadas() {
    if (turno == 1) {
      switch (posicaoPlayer1) {
        case 2:
          msgAlerta('$escada 38.');
          _player1.move(Vector2(movimentacao, -movimentacao * 3));
          posicaoPlayer1 = 38;
          break;
        case 7:
          msgAlerta('$escada 14.');
          _player1.move(Vector2(0, -movimentacao));
          posicaoPlayer1 = 14;
          break;
        case 8:
          msgAlerta('$escada 31.');
          _player1.move(Vector2(movimentacao * 2, -movimentacao * 3));
          posicaoPlayer1 = 31;
          break;
        case 15:
          msgAlerta('$escada 26.');
          _player1.move(Vector2(0, -movimentacao));
          posicaoPlayer1 = 26;
          break;
        case 16:
          msgAlerta('$cobra 6.');
          _player1.move(Vector2(movimentacao, movimentacao));
          posicaoPlayer1 = 6;
          break;
        case 21:
          msgAlerta('$escada 42.');
          _player1.move(Vector2(movimentacao, -movimentacao * 2));
          posicaoPlayer1 = 42;
          break;
        case 28:
          msgAlerta('$escada 84.');
          _player1.move(Vector2(-movimentacao * 4, -movimentacao * 6));
          posicaoPlayer1 = 84;
          break;
        case 36:
          msgAlerta('$escada 44.');
          _player1.move(Vector2(-movimentacao, -movimentacao));
          posicaoPlayer1 = 44;
          break;
        case 46:
          msgAlerta('$cobra 25.');
          _player1.move(Vector2(-movimentacao, movimentacao * 2));
          posicaoPlayer1 = 25;
          break;
        case 49:
          msgAlerta('$cobra 11.');
          _player1.move(Vector2(movimentacao, movimentacao * 3));
          posicaoPlayer1 = 11;
          break;
        case 51:
          msgAlerta('$escada 67.');
          _player1.move(Vector2(-movimentacao * 3, -movimentacao));
          posicaoPlayer1 = 67;
          break;
        case 62:
          msgAlerta('$cobra 19.');
          _player1.move(Vector2(0, movimentacao * 5));
          posicaoPlayer1 = 19;
          break;
        case 64:
          msgAlerta('$cobra 60.');
          _player1.move(Vector2(-movimentacao * 3, movimentacao));
          posicaoPlayer1 = 60;
          break;
        case 71:
          msgAlerta('$escada 91.');
          _player1.move(Vector2(0, -movimentacao * 2));
          posicaoPlayer1 = 91;
          break;
        case 74:
          msgAlerta('$cobra 53.');
          _player1.move(Vector2(movimentacao, movimentacao * 2));
          posicaoPlayer1 = 53;
          break;
        case 78:
          msgAlerta('$escada 98.');
          _player1.move(Vector2(0, -movimentacao * 2));
          posicaoPlayer1 = 98;
          break;
        case 87:
          msgAlerta('$escada 94.');
          _player1.move(Vector2(0, -movimentacao));
          posicaoPlayer1 = 94;
          break;
        case 89:
          msgAlerta('$cobra 68.');
          _player1.move(Vector2(-movimentacao, movimentacao * 2));
          posicaoPlayer1 = 68;
          break;
        case 92:
          msgAlerta('$cobra 88.');
          _player1.move(Vector2(-movimentacao, movimentacao));
          posicaoPlayer1 = 88;
          break;
        case 95:
          msgAlerta('$cobra 75.');
          _player1.move(Vector2(0, movimentacao * 2));
          posicaoPlayer1 = 75;
          break;
        case 99:
          msgAlerta('$cobra 80.');
          _player1.move(Vector2(-movimentacao, movimentacao * 2));
          posicaoPlayer1 = 80;
          break;
      }
    } else {
      switch (posicaoPlayer2) {
        case 2:
          msgAlerta('$escada 38.');
          _player2.move(Vector2(movimentacao, -movimentacao * 3));
          posicaoPlayer2 = 38;
          break;
        case 7:
          msgAlerta('$escada 14.');
          _player2.move(Vector2(0, -movimentacao));
          posicaoPlayer2 = 14;
          break;
        case 8:
          msgAlerta('$escada 31.');
          _player2.move(Vector2(movimentacao * 2, -movimentacao * 3));
          posicaoPlayer2 = 31;
          break;
        case 15:
          msgAlerta('$escada 26.');
          _player2.move(Vector2(0, -movimentacao));
          posicaoPlayer2 = 26;
          break;
        case 16:
          msgAlerta('$cobra 6.');
          _player2.move(Vector2(movimentacao, movimentacao));
          posicaoPlayer2 = 6;
          break;
        case 21:
          msgAlerta('$escada 42.');
          _player2.move(Vector2(movimentacao, -movimentacao * 2));
          posicaoPlayer2 = 42;
          break;
        case 28:
          msgAlerta('$escada 84.');
          _player2.move(Vector2(-movimentacao * 4, -movimentacao * 6));
          posicaoPlayer2 = 84;
          break;
        case 36:
          msgAlerta('$escada 44.');
          _player2.move(Vector2(-movimentacao, -movimentacao));
          posicaoPlayer2 = 44;
          break;
        case 46:
          msgAlerta('$cobra 25.');
          _player2.move(Vector2(-movimentacao, movimentacao * 2));
          posicaoPlayer2 = 25;
          break;
        case 49:
          msgAlerta('$cobra 11.');
          _player2.move(Vector2(movimentacao, movimentacao * 3));
          posicaoPlayer2 = 11;
          break;
        case 51:
          msgAlerta('$escada 67.');
          _player2.move(Vector2(-movimentacao * 3, -movimentacao));
          posicaoPlayer2 = 67;
          break;
        case 62:
          msgAlerta('$cobra 19.');
          _player2.move(Vector2(0, movimentacao * 5));
          posicaoPlayer2 = 19;
          break;
        case 64:
          msgAlerta('$cobra 60.');
          _player2.move(Vector2(-movimentacao * 3, movimentacao));
          posicaoPlayer2 = 60;
          break;
        case 71:
          msgAlerta('$escada 91.');
          _player2.move(Vector2(0, -movimentacao * 2));
          posicaoPlayer2 = 91;
          break;
        case 74:
          msgAlerta('$cobra 53.');
          _player2.move(Vector2(movimentacao, movimentacao * 2));
          posicaoPlayer2 = 53;
          break;
        case 78:
          msgAlerta('$escada 98.');
          _player2.move(Vector2(0, -movimentacao * 2));
          posicaoPlayer2 = 98;
          break;
        case 87:
          msgAlerta('$escada 94.');
          _player2.move(Vector2(0, -movimentacao));
          posicaoPlayer2 = 94;
          break;
        case 89:
          msgAlerta('$cobra 68.');
          _player2.move(Vector2(-movimentacao, movimentacao * 2));
          posicaoPlayer2 = 68;
          break;
        case 92:
          msgAlerta('$cobra 88.');
          _player2.move(Vector2(-movimentacao, movimentacao));
          posicaoPlayer2 = 88;
          break;
        case 95:
          msgAlerta('$cobra 75.');
          _player2.move(Vector2(0, movimentacao * 2));
          posicaoPlayer2 = 75;
          break;
        case 99:
          msgAlerta('$cobra 80.');
          _player2.move(Vector2(-movimentacao, movimentacao * 2));
          posicaoPlayer2 = 80;
          break;
      }
    }
  }

  void msgAlerta(String msg) {
    showGeneralDialog(
      barrierColor: Colors.white.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: const Text('Cobras & Escadas'),
              content: Text(msg),
              titleTextStyle: const TextStyle(color: Colors.lightBlue),
              contentTextStyle: const TextStyle(color: Colors.lightBlue),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
      barrierDismissible: true,
      barrierLabel: '',
      context: buildContext!,
      pageBuilder: (context, a1, a2) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: const Text('Cobras & Escadas'),
              content: Text(msg),
              titleTextStyle: const TextStyle(color: Colors.lightBlue),
              contentTextStyle: const TextStyle(color: Colors.lightBlue),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
