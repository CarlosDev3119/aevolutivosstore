# src/config/db.py
import psycopg2
from psycopg2 import OperationalError

import pandas as pd

def createConnectionDB():
    try:
        conexion = psycopg2.connect(
            host="localhost",
            database="storeDB",
            user="dinamita",
            password="123123",
            port="5435"
        )
        print("Conexión exitosa a la base de datos")
        return conexion
    except OperationalError as error:
        print(f"Error al conectar a la base de datos: {error}")
        return None


  # Función para cargar datos desde la BD
def cargar_datos():
    # Crear la conexión a la base de datos
    conexion = createConnectionDB()

    if conexion:
        try:
            # Realizar operaciones con la base de datos
            cursor = conexion.cursor()
            cursor.execute("SELECT * FROM view_sales")
            
            # Obtener los nombres de las columnas
            columnas = [desc[0] for desc in cursor.description]
            
            # Obtener los resultados de la consulta
            resultados = cursor.fetchall()
            
            # Convertir los resultados en una lista de diccionarios
            datos = [dict(zip(columnas, fila)) for fila in resultados]

            # Convertir los datos en un DataFrame de pandas
            df = pd.DataFrame(datos)
            
            return df

        except Exception as e:
            print(f"Error al realizar operaciones en la base de datos: {e}")
            return None

        finally:
            # Cerrar el cursor y la conexión
            cursor.close()
            conexion.close()
            print("Conexión cerrada")
