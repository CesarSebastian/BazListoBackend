package org.pedidos.deleteFile;

import java.io.File;

public class deleteFile {

    public static void main(String[] args) {

        // Ruta de la carpeta que contiene los archivos y carpetas a eliminar
        String folderPath = "target/";

        // Crea un objeto File para la carpeta
        File folder = new File(folderPath);

        // Elimina todos los archivos en la carpeta
        deleteFiles(folder);

        // Elimina la carpeta vacía
        folder.delete();

        System.out.println("Carpeta eliminada: " + folderPath);
    }

    public static void deleteFiles(File folder) {

        // Obtiene una lista de todos los archivos y carpetas en la carpeta
        File[] files = folder.listFiles();

        // Itera sobre los archivos y carpetas y elimina cada uno
        for (File file : files) {
            if (file.isFile()) {
                // Si es un archivo, elimina el archivo
                file.delete();
            } else {
                // Si es una carpeta, elimina los archivos en la carpeta y luego la carpeta en sí misma
                deleteFiles(file);
                file.delete();
            }
        }
    }
}
