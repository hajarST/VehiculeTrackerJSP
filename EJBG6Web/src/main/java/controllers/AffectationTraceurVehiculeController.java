package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.TrackerFacade;
import sessions.VehiculeFacade;
import sessions.VehiculetrackerFacade;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import entities.Vehiculetracker;
import entities.VehiculetrackerPK;

/**
 * Servlet implementation class AffectationTraceurVehiculeController
 */
public class AffectationTraceurVehiculeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
    private VehiculetrackerFacade vehiculetrackerFacade; 
	@EJB
	private VehiculeFacade  vehiculeFacade;
	@EJB
	private TrackerFacade trackerFacade;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AffectationTraceurVehiculeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "assign":
                    assignTrackerToVehicle(request);
                    break;
                case "unassign":
                    unassignTrackerFromVehicle(request);
                    break;
                case "delete":
                    deleteTrackerVehicle(request);
                    break;
                default:
                    break;
            }
        }

        // Redirect to the view (vehiculeTraceur.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("vehiculeTraceur.jsp");
        request.setAttribute("vehiculeTraceur", vehiculetrackerFacade.findAll());
        request.setAttribute("vehicules", vehiculeFacade.findAll());
        request.setAttribute("traceurs", trackerFacade.findAll());
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
	}
	
	private void assignTrackerToVehicle(HttpServletRequest request) {
	    String vehiculeId = request.getParameter("vehicule");
	    String trackerId = request.getParameter("tracker");
	    LocalDate dateDebut = LocalDate.parse(request.getParameter("dateDebut"));
	    LocalDate dateFin = LocalDate.parse(request.getParameter("dateFin"));

	    if (vehiculeId != null && trackerId != null) {
	        int vehiculeIdInt = Integer.parseInt(vehiculeId);
	        int trackerIdInt = Integer.parseInt(trackerId);

	        VehiculetrackerPK vehiculetrackerPK = new VehiculetrackerPK(dateDebut, trackerIdInt, vehiculeIdInt);
	        Vehiculetracker vehiculetracker = new Vehiculetracker(vehiculetrackerPK);
	        vehiculetracker.setDateFin(dateFin);
	        vehiculetrackerFacade.create(vehiculetracker);
	    }
	}
	private void deleteTrackerVehicle(HttpServletRequest request) {
	    String vehicule = request.getParameter("vehicule");
	    String tracker = request.getParameter("tracker");

	    if (vehicule != null && tracker != null) {
	        int vehiculeIdInt = Integer.parseInt(vehicule);
	        int trackerIdInt = Integer.parseInt(tracker);

	        VehiculetrackerPK vehiculetrackerPK = new VehiculetrackerPK(LocalDate.now(), trackerIdInt, vehiculeIdInt);
	        Vehiculetracker vehiculetracker = vehiculetrackerFacade.find(vehiculetrackerPK);

	        if (vehiculetracker != null) {
	            // Supprimez l'entité Vehiculetracker
	            vehiculetrackerFacade.remove(vehiculetracker);
	        }
	    }
	}


	 
	private void unassignTrackerFromVehicle(HttpServletRequest request) {
		  try {
		        String vehiculeId = request.getParameter("vehicule");
		        String trackerId = request.getParameter("tracker");
		        LocalDate currentDate = LocalDate.now();

		        if (vehiculeId != null && trackerId != null) {
		            int vehiculeIdInt = Integer.parseInt(vehiculeId);
		            int trackerIdInt = Integer.parseInt(trackerId);

		            VehiculetrackerPK vehiculetrackerPK = new VehiculetrackerPK(currentDate, trackerIdInt, vehiculeIdInt);
		            Vehiculetracker vehiculetracker = vehiculetrackerFacade.find(vehiculetrackerPK);

		            if (vehiculetracker != null) {
		                // Retrieve the new date de fin from the form
		                String dateFinString = request.getParameter("dateFin");

		                // Define the expected date format
		                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		                // Parse the date using the formatter
		                LocalDate newDateFin = LocalDate.parse(dateFinString, formatter);

		                // Update the date de fin
		                vehiculetracker.setDateFin(newDateFin);

		                // Save the updated Vehiculetracker entity
		                vehiculetrackerFacade.edit(vehiculetracker);
		            }
		        }
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the exception
		    }
	}

}
