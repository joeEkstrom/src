<%-- 
    Document   : index
    Created on : Jan 11, 2019, 12:57:47 PM
    Author     : Chris.Cusack
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    /*
        My JSP Page Declaratives    
    */
    
    List<String> errors;
    String alert = ""; //Build a script string to buil a javascript alert displaying errors

    /**
     * Check a string value to see if it is empty and build up an error list
     */
    private String checkRequiredField(String value, String fieldName) {
        if (value.equals("")) {
            errors.add(fieldName + " is required");
        }

        return value;
    }
   
    /**
     * Attempt to get a double value from a string value
     */
    private double getDoubleValue(String value, String fieldName) {
        try {
            if (!isNumeric(value)) {
                errors.add(fieldName + " is an invalid numeric value");
            }
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0.0;
        }
    }

    /**
     * Format a double to currency
     */
    private String currencyFormatter(double value) {
        NumberFormat nf = NumberFormat.getCurrencyInstance();
        return nf.format(value);
    }    

    public boolean isNumeric(String value) {
        boolean result = true;

        try {
            Double.parseDouble(value);
        } catch (Exception e) {
            result = false;
        }

        return result;
    }

    /**
     * Build out a JavaScript alert to use with any Java Server-side runtime
     * errors
     */
    private String buildErrorAlert(Exception e) {
        alert = "";
        String errorsMsg = e.getMessage() + "\\n\\n";

        for (String err : errors) {
            errorsMsg += err + "\\n";
        }
        return String.format("<script>alert(\"%s\");</script>", errorsMsg);
    }

    /**
     * Error Check. Run a check on the errors string array. If there is anything in
     * it, we know there are errors so lets throw
     */
    private void errorCheck() throws Exception {
        if (errors.size() > 0) {
            throw new Exception("Errors present");
        } else {
            //All Clear. Clear out the alert variable so there will be no javascript pop up in the user browser
            alert = "";
        }
    }
