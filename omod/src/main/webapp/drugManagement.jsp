<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>

<openmrs:require privilege="Add Data entry drugs" otherwise="/login.htm" redirect="/module/dataentry/drugManagement.htm"/>

<openmrs:htmlInclude file="/moduleResources/dataentry/demo_page.css" />
<openmrs:htmlInclude file="/moduleResources/dataentry/demo_table.css" />
<openmrs:htmlInclude
	file="/moduleResources/dataentry/jquery.dataTables.js" />

<openmrs:htmlInclude
	file="/moduleResources/dataentry/jquery.simplemodal.js" />
<openmrs:htmlInclude
	file="/moduleResources/dataentry/jquery.createdit.js" />
<openmrs:htmlInclude file="/moduleResources/dataentry/basic.js" />
<openmrs:htmlInclude file="/moduleResources/dataentry/basic.css" />
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<openmrs:htmlInclude file="/scripts/dojo/dojo.js" />

<link href="<%= request.getContextPath() %>/openmrs.css" type="text/css" rel="stylesheet" />

<a href="${pageContext.request.contextPath}/patientDashboard.form?patientId=${patient.patientId}" style="text-decoration: none;"><openmrs:portlet url="patientHeader" id="patientDashboardHeader" patientId="${patient.patientId}" /></a>

<div id="dt_example">
<div id="container">
<table cellpadding="0" cellspacing="0" border="0" class="display"
	id="example">
	<thead>
		<tr>
			<th><spring:message code="dataentry.drugId" /></th>
			<th><spring:message code="dataentry.drug" /></th>
			<th><spring:message code="dataentry.dose" /></th>
			<th><spring:message code="dataentry.doseunits" /></th>
			<th><spring:message code="dataentry.frequency" /></th>
			<th><spring:message code="dataentry.quantity" /></th>
			<th><spring:message code="dataentry.quantityunits" /></th>
			<th><spring:message code="dataentry.route" /></th>
			<th><spring:message code="dataentry.startDate" /></th>
			<th><spring:message code="dataentry.stopDate" /></th>
			<th><spring:message code="dataentry.edit" /></th>
			<th><spring:message code="dataentry.stop" /></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${drugOrders}" var="do" varStatus="num">
			<tr>
				<td>
					<input type="hidden" id="instructions_${do.orderId}" value="${do.instructions}" /> 
					<span id="drugId_${do.orderId}">
						${not empty do.drug.drugId ? do.drug.drugId : '<img id="stop_${do.orderId}" class="stop" src="images/alert.gif"	style="cursor: pointer;" title="Needs to be updated" />'}
					</span>
				</td>
				<td><span id="name_${do.orderId}">${not empty do.drug ? do.drug.name : do.concept.name.name}</span></td>
				<td><span id="dose_${do.orderId}">${do.dose}</span></td>
				<td><span id="units_${do.orderId}" select-id="${do.doseUnits.uuid}">${do.doseUnits.names}</span></td>
				<td><span id="frequency_${do.orderId}" select-id="${do.frequency.uuid}">${do.frequency.frequencyPerDay}</span></td>
				<td><span id="quantity_${do.orderId}">${do.quantity}</span></td>
				<td><span id="quantityUnits_${do.orderId}"select-id="${do.quantityUnits.uuid}">${do.quantityUnits.names}</span></td>
				<td><span id="route_${do.orderId}"select-id="${do.route.uuid}">${do.route.names}</span></td>
				<td><span id="startDate_${do.orderId}"><openmrs:formatDate
					date="${do.dateActivated}" type="textbox" /></span></td>
				<td><span id="discontinuedDate_${do.orderId}"><openmrs:formatDate
					date="${do.dateStopped}" type="textbox" /></span></td>
				<td><img id="edit_${do.orderId}" class="edit"
					src="${pageContext.request.contextPath}/images/edit.gif"
					style="cursor: pointer;" /></td>
				<td><img id="stop_${do.orderId}" class="stop"
					src="${pageContext.request.contextPath}/images/stop.gif"
					style="cursor: pointer;" /></td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>			
			<td>
			<button id="create" class="send"><spring:message code="dataentry.create" /></button>
			</td>
			<td></td>
		</tr>
	</tfoot>
