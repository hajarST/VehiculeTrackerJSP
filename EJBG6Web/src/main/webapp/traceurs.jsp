<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<meta charset="ISO-8859-1">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Traceurs</title>

    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Add SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.min.css">
    

    <!-- Custom Styles -->
    <style>
        body {
            background: linear-gradient(to right, #ffffff, #ffffff);
    color: #000; 
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

 
 
    <h1 class="display-4 mb-4">Liste des Traceurs</h1>
    
 <div>
 		
            <a href="/EJBG6Web/index.jsp" class="col-md-6  btn btn-warning">HOME</a>
      
    <!-- Add button to show modal for adding a vehicle -->
    
    	
           <button class="col-md-6  btn btn-primary mb-3" data-toggle="modal" data-target="#addTrackerModal">Ajouter un traceur</button>

</div>
    
    <!-- Table to display vehicles -->
    <table class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>Numéro SIM</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="tracker" items="${traceurs}">
            <tr>
                <td>${tracker.simNumber}</td>
                <td>
                    <!-- Add button to show modal for editing a vehicle -->
                    <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#editTrackerModal${tracker.id}">Modifier</button>

                    <!-- Add button to show modal for deleting a vehicle -->
                    <button class="btn btn-danger btn-sm" onclick="confirmDelete(${tracker.id})">Supprimer</button>
               </td>
            </tr>

            <!-- Modals for editing and deleting vehicles -->
           <div class="modal fade" id="editTrackerModal${tracker.id}" tabindex="-1" role="dialog" aria-labelledby="editTrackerModalLabel" aria-hidden="true">
        <!-- Add your edit vehicle modal content here -->
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editTrackerModalLabel">Modifier le traceur</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Form for editing a tracker -->
                    <form action="TraceurController" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${tracker.id}">
                        <div class="form-group">
                            <label for="editSimNumber">Numéro SIM:</label>
                            <input type="text" class="form-control" id="editSimNumber" name="simNumber" value="${tracker.simNumber}">
                        </div>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                        <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

            
        </c:forEach>
        </tbody>
    </table>
</div>


<!-- Modal for adding a tracker -->
<div class="modal fade" id="addTrackerModal" tabindex="-1" role="dialog" aria-labelledby="addTrackerModalLabel" aria-hidden="true">
    <!-- Add your add vehicle modal content here -->
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addTrackerModalLabel">Ajouter un traceur</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Form for adding a vehicle -->
                <form action="TraceurController" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="form-group">
                        <label for="addsimNumber">Numéro SIM:</label>
                        <input type="text" class="form-control" id="addsimNumber" name="simNumber">
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Add JQuery JS -->
 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<!-- Add Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.15.5/dist/sweetalert2.all.min.js"></script>

<script>
    function confirmDelete(trackerId) {
        Swal.fire({
            title: 'Confirmation',
            text: 'Êtes-vous sûr de vouloir supprimer ce traceur?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Oui, supprimer!',
            cancelButtonText: 'Annuler'
        }).then((result) => {
            if (result.isConfirmed) {
                // User clicked "OK," proceed with deletion
                window.location.href = "TraceurController?action=delete&id=" + trackerId;
            }
            // If canceled or closed, do nothing
        });
    }
</script>

</body>
</html>
