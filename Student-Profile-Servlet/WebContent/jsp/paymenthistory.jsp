<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=<device-width>, initial-scale=1.0">
    <title>Student Profile</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/js/feesearch.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainstyles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/feestyles.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    
</head>
<body>
   <div id="nav-fee-table">
        <button style="border: 0px;background-color:transparent;float:left; margin-left:10%;" data-toggle="modal" data-target="#filterModal" ><img id="filter-icon" src="${pageContext.request.contextPath}/images/filter.png" style="margin-left:0%" width="30px" height="30px"/></button>
        <button id="export-button" type="button" class="btn btn-outline-warning">Export as CSV</button>
        <div id="search-bar" style="background-color: #fcaf03;">
            
          <input type="text" class="form-control" id="enterTxnNo" placeholder="Enter transaction no" oninput="searchTable(this)">
            
            <div id="search-icon-box">
                <img src="${pageContext.request.contextPath}/images/search-icon.png" width="30px" height="30px"/>
            </div> 

            <!--<div class="form-group has-search bg-warning">
              <span class="bi bi-search search-form-control-feedback"></span>
              <input type="text" class="search-form-control" id="enterTxnNo" placeholder="Enter transaction no" oninput="searchTable(this)">
            </div>-->
        </div>
   </div>
   <table class="table" id="histTable" style="width: 81.8%;">
    <thead>
      <tr>
        <th scope="col">DD/Txn No</th>
        <th scope="col">DD/Txn Date 
          <button style="background-color: #fcaf03;border:0px;">
            <img id="up-arrow" src="${pageContext.request.contextPath}/images/upicon.png" width="20px" height="20px" style="float: left;margin-left:5px;" onclick="sortTable()">
            <img id="down-arrow" src="${pageContext.request.contextPath}/images/downicon.png" width="20px" height="20px" style="float: left;margin-left:5px;display:none;" onclick="sortTable()">
          </button>
        </th>
        <th scope="col">Purpose</th>
        <th scope="col">Amount</th>
        <th scope="col">Bank</th>  
        <th scope="col">Staff</th>
      </tr>
    </thead>
    <tbody>
      <tr id="no-result" style="display: none;">
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <c:forEach var="txn" items="${txns}">
	      <tr>
	        <td class="txnno"><c:out value="${txn.txn_number}" /></td>
	        <td class="txndate"><c:out value="${txn.txn_date}" /></td>
	        <td class="txnpurp"><c:out value="${txn.txn_purpose}" /></td>
	        <td><c:out value="${txn.txn_amt}" /></td>
	        <td><c:out value="${txn.bank}" /></td>
	        <td><c:out value="${txn.staff}" /></td>
	      </tr>
      </c:forEach>
    </tbody>
  </table>
  <div id="rem-fee">
      <strong>
        <h5>Remaining Fees:</h5><br>
        <h6>Scholarship: <c:out value="${remfee.slab}" /> % </h6>
        <h6>Tution Fee Payable: Rs. <c:out value="${remfee.tution_fee}" /> </h6>
      </strong>
  </div>

  <div class="modal fade" id="filterModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Filters</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <table class="table" id="filterTable" style="width: 81.8%;">
            
            <tbody>
              <tr>
                <td class="filtersel"><input class="form-check-input" type="checkbox" value="" id="sel" ></td>
                <td class="filtername">Year</td>
                <td class="filterval"><input class="form-check-input" type="text" value="" id="inputfilter" style="width: 30%;;"></td>
              </tr>
              <tr>
                <td class="filtersel"><input class="form-check-input" type="checkbox" value="" id="sel" ></td>
                <td class="filtername">Purpose</td>
                <td class="filterval">
                  <select class="form-select" id="inputfilter">
                    <option value="noopt" selected>Select</option>
                    <option value="Tution">Tution</option>
                    <option value="Mess">Mess</option>
                    <option value="Bus">Bus</option>
                  </select>
                </td>
 
              </tr>
              
            </tbody>
          </table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="removeFilter()">Remove Filters</button>
          <button type="button" class="btn btn-warning" style="background-color: #fcaf03;" onclick="checkFilter()">Apply</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>