<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
response.setContentType("application/vnd.ms-excel");
response.addHeader( "Content-Disposition", "attachment; filename=newTextReportMonthly.xls");
String month_from = (request.getParameter("month_from")==null)?"":request.getParameter("month_from");
String month_to = (request.getParameter("month_to")==null)?"":request.getParameter("month_to");
String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
int yearFrom = Integer.parseInt(year_from);
int yearTo = Integer.parseInt(year_to);
int monthFrom = Integer.parseInt(month_from);
int monthTo = Integer.parseInt(month_to);
int contatoreMeseFrom = 1;
int contatoreMeseTo = 12;
if(yearFrom == yearTo) {
	contatoreMeseFrom = monthFrom;
	contatoreMeseTo = monthTo;
}
String count = "";
String score = "";
int k = 0;
Hashtable distinctSections = (request.getAttribute("distinctSections")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSections");
Enumeration distinctSectionsEnum = distinctSections.keys();
Hashtable distinctSectionsScore = (request.getAttribute("distinctSectionsScore")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSectionsScore");
Hashtable distinctSectionsCount = (request.getAttribute("distinctSectionsCount")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSectionsCount");
Hashtable yearScoreTotal = (request.getAttribute("yearScoreTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("yearScoreTotal");
Hashtable yearCountTotal = (request.getAttribute("yearCountTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("yearCountTotal");
Hashtable monthScoreTotal = (request.getAttribute("monthScoreTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("monthScoreTotal");
Hashtable monthCountTotal = (request.getAttribute("monthCountTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("monthCountTotal");
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
					<x:Name>MonthlyReport</x:Name>
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
		<TD>Monthly Report</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR>
		<TD>
			<TABLE>
				<TR class="intestazione">
					<TD>Score (Points)</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
						if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
					%>
					<TD><%=i%></TD>
					<%	}
					}%>
				<%}%>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD><%=i%></TD>
				<%}%>
				</TR>
				<TR class="celle">
					<TD>&nbsp;</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
						if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
					%>
					<TD><%=Utils.getMonthDescription(j)%></TD>
					<%	}
					}%>
				<%}%>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD>YT</TD>
				<%}%>
				</TR>
				<%while(distinctSectionsEnum.hasMoreElements()) {
					k++;
					String id = distinctSectionsEnum.nextElement().toString();
					String name = distinctSections.get(id).toString();
				%>
				<TR class="celle">
					<TD><%=name%></TD>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
						<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
							if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
								score = "";
								try{
									score = ((Hashtable)distinctSectionsScore.get(id)).get(i + "_" + j).toString();
								}catch(Exception e){}
						%>
						<TD class="score"><%=Utils.roundUS(score)%></TD>
						<%	}
						}%>
					<%}%>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD class="score"><B><%=Utils.roundUS((yearScoreTotal.get(id + "_" + i)==null)?"":yearScoreTotal.get(id + "_" + i)+"")%></B></TD>
					<%}%>
				</TR>
				<%}%>
				<TR class="celle">
					<TD><B>TOTAL</B></TD>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
					if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
					%>
					<TD class="score"><B><%=Utils.roundUS((monthScoreTotal.get(i + "_" + j)==null)?"":monthScoreTotal.get(i + "_" + j)+"")%></B></TD>
					<%	}
					}%>
					<%}%>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD>&nbsp;</TD>
					<%}%>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR>
		<TD>
			<TABLE>
				<TR class="intestazione">
					<TD>Number of clippings</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
						if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
					%>
					<TD><%=i%></TD>
					<%	}
					}%>
				<%}%>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD><%=i%></TD>
				<%}%>
				</TR>
				<TR class="celle">
					<TD>&nbsp;</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
						if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
					%>
					<TD><%=Utils.getMonthDescription(j)%></TD>
					<%	}
					}%>
				<%}%>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD>YT</TD>
				<%}%>
				</TR>
				<%distinctSectionsEnum = distinctSections.keys();
				while(distinctSectionsEnum.hasMoreElements()) {
					k++;
					String id = distinctSectionsEnum.nextElement().toString();
					String name = distinctSections.get(id).toString();
				%>
				<TR class="celle">
					<TD><%=name%></TD>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
						<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
							if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
								count = "";
								try{
									count = ((Hashtable)distinctSectionsCount.get(id)).get(i + "_" + j).toString();
								}catch(Exception e){}
						%>
						<TD><%=count%></TD>
						<%	}
						}%>
					<%}%>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD><B><%=(yearCountTotal.get(id + "_" + i)==null)?"":yearCountTotal.get(id + "_" + i)%></B></TD>
					<%}%>
				</TR>
				<%}%>
				<TR class="celle">
					<TD><B>TOTAL</B></TD>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<%for(int j = contatoreMeseFrom; j<=contatoreMeseTo; j++) {
					if( (i==yearFrom && j >= monthFrom) || (i==yearTo && j <=monthTo) || (i!=yearFrom && i != yearTo) ) {
					%>
					<TD><B><%=(monthCountTotal.get(i + "_" + j)==null)?"":monthCountTotal.get(i + "_" + j)%></B></TD>
					<%	}
					}%>
					<%}%>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD>&nbsp;</TD>
					<%}%>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>

</BODY>

</HTML>