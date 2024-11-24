<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard</title>
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <!-- MDB JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
    <!-- Custom Styles for Sidebar -->
    <style>
        #sidebar {
            min-width: 250px;
            max-width: 250px;
            height: 100vh;
            position: fixed;
        }
        .container-fluid {
            margin-left: 250px;
        }
    </style>
</head>

<body>
    <!-- Sidebar -->
    <div class="d-flex">
        <div class="bg-dark text-white p-3" id="sidebar">
            <h4>Clinic Management</h4>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link text-white" href="DashboardServlet">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="AddDoctorServlet">Manage Doctors</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="AddPatientServlet">Manage Patients</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="AddInventoryServlet">Manage Inventory</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="NotificationServlet">Notification</a>
                </li>
            </ul>
        </div>

       </div>

</body>

</html>
