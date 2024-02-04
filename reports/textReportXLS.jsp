<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
response.setContentType("application/vnd.ms-excel");
response.addHeader( "Content-Disposition", "attachment; filename=textReport.xls");
Vector resultVector = (request.getAttribute("results")==null)?new Vector():(Vector)request.getAttribute("results");
String section_id = (request.getParameter("section_id")==null)?"":request.getParameter("section_id");
String section_desc = DbUtils.getSectionDescription(section_id);
%>

<HTML xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">

<HEAD>
	<STYLE>
		.titolo{
			mso-style-parent:style0;
			font-size:14.0pt;
			font-weight:700;
			font-family:Verdana, sans-serif;
			mso-font-charset:0;
			text-align:center;
			white-space:normal;
		}
		.intestazione{
			mso-style-parent:style0;
			font-weight:700;
			font-family:Verdana, sans-serif;
			mso-font-charset:0;
			border:.5pt solid windowtext;
			background:#969696;
			mso-pattern:auto none;
			white-space:normal;
		}
		.celle{
			mso-style-parent:style0;
			font-family:Verdana, sans-serif;
			mso-font-charset:0;
			border:.5pt solid windowtext;
			white-space:normal;
		}
		.score{
			mso-style-parent:style0;
			mso-number-format:\@;
		}
	</STYLE>
	<!--[if gte mso 9]>
	<xml>
		<x:ExcelWorkbook>
			<x:ExcelWorksheets>
				<x:ExcelWorksheet>
					<x:Name>TextReport</x:Name>
					<x:WorksheetOptions>
						<x:Selected/>
						<x:ProtectContents>False</x:ProtectContents>
						<x:ProtectObjects>False</x:ProtectObjects>
						<x:ProtectScenarios>False</x:ProtectScenarios>
					</x:WorksheetOptions>
				</x:ExcelWorksheet>
			<x:WindowHeight>9090</x:WindowHeight>
			<x:WindowWidth>19020</x:WindowWidth>
			<x:WindowTopX>120</x:WindowTopX>
			<x:WindowTopY>45</x:WindowTopY>
			<x:ProtectStructure>False</x:ProtectStructure>
			<x:ProtectWindows>False</x:ProtectWindows>
		</x:ExcelWorkbook>
	</xml>
	<![endif]-->
</HEAD>

<BODY>

<TABLE>
	<TR class="titolo">
		<TD>Text Report</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR>
		<TD>
			<TABLE>
				<TR class="intestazione">
					<TD>Area</TD>
					<TD>Publication Title</TD>
					<%if(section_id.equals("1")||section_id.equals("3")||section_id.equals("6")){%>
					<TD><%=section_desc.substring(0,1)+section_desc.substring(1).toLowerCase()%></TD>
					<%}%>
					<TD>Date Published</TD>
					<TD>Clipping Title</TD>
					<TD>Score</TD>
					<TD>Tone</TD>
				</TR>
				<%for(int i = 0; i < resultVector.size(); i++){
					String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
					String audienceId = ((Hashtable)resultVector.elementAt(i)).get("audienceid").toString();
					String eventId = ((Hashtable)resultVector.elementAt(i)).get("eventid").toString();
					String mediumId = ((Hashtable)resultVector.elementAt(i)).get("mediumid").toString();
					String publication = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
					String datepublished = ((Hashtable)resultVector.elementAt(i)).get("datepublished").toString();
					String clipping = ((Hashtable)resultVector.elementAt(i)).get("title").toString();
					String score = ((Hashtable)resultVector.elementAt(i)).get("score").toString();
					String toneId = ((Hashtable)resultVector.elementAt(i)).get("toneid").toString();
				%>
				<TR class="celle">
					<TD><%=DbUtils.getAreaDescription(areaId)%></TD>
					<TD><%=Utils.formatStringForView(publication)%></TD>
					<%if(section_id.equals("1")){%>
					<TD><%=DbUtils.getAudienceDescription(audienceId)%></TD>
					<%}else if(section_id.equals("3")){%>
					<TD><%=DbUtils.getEventDescription(eventId)%></TD>
					<%}else if(section_id.equals("6")){%>
					<TD><%=DbUtils.getMediumDescription(mediumId)%></TD>
					<%}%>
					<TD><%=Utils.formatDateForView(datepublished)%></TD>
					<TD><%=Utils.formatStringForView(clipping)%></TD>
					<TD class="score"><%=Utils.roundUS(score)%></TD>
					<TD><%=DbUtils.getToneDescription(toneId)%></TD>
				</TR>
				<%}%>
				<%if(resultVector.size() == 0){%>
				<TR>
					<TD><B>THERE ARE NO RESULTS WITH THE SEARCHING PARAMETERS</B></TD>
				</TR>
				<%}%>
			</TABLE>
		</TD>
	</TR>
</BODY>

</HTML>