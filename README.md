Desde Main, se corren cargan los datos del sistema (puedes adaptar cualquier sistema, este es generado en formato matpower). Posteriormente, se utilizan los datos del sistema PJM 2016 para obtener patrones de comportamiento de la carga, los cuales a traves de Cluster Kmeans genera los escenarios
Puedes adaptar tus propios patrones de demanda solo debes de generar una matriz de datos del tipo [Dias,Horas], una vez generados los escenarios corres El modelo de expansión y obtienes los resultados generadores para los escenarios obtenidos 