</table>
</div>
</div>

<div id="edit-dialog-content">
<form method="post" action="drugManagement.htm?patientId=${patientId}">
<input type="hidden" name="orderId" id="editing" /> <input
	type="hidden" name="editcreate" id="editingcreating" />
	<input type="hidden" name="encounter" value="${encounter.uuid}">
<table>
	<tr>
		<td><spring:message code="dataentry.drug" /></td>
		<td><select name="drugs" id="dname">
			<c:forEach items="${drugs}" var="drug">
				<option value="${drug.drugId}">${drug.name}</option>
			</c:forEach>
		</select></td>
	</tr>
	<tr>
		<td><spring:message code="dataentry.dose" /></td>
		<td><input id="ddose" type="text" name="dose" size="5" /></td>
	</tr>

	<tr>
		<td><spring:message code="dataentry.doseunits" /></td>
		<td>
			<select name="units" id="dunits">
				<c:forEach items="${doseUnits}" var="dose">
					<option value="${dose.uuid}">${dose.names}</option>
				</c:forEach>
			</select>
		</td>
	</tr>

	<tr>
		<td><spring:message code="dataentry.frequency" /></td>
		<td>
			<select name="frequency" id="dfrequency">
				<c:forEach items="${orderFrequencies}" var="dFreq">
					<option value="${dFreq.uuid}">${dFreq.frequencyPerDay}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="dataentry.quantity" /></td>
		<td><input id="dquantity" type="text" name="quantity" /></td>
	</tr>
	
	<tr>
		<td><spring:message code="dataentry.quantityunits" /></td>
		<td>
			<select name="quantityUnits" id="dquantityunits">
				<c:forEach items="${quantityUnits}" var="dQtyU">
					<option value="${dQtyU.uuid}">${dQtyU.names}</option>
				</c:forEach>
			</select>
		</td>
	</tr>

	<tr>
		<td><spring:message code="dataentry.startDate" /></td>
		<td><input id="dstartDate" type="text" name="startdate"
			onfocus="showCalendar(this)" class="date" size="11" /> (dd/mm/yyyy)</td>
	</tr>

	<tr>
		<td><spring:message code="dataentry.stopDate" /></td>
		<td><input id="ddiscontinuedDate" type="text" name="stopdate"
			onfocus="showCalendar(this)" class="date" size="11"
			readonly="readonly" /> (dd/mm/yyyy)</td>
	</tr>

	<tr>
		<td><spring:message code="dataentry.route" /></td>
		<td>
			<select name="drugRoute" id="dRoute">
				<c:forEach items="${drugRoutes}" var="dRoute">
					<option value="${dRoute.uuid}">${dRoute.names}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	
	<tr>
		<td valign="top"><spring:message code="Regimen Line" /></td>
		<td>
			<select name="regimenLine">
				<option value="11046">1st Line regimen</option>
				<option value="11047">2nd Line regimen</option>
				<option value="11048">3rd Line Regimen</option>
			</select>
		</td>
	</tr>

	<tr>
		<td valign="top"><spring:message code="dataentry.instructions" /></td>
		<td><textarea name="instructions" cols="50" rows="4"
			id="dinstructions"></textarea></td>
	</tr>

	<tr>
		<td><input type="submit" value="Submit" class="send" /></td>
	</tr>
</table>

</form>
</div>

<div id="stop-modal-content">
<form method="post" action="drugManagement.htm?patientId=${patientId}">
<input type="hidden" name="encounter" value="${encounter.uuid}">
<input type="hidden" name="orderId" id="stopping" /> <input
	type="hidden" name="stopping" id="stop" />
