# Análisis de Riesgo Crediticio — Banco Alemán

> Proyecto end-to-end de análisis de riesgo crediticio sobre 1.000 clientes reales,
> cubriendo desde la limpieza de datos en SQL hasta un modelo predictivo en Python.

---

## Descripción

Este proyecto simula el flujo de trabajo completo de un analista de datos en el sector financiero:
limpieza y transformación en SQL Server, visualización ejecutiva en Power BI y análisis
estadístico + modelo de Machine Learning en Python.

El dataset utilizado es el **German Credit Dataset**, un conjunto de datos clásico en la
industria financiera para evaluar la solvencia de solicitantes de crédito.

---

## Stack Tecnológico

| Herramienta | Uso |
|---|---|
| **SQL Server** | ETL, limpieza de datos, creación de vistas |
| **Power BI** | Dashboard interactivo de monitoreo de riesgo |
| **Python** | Análisis exploratorio (EDA) + modelo predictivo |

**Librerías Python:** `pandas`, `matplotlib`, `seaborn`, `scikit-learn`, `pyodbc`

---

## Arquitectura del Proyecto

```
credit-risk-analysis-german-bank/
│
├── sql/
│   ├── vista_credito_limpia.sql       → Limpieza y normalización de columnas
│   └── vista_analisis_riesgo.sql      → Vista maestra con categorización de riesgo
│
├── python/
│   └── analisis_riesgo_ml.py          → EDA completo + modelo Random Forest
│
├── powerbi/
│   └── dashboard_riesgo.pbix          → Dashboard interactivo
│
└── README.md
```

---

## Flujo de Datos

```
CSV (German Credit Dataset)
        ↓
SQL Server — Limpieza + Vistas (ETL)
        ↓
Power BI ←——— Vista maestra ———→ Python
(Dashboard)                    (EDA + ML)
```

---

## Transformaciones en SQL

Se construyeron dos vistas principales:

**`vista_credito_limpia`** — Normalización de datos:
- Traducción de códigos numéricos de `Job` a etiquetas legibles (Cualificado, Altamente cualificado, etc.)
- Reemplazo de valores `'NA'` y `NULL` en cuentas de ahorro y corriente por `'Sin cuenta'`
- Renombramiento de columnas al español para mejor legibilidad

**`vista_analisis_riesgo`** — Segmentación de riesgo:
- **Riesgo Alto:** monto > $5.000 y duración > 24 meses
- **Riesgo Medio:** monto > $3.000 y duración > 12 meses
- **Riesgo Bajo:** resto de casos

---

## Dashboard Power BI
![Dashboard Principal](screenshots/dashboard_principal.png)
![Exposición Financiera](screenshots/exposicion_financiera.png)
El dashboard incluye:
- **KPIs ejecutivos:** Total clientes (690), Capital expuesto ($2.38M), Ticket promedio ($3.45K)
- **Distribución de riesgo:** 64.78% Bajo · 21.45% Medio · 13.77% Alto
- **Treemap:** Exposición financiera por propósito del préstamo
- **Barras apiladas:** Exposición por tipo de trabajo
- **Filtro interactivo** por género

---

## Modelo Predictivo (Python)

Se entrenó un clasificador **Random Forest** para predecir la categoría de riesgo
de nuevos clientes.

**Features utilizadas:**
- Edad
- Monto del crédito
- Duración en meses
- Tipo de trabajo

**Pipeline:**
1. Limpieza y validación sobre `df_limpio`
2. Encoding de variables categóricas (encoder por columna)
3. Split estratificado 80/20 con `random_state=42`
4. Entrenamiento con `RandomForestClassifier(n_estimators=100)`
5. Evaluación con accuracy, classification report y matriz de confusión

---

## Hallazgos Clave

- Los clientes **Adultos (41–60 años)** tienen el promedio de crédito más alto ($4.341)
- El segmento **Adulto Joven (25–40)** concentra el mayor volumen (577 clientes)
- Los préstamos para **autos** representan la mayor exposición financiera en todas las categorías de riesgo
- Los trabajadores **Cualificados** acumulan la mayor exposición total ($1.5M+)

---

## Cómo ejecutar

### Requisitos
```bash
pip install pandas matplotlib seaborn scikit-learn pyodbc
```

### Pasos
1. Restaurar la base de datos en SQL Server y ejecutar los scripts de `/sql`
2. Conectar Power BI al servidor local apuntando a `vista_analisis_riesgo`
3. Ejecutar `python/analisis_riesgo_ml.py` celda por celda en VS Code o Jupyter

> Ajusta el nombre del servidor en la variable `server` del script Python
> según tu configuración local.

---

## 👤 Autor

**[Rodrigo Quiroz Iparraguirre]**
[LinkedIn](https://www.linkedin.com/in/rodrigo-ismael-quiroz-iparraguirre-129344345/) · 

---

*Proyecto desarrollado como parte del portafolio de Data Analytics.*
