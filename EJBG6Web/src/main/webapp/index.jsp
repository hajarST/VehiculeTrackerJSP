<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Vehicules et Traceurs</title>
    
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Add Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    
    
    <!-- Custom Styles -->
    <style>
        body {
            background: linear-gradient(to right, #192a56, #273c75);
            color: #fff;
        }

        .container {
            text-align: center;
            margin-top: 50px;
        }
        
        

        .btn {
            margin-bottom: 10px;
        }

        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 class="display-4 mb-4">
            <i class="fas fa-car"></i> Gestion des Véhicules et Traceurs
        </h1>
        <form action="VehiculeController" class="mb-4">
            <button class="btn btn-primary btn-block">Gestion des véhicules</button>
        </form>
        
        <form action="TraceurController" class="mb-4">
            <button class="btn btn-success btn-block">Gestion des traceurs</button>
        </form>
        
        <form action="AffectationTraceurVehiculeController" class="mb-4">
            <button class="btn btn-danger btn-block">Affectation Traceurs aux véhicules</button>
        </form>
    </div>

    <!-- Add Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
