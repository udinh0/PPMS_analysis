
# Projeto Física

Este projeto tem como objetivo realizar uma análise de dados para uma
máquina de PPMS eletromagnética. As principais funções incluem a geração
de curvas de histerese, a extração de valores de “Drive” quando “Signal”
está próximo de zero, e a criação de histogramas para “Drive” positivo e
negativo.

## Configuração

O arquivo config.yaml é utilizado para especificar a amostra de dados no
formato .raw e definir as variáveis de interesse. O formato do arquivo é
o seguinte:

``` yaml
data: dado_de_interesse
variables:
    signal: Signal (mV)
    drive: Drive (Oe)
    frequency: Frequency (Hz)
    bin: Bin
    histereses: TRUE
```

- data: Nome do arquivo de dados bruto (.raw) que será analisado.

- signal: Nome da variável que representa o sinal em milivolts (mV).

- drive: Nome da variável que representa o drive em oersteds (Oe).

- frequency: Nome da variável que representa a frequência em hertz (Hz).

- bin: Tamanho de cada ciclo dentro da amostra.

- images: Se definido como TRUE, as curvas de histerese serão geradas
  automaticamente pelo código.

## Importante

Certifique-se de ajustar os valores de signal, drive, frequency e bin de
acordo com as especificações da sua amostra. O parâmetro bin é
especialmente importante, pois define o tamanho de cada ciclo dentro da
amostra, influenciando diretamente a análise.
