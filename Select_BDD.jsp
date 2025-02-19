<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

 

<html>

<head>

    <meta charset="UTF-8">

    <title>Connexion à MariaDB via JSP</title>

</head>

<body>

    <h1>Exemple de connexion à MariaDB via JSP</h1>

 

    <!-- Formulaire pour saisir l'année -->

    <form method="get" action="">

        <label for="annee">Choisir une année :</label>

        <input type="number" id="annee" name="annee" min="1900" max="2100">

        <input type="submit" value="Rechercher">

    </form>

 

    <%

        try {

            String url = "jdbc:mariadb://localhost:3306/films";

            String user = "mysql";

            String password = "mysql";

 

            // Vérification de la présence de l'année dans la requête

            if (request.getParameter("annee") != null) {

                int anneeRecherchee = Integer.parseInt(request.getParameter("annee"));

 

                // Établir la connexion

                try (Connection conn = DriverManager.getConnection(url, user, password)) {

                    // Requête SQL pour récupérer les films de l'année saisie

                    String sql = "SELECT idFilm, titre, année FROM Film WHERE année = ?";

                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

                        pstmt.setInt(1, anneeRecherchee); // Utilisation de l'année saisie

                        try (ResultSet rs = pstmt.executeQuery()) {

 

                            // Affichage de tous les films de l'année saisie

                            while (rs.next()) {

                                String colonne1 = rs.getString("idFilm");

                                String colonne2 = rs.getString("titre");

                                String colonne3 = rs.getString("année");

                %>

                                <!-- Affichage de chaque film correspondant à l'année saisie -->

                                <p>ID : <%= colonne1 %>, Titre : <%= colonne2 %>, Année : <%= colonne3 %></p>

                <%

                            }

                        }

                    }

                }

            } else {

                // Si aucune année n'est spécifiée, afficher tous les films

                try (Connection conn = DriverManager.getConnection(url, user, password)) {

                    // Requête SQL pour récupérer tous les films

                    String sql = "SELECT idFilm, titre, année FROM Film";

                    try (PreparedStatement pstmt = conn.prepareStatement(sql);

                         ResultSet rs = pstmt.executeQuery()) {

 

                        // Affichage de tous les films

                        while (rs.next()) {

                            String colonne1 = rs.getString("idFilm");

                            String colonne2 = rs.getString("titre");

                            String colonne3 = rs.getString("année");

                %>

                            <!-- Affichage de chaque film -->

                            <p>ID : <%= colonne1 %>, Titre : <%= colonne2 %>, Année : <%= colonne3 %></p>

                <%

                        }

                    }

                }

            }

        } catch (Exception e) {

            // Gérer les exceptions (journalisation, affichage d'un message d'erreur, etc.)

            e.printStackTrace();

            out.println("Erreur : " + e.getMessage());

        }

    %>

</body>

</html>