<table>
	<tr>
		<td><spring:message code="dataentry.stopReason" /></td>
		<td><select name="reasons" id="reasonsId">
			<c:forEach items="${reasonStoppedOptions}" var="sr">
				<option value="${sr.key}">${sr.value}</option>
			</c:forEach>
		</select></td>
	</tr>

	<tr>
		<td><spring:message code="dataentry.stopDate" /></td>
		<td><input id="cal" type="text" name="stopDate" id="stopDateId" size="12"
			onfocus="showCalendar(this)" class="date" size="11" /></td>
	</tr>
	<tr>
		<td><input type="submit" value="Update" class="send" /></td>
	</tr>
</table>

</form>
<br />
</div>

<script type="text/javascript">
var $dm = jQuery.noConflict();

$dm(document).ready( function() {
	$dm('.searchBox').hide();
	$dm(".createditdialog-close").trigger("click");
	$dm('#example').dataTable();
	$dm('.edit').click( function() {
		var index = this.id;
		var prefix = index.substring(0, index.indexOf("_"));
		var suffix = index.substring(index.indexOf("_") + 1);
		var varDose = $dm("#dose_" + suffix).text();
		var drugId = $dm("#drugId_" + suffix).text().replace(/\s/g, '');
		var varUnits = $dm("#units_" + suffix).attr("select-id");
		var varFrequency = $dm("#frequency_" + suffix).attr("select-id");
		var varQuantity = $dm("#quantity_" + suffix).text();
		var varQuantityUnits = $dm("#quantityUnits_" + suffix).attr("select-id");
		var varRoute = $dm("#route_" + suffix).attr("select-id");
		var varStartDate = $dm("#startDate_" + suffix).text();
		var varDiscDate = $dm("#discontinuedDate_" + suffix).text();
		var varInstructions = $dm("#instructions_" + suffix).val();
		var varDrugId = document.getElementById("dname");//$("#dname").val();
		var varDrugUnitId = document.getElementById("dunits");
		
			$dm("#editing").attr("value", suffix);
			//$("#dname").val(drugId);
		
			for ( var i = 0; i < varDrugId.options.length; i++) {
				if (varDrugId.options[i].value == drugId) {
					varDrugId.selectedIndex = i;
					break;
				}
			}
			for ( var i = 0; i < varDrugUnitId.options.length; i++) {
				if (varDrugUnitId.options[i].value == varUnits) {
					varDrugUnitId.selectedIndex = i;
					break;
				}
			}
			
			$dm("#ddose").attr("value", varDose);
			$dm("#dunits").val(varUnits);
			$dm("#dquantity").attr("value", varQuantity);
			$dm("#dfrequency").val(varFrequency);
			$dm("#dquantityunits").val(varQuantityUnits);
			$dm("#dRoute").val(varRoute);
			$dm("#dstartDate").val(varStartDate);
			$dm("#ddiscontinuedDate").val(varDiscDate);
			$dm("#dinstructions").html(varInstructions);
			$dm("#editingcreating").attr("value", "edit");
		});
	
	$dm('.stop').click( function() {
		var index = this.id;
		var prefix = index.substring(0, index.indexOf("_"));
		var suffix = index.substring(index.indexOf("_") + 1);
		var reasonsId = document.getElementById("reasonsId");
		var varStartDate = $dm("#stopDate_" + suffix).text();
		var varReasons = $dm("#discontinuedReason_" + suffix).text();
		$dm("#stopping").attr("value", suffix);
		$dm("#stopDateId").attr("value", varStartDate);
		$dm("#stop").attr("value", "stop");
		for ( var i = 0; i < reasonsId.options.length; i++) {
			if (reasonsId.options[i].value == varReasons) {
				reasonsId.selectedIndex = i;
				break;
			}
		}
	});
	$dm('#create').click( function() {
		$dm("#editingcreating").attr("value", "create");
	});
	$dm('#relEnc').click(function() {
		$dm('.searchBox').show();
	});
});

</script>

<%@ include file="/WEB-INF/template/footer.jsp"%>
