// MedicineRecord.java
package com.clinic.model;

import java.util.Date;

public class MedicineRecord {
    private int quantityGiven;
    private Date dateGiven;
    private String doctorName;
    private String medicineName;

    // Getters and setters
    public int getQuantityGiven() {
        return quantityGiven;
    }

    public void setQuantityGiven(int quantityGiven) {
        this.quantityGiven = quantityGiven;
    }

    public Date getDateGiven() {
        return dateGiven;
    }

    public void setDateGiven(Date dateGiven) {
        this.dateGiven = dateGiven;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }
}
