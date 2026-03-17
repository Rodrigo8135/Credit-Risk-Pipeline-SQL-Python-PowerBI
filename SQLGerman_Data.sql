USE PruebaCSV; -- Ejecuta esto primero solo una vez

--Transformación de Categorías y Limpieza

--Analizando la tabla:
SELECT *
FROM german_credit_data

-- Si la vista ya existe y se busca recrearla, usa: OR ALTER
ALTER  VIEW vista_credito_limpia AS
SELECT 
    [Age] AS edad,
    [Sex] AS sexo,
    CASE 
        WHEN [Job] = 0 THEN 'No cualificado/No residente'
        WHEN [Job] = 1 THEN 'No cualificado/Residente'
        WHEN [Job] = 2 THEN 'Cualificado'
        WHEN [Job] = 3 THEN 'Altamente cualificado'
        ELSE 'Desconocido'
    END AS tipo_trabajo,
    [Housing] AS vivienda,
    -- CAMBIO AQUÍ: Si dice 'NA', lo convertimos en 'Sin cuenta'
    CASE 
        WHEN [Saving accounts] = 'NA' OR [Saving accounts] IS NULL THEN 'Sin cuenta'
        ELSE [Saving accounts] 
    END AS ahorros,
    CASE 
        WHEN [Checking account] = 'NA' OR [Checking account] IS NULL THEN 'Sin cuenta'
        ELSE [Checking account] 
    END AS cuenta_corriente,
    [Credit amount] AS monto_credito,
    [Duration] AS duracion_meses,
    [Purpose] AS proposito
FROM german_credit_data;


SELECT * FROM vista_credito_limpia

--Segmentación por Rango de Edad (Insights)
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Joven (18-24)'
        WHEN Age BETWEEN 25 AND 40 THEN 'Adulto Joven (25-40)'
        WHEN Age BETWEEN 41 AND 60 THEN 'Adulto (41-60)'
        ELSE 'Senior (60+)'
    END AS rango_etario,
    COUNT(*) AS total_clientes,
    -- Usamos CAST para convertir el texto en número flotante
    ROUND(AVG(CAST([Credit amount] AS FLOAT)), 2) AS promedio_credito
FROM dbo.german_credit_data
GROUP BY 
    CASE 
        WHEN Age < 25 THEN 'Joven (18-24)'
        WHEN Age BETWEEN 25 AND 40 THEN 'Adulto Joven (25-40)'
        WHEN Age BETWEEN 41 AND 60 THEN 'Adulto (41-60)'
        ELSE 'Senior (60+)'
    END
ORDER BY promedio_credito DESC;
--Los Adultos (41-60) son el grupo con el promedio de crédito más alto ($434.31), 
--pero el volumen más grande de clientes está en los Adultos Jóvenes (25-40) con 577 personas.

--Query para Power BI / Python
-- 1. CREAR LA VISTA MAESTRA (Esta es la que se usará Power BI y Python)
ALTER VIEW vista_analisis_riesgo AS
SELECT 
    *,
    CASE 
        WHEN monto_credito > 5000 AND duracion_meses > 24 THEN 'Riesgo Alto'
        WHEN monto_credito > 3000 AND duracion_meses > 12 THEN 'Riesgo Medio'
        ELSE 'Riesgo Bajo'
    END AS categoria_riesgo
FROM vista_credito_limpia;
GO

-- Mostrando resultados:
SELECT * FROM vista_analisis_riesgo;


