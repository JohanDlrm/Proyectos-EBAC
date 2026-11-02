# Análisis de Riesgo Automotriz en México

Proyecto final desarrollado como parte del programa de **Data Analysis de EBAC**.

## Objetivo

Analizar la incidencia delictiva relacionada con automóviles en México para identificar patrones territoriales y temporales que puedan utilizarse como una señal complementaria en decisiones de **pricing de seguros de automóvil**.

El análisis considera principalmente:

- Robo de automóvil con violencia.
- Robo de automóvil sin violencia.
- Robo de autopartes.

## Fuente de datos

Los datos provienen del **Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública (SESNSP)**, utilizando la base de Incidencia Delictiva Municipal.

La base original contiene:

- 2,562,994 registros.
- 21 variables.
- 32 entidades federativas.
- Cobertura 2015–2025.

> El archivo CSV original no se incluye en este repositorio debido a su tamaño.

## Metodología

El proyecto se desarrolló principalmente en Python y comprende:

1. Carga y validación de datos.
2. Exploración del catálogo de delitos.
3. Selección de delitos relacionados con riesgo automotriz.
4. Limpieza y transformación a formato longitudinal.
5. Análisis exploratorio temporal y territorial.
6. Identificación de municipios con mayor incidencia.
7. Modelado de serie temporal para Ecatepec de Morelos.
8. Evaluación de estacionariedad mediante ADF.
9. Comparación de modelos ARIMA y SARIMA.
10. Validación del pronóstico utilizando 2022 como periodo de prueba.
11. Segmentación de entidades mediante K-Means.
12. Integración entre Python y SQL Server.
13. Preparación de información para visualización en Looker Studio.

## Principales resultados

### Serie temporal

Para Ecatepec de Morelos se utilizó información de 2015–2021 para entrenamiento y 2022 como periodo de validación.

El modelo con mejor desempeño fue:

**SARIMA (1,1,1) × (0,1,1,12)**

Resultados sobre 2022:

- MAE: 61.43
- RMSE: 74.06
- MAPE: 18.80%

### Segmentación territorial

Se aplicó **K-Means** sobre información estatal de 2021.

La solución final utiliza tres perfiles, permitiendo identificar:

- Un perfil general conformado por 30 entidades.
- Estado de México con alta incidencia de robo vehicular.
- Ciudad de México con alta incidencia de robo de autopartes.

Los clusters representan **perfiles estadísticos y no una clasificación automática de riesgo bajo, medio o alto**.

## SQL Server

Como parte de la arquitectura del proyecto, la base original fue incorporada a SQL Server mediante Python.

La carga fue realizada por bloques utilizando `pyodbc`, validándose:

**2,562,994 registros cargados correctamente.**

Esto permite mantener una fuente estructurada y reutilizable para consultas y análisis posteriores.

## Dashboard

Los resultados fueron complementados mediante un dashboard interactivo desarrollado en **Looker Studio**, que permite analizar tendencias históricas, concentración municipal y perfiles estatales.

## Tecnologías utilizadas

- Python
- pandas
- NumPy
- Matplotlib
- statsmodels
- scikit-learn
- SQL Server
- pyodbc
- Looker Studio
- Jupyter Notebook

## Aplicación en pricing

Los resultados sugieren que la incidencia delictiva puede utilizarse como una **señal territorial complementaria** para apoyar:

- Segmentación geográfica.
- Monitoreo de cambios en riesgo.
- Evaluación de coberturas.
- Estrategias de prevención.
- Análisis de pricing y suscripción.

La incidencia pública no debe utilizarse de forma aislada para determinar una tarifa. Para un modelo actuarial o de pricing completo sería necesario incorporar exposición asegurada, frecuencia y severidad de siniestros, características del vehículo y experiencia propia de cartera.

## Código

El análisis completo se encuentra en:

**`Proyecto_Final_JSDLRM_V2.ipynb`**

**Autor:** Johan Samuel De la Rosa Montiel  
**Proyecto final · Data Analysis · EBAC**
