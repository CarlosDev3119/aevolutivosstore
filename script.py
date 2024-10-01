import pandas as pd
from sqlalchemy import create_engine
import numpy as np
import random
import matplotlib.pyplot as plt
from deap import base, creator, tools, algorithms
from sklearn.metrics import mean_squared_error
from datetime import datetime

# # Configurar la conexión a la base de datos (en este ejemplo SQLite, puedes cambiar por PostgreSQL u otra)
# DATABASE_URI = 'sqlite:///ventas.db'  # Cambiar por la URI de tu base de datos
# engine = create_engine(DATABASE_URI)

# # Función para cargar datos desde la BD
# def cargar_datos():
#     query = '''
#     SELECT envase, sabor, marca, precio, tamaño, cantidad_vendida, fecha_venta, fecha_ingreso
#     FROM ventas;
#     '''
#     df = pd.read_sql(query, engine)
#     return df

# Función para calcular días en inventario
def calcular_dias_inventario(df):
    df['fecha_venta'] = pd.to_datetime(df['fecha_venta'])
    df['fecha_ingreso'] = pd.to_datetime(df['fecha_ingreso'])
    df['dias_en_inventario'] = (df['fecha_venta'] - df['fecha_ingreso']).dt.days
    return df

# Función para codificar las categorías a números
def codificar_categorias(df):
    df['envase_num'], envase_labels = pd.factorize(df['envase'])
    df['sabor_num'], sabor_labels = pd.factorize(df['sabor'])
    df['marca_num'], marca_labels = pd.factorize(df['marca'])
    return df, envase_labels, sabor_labels, marca_labels

# Algoritmo evolutivo - Configuración
creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

toolbox = base.Toolbox()
toolbox.register("attr_float", random.random)
toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.attr_float, n=6)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

# Función de evaluación basada en comparación con datos reales
def evaluar_individuo(individuo):
    prediccion_precio = individuo[0] * 20  # Predicción de precio
    prediccion_tamaño = individuo[1] * 2000  # Predicción de tamaño (ml)
    prediccion_envase = int(individuo[2] * 2)  # Predicción de tipo de envase
    prediccion_sabor = int(individuo[3] * 2)   # Predicción de sabor
    prediccion_marca = int(individuo[4] * 1)   # Predicción de marca
    prediccion_dias_inventario = individuo[5] * 365  # Predicción de días en inventario

    # Filtrar el DataFrame real con los datos que coinciden con la predicción del individuo
    datos_filtrados = df[
        (df['envase_num'] == prediccion_envase) &
        (df['sabor_num'] == prediccion_sabor) &
        (df['marca_num'] == prediccion_marca) &
        (df['precio'] <= prediccion_precio + 1) & (df['precio'] >= prediccion_precio - 1) &
        (df['tamaño'] <= prediccion_tamaño + 50) & (df['tamaño'] >= prediccion_tamaño - 50) &
        (df['dias_en_inventario'] <= prediccion_dias_inventario + 10) &
        (df['dias_en_inventario'] >= prediccion_dias_inventario - 10)
    ]

    # Si hay datos filtrados, usar la cantidad vendida promedio como comparación
    if len(datos_filtrados) > 0:
        cantidad_real_promedio = datos_filtrados['cantidad_vendida'].mean()
    else:
        cantidad_real_promedio = 0  # No hay datos similares, penalizar al individuo

    # El fitness es el error entre la predicción y la cantidad vendida real
    cantidad_predicha = 100 - abs(prediccion_precio - 10) - abs(prediccion_tamaño - 500)
    error = mean_squared_error([cantidad_real_promedio], [cantidad_predicha])
    return (1 / (1 + error),)  # Invertimos el error para maximizar la aptitud

toolbox.register("evaluate", evaluar_individuo)
toolbox.register("mate", tools.cxBlend, alpha=0.5)
toolbox.register("mutate", tools.mutGaussian, mu=0, sigma=1, indpb=0.2)
toolbox.register("select", tools.selTournament, tournsize=3)

# Función para ejecutar el algoritmo evolutivo
def algoritmo_evolutivo(pop_size=50, ngen=20, cxpb=0.5, mutpb=0.2):
    population = toolbox.population(n=pop_size)
    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", np.mean)
    stats.register("min", np.min)
    stats.register("max", np.max)

    pop, logbook = algorithms.eaSimple(population, toolbox, cxpb=cxpb, mutpb=mutpb, ngen=ngen,
                                       stats=stats, verbose=True)
    return pop, logbook

# Visualización de resultados
def graficar_resultados(logbook):
    gen = logbook.select("gen")
    max_fitness = logbook.select("max")
    avg_fitness = logbook.select("avg")

    plt.plot(gen, max_fitness, label="Max Fitness")
    plt.plot(gen, avg_fitness, label="Avg Fitness")
    plt.xlabel("Generation")
    plt.ylabel("Fitness")
    plt.title("Evolución del Fitness")
    plt.legend()
    plt.show()

def graficar_datos_iniciales(df):
    # Graficar días en inventario vs cantidad vendida
    plt.figure(figsize=(12, 6))
    plt.scatter(df['dias_en_inventario'], df['cantidad_vendida'], c='blue', alpha=0.5)
    plt.title('Días en Inventario vs Cantidad Vendida')
    plt.xlabel('Días en Inventario')
    plt.ylabel('Cantidad Vendida')
    plt.grid(True)
    plt.show()

    # Graficar precio vs cantidad vendida
    plt.figure(figsize=(12, 6))
    plt.scatter(df['precio'], df['cantidad_vendida'], c='green', alpha=0.5)
    plt.title('Precio vs Cantidad Vendida')
    plt.xlabel('Precio')
    plt.ylabel('Cantidad Vendida')
    plt.grid(True)
    plt.show()

    # Graficar tamaño vs cantidad vendida
    plt.figure(figsize=(12, 6))
    plt.scatter(df['tamaño'], df['cantidad_vendida'], c='red', alpha=0.5)
    plt.title('Tamaño vs Cantidad Vendida')
    plt.xlabel('Tamaño (ml)')
    plt.ylabel('Cantidad Vendida')
    plt.grid(True)
    plt.show()

# Función principal para ejecutar todo el flujo
def main():
    # Cargar y procesar los datos desde la BD
    df = cargar_datos()

    # Calcular días en inventario
    df = calcular_dias_inventario(df)

    # Codificar los datos categóricos
    df, envase_labels, sabor_labels, marca_labels = codificar_categorias(df)

    print("Datos procesados:")
    print(df.head())

    # Graficar los datos iniciales
    graficar_datos_iniciales(df)

    # Ejecutar el algoritmo evolutivo
    pop, logbook = algoritmo_evolutivo(pop_size=100, ngen=50)

    # Graficar los resultados
    graficar_resultados(logbook)

    # Ejemplo de conversión de numérico a cadena (reversión)
    envase, sabor, marca = convertir_a_cadena(1, 0, 1, envase_labels, sabor_labels, marca_labels)
    print(f"\nEjemplo de conversión: Envase: {envase}, Sabor: {sabor}, Marca: {marca}")


# Función para convertir de nuevo de números a cadenas
def convertir_a_cadena(envase_num, sabor_num, marca_num, envase_labels, sabor_labels, marca_labels):
    """
    Convierte los valores numéricos de vuelta a sus valores originales de cadena.
    """
    envase_original = envase_labels[envase_num]
    sabor_original = sabor_labels[sabor_num]
    marca_original = marca_labels[marca_num]

    return envase_original, sabor_original, marca_original

if name == "main":
  main()