%>
<%
    /*
        Button specific code for each of the forms
     */

    alert = "";
    errors = new ArrayList();

    //Submit clicks 
    boolean ex1 = false;
    boolean ex2 = false;
    boolean ex3 = false;
    
    //Credit Card Variables
    String oldBalanceParam = "";
    String newChargesParam = "";
    String creditsParam = "";
    String financeChargeMsg = "";
    String newBalanceMsg = "";
    String minPaymentMsg = "";    

    double oldBalance = 0.0;
    double newCharges = 0.0;
    double credits = 0.0;
    double financeCharge = 0.0;
    double newBalance = 0.0;
    double minPayment = 0.0;

    //Salary Variables
    String firstNameParam = "";
    String lastNameParam = "";
    String currentSalaryParam = "";
    String salaryMsg = "";
    double salary = 0.0;

    //Sales Bonus Variables
    String salesAmountParam = "";
    double salesAmount = 0.0;
    double bonusPercent = 0.0;
    double bonusAmount = 0.0;
    String salesMsg = "";

    try {
        //Credit Card
        if (request.getParameter("calccreditcard") != null) {
            oldBalanceParam = checkRequiredField(request.getParameter("txtOldBalance"), "Old balance");
            newChargesParam = checkRequiredField(request.getParameter("txtCharges"), "New charges");
            creditsParam = checkRequiredField(request.getParameter("txtCredits"), "Credits");

            oldBalance = !oldBalanceParam.equals("") ? getDoubleValue(oldBalanceParam, "Old balance") : 0;
            newCharges = !newChargesParam.equals("") ? getDoubleValue(newChargesParam, "New charges") : 0;
            credits = !creditsParam.equals("") ? getDoubleValue(creditsParam, "Credits") : 0;
            
            //All data validated
            errorCheck();//exception thrown

            financeCharge = oldBalance * 0.015;
            newBalance = oldBalance + newCharges + financeCharge - credits;

            if (newBalance < 20) {
                minPayment = newBalance;
            } else {
                minPayment = 20 + ((newBalance - 20) * 0.1);
            }

            financeChargeMsg = "Finance Charge: " + currencyFormatter(financeCharge) + ".";
            newBalanceMsg = "New Balance: " + currencyFormatter(newBalance) + ".";
            minPaymentMsg = "Minimum Payment: " + currencyFormatter(minPayment) + ".";
            ex1 = true;
        }

        //New Salary calculation
        if (request.getParameter("calcsalary") != null) {
            firstNameParam = checkRequiredField(request.getParameter("txtFirstName"), "First name");
            lastNameParam = checkRequiredField(request.getParameter("txtLastName"), "Last name");
            currentSalaryParam = checkRequiredField(request.getParameter("txtSalary"), "Current salary");
            
            salary = !currentSalaryParam.equals("") ? getDoubleValue(currentSalaryParam, "Salary") : 0;

            errorCheck();

            if (salary < 40000) {
                salary = salary * 1.05;
            } else {
                salary = ((salary - 40000) * 0.02) + salary + 2000.0;
            }

            salaryMsg = "Next Year's Salary for " + firstNameParam + " " + lastNameParam + " should be " + currencyFormatter(salary) + ".";
            ex2 = true;
        }

        if (request.getParameter("calcbonus") != null) {
            salesAmountParam = checkRequiredField(request.getParameter("txtSalesAmt"), "Sales amount");
            
            salesAmount = !salesAmountParam.equals("") ? getDoubleValue(salesAmountParam, "Sales amount") : 0;

            errorCheck();

            if (salesAmount > 500 && salesAmount <= 2000) {
                bonusPercent = 0.02;
            } else if (salesAmount > 2000 && salesAmount <= 5000) {
                bonusPercent = 0.03;
            } else if (salesAmount > 5000) {
                bonusPercent = 0.05;
            }

            //Calculate the bonus base of the bonus percentage
            bonusAmount = salesAmount * bonusPercent;

            StringBuilder sb = new StringBuilder();
            
            sb.append("With a sales amount of ");
            sb.append(currencyFormatter(salesAmount));
            sb.append("<br />");
            sb.append("your bonus would be: ");
            sb.append(currencyFormatter(bonusAmount));

            salesMsg = sb.toString();
            ex3 = true;
        }

    } catch (Exception e) {
        alert = buildErrorAlert(e);
    } finally {
        errors = new ArrayList();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Post Exercises</title>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" type="text/javascript"></script>
        <style>
            body {
                margin: 0;
                padding: 0;
                text-align: center;
                font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
                color: gray !important;
            }

            h1{
                font-size:16px;
            }

            .centered {
                margin: 0 auto;
                text-align: center;
                width: 800px;
            }

            .left-align {
                padding: 10px;
                margin: 10px;
                text-align: center;
                border: 1px solid #c4c4c4 !important;
                width: 550px;
            }

            .inner-centered {
                margin: 0 auto;
                padding: 0px 50px 0px 50px;
                text-align: center;
                width: 700px;
            }

            .form {
                text-align: left;
                width: 600px;
            }

            .centered-content {
                text-align: center;
            }

            .width-100 {
                width: 100px;
            }

            .width-300 {
                width: 300px;
            }

            .width-100, .width-300{
                font-size:14px;
            }

        </style>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" type="text/css" rel="stylesheet" />       
        <%= alert %>       
    </head>
    <body>
        <div class="centered">
            <div class="left-align">
                <h1 class="centered-content">Credit Card Payment Calculator</h1>
                <%--Implementation here--%>
                <div class="inner-centered">
                    <div class="form">
                        <form name="form1" method="post" autocomplete="off">
                            <table>
                                <tr>
                                    <td class="width-100">Old Balance:</td>
                                    <td class="width-300">
                                        <input name="txtOldBalance" 
                                               class="width-300" value='<%= isNumeric(oldBalanceParam) 
                                                       && !ex1 ? oldBalanceParam : ""%>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="width-100">Charges:</td>
                                    <td class="width-300">
                                        <input name="txtCharges" class="width-300" value='<%= 
                                            isNumeric(newChargesParam) && 
                                                                   !ex1 ? newChargesParam : ""%>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="width-100">Credits:</td>
                                    <td class="width-300">
                                        <input name="txtCredits" class="width-300" value='<%= 
                                            isNumeric(creditsParam) && 
                                                                               !ex1 ? creditsParam : ""%>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <%= financeChargeMsg%><br />
                                        <%= newBalanceMsg%><br />
                                        <%= minPaymentMsg%><br />
                                        <input type="submit" name="calccreditcard" value="Calculate" 
                                               class="btn btn-primary"/>                                
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="left-align">
                <h1 class="centered-content">Next Year Salary Predictor</h1>
                <%--Implementation here--%>
                <div class="inner-centered">
                    <div class="form">
                        <form name="form2" method="post" autocomplete="off">
                            <table>
                                <tr>
                                    <td class="width-100">First Name:</td>
                                    <td class="width-300">
                                        <input name="txtFirstName" class="width-300" value='<%= !ex2 ? firstNameParam : ""%>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="width-100">Last Name:</td>
                                    <td class="width-300">
                                        <input name="txtLastName" class="width-300" value='<%= !ex2 ? lastNameParam : ""%>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="width-100">Current Salary:</td>
                                    <td class="width-300">
                                        <input name="txtSalary" class="width-300" value='<%= isNumeric(currentSalaryParam) && !ex2 ? currentSalaryParam : ""%>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <%= salaryMsg%>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td class="width-300">
                                        <input type="submit" name="calcsalary" value="Calculate" 
                                               class="btn btn-primary"/>     
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="left-align">
                <h1 class="centered-content">Bonus Calculator</h1>
                <%--Implementation here--%>
                <div class="inner-centered">
                    <div class="form">
                        <form name="form3" method="post" autocomplete="off">
                            <table>
                                <tr>
                                    <td class="width-100">Sales Amount:</td>
                                    <td class="width-300">
                                        <input name="txtSalesAmt" class="width-300" value='<%= isNumeric(salesAmountParam) & ex3 ? salesAmountParam : ""%>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="width-100">
                                        <input type="submit" name="calcbonus" value="Calculate" 
                                               class="btn btn-primary"/>  
                                    </td>
                                </tr>
                            </table>
                            <%= salesMsg%>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
