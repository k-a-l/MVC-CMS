package com.clinic.model;

import java.sql.Timestamp;

public class MedicineGiven {
    private int id;
    private String doctorName;
    private String medicineName;
    private int quantityGiven;
    private Timestamp dateGiven;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public int getQuantityGiven() { return quantityGiven; }
    public void setQuantityGiven(int quantityGiven) { this.quantityGiven = quantityGiven; }

    public Timestamp getDateGiven() { return dateGiven; }
    public void setDateGiven(Timestamp dateGiven) { this.dateGiven = dateGiven; }
}
