class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def presentacion(self):
        return "Hola, mi nombre es " + self.nombre + " y tengo " + str(self.edad) + " años."

class Estudiante(Persona):
    def __init__(self, nombre, edad, grado):
        super().__init__(nombre, edad)
        self.grado = grado

    def presentacion(self):
        return super().presentacion() + " Estoy en el grado " + self.grado + "."

def main():
    estudiante = Estudiante("Juan", 20, "tercero")
    print(estudiante.presentacion())

if __name__ == "__main__":
    main()
