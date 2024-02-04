<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>

<%
response.setContentType("application/vnd.ms-excel");
response.addHeader( "Content-Disposition", "attachment; filename=newTextReportYearly.xls");
String year_from = (request.getParameter("year_from")==null)?"":request.getParameter("year_from");
String year_to = (request.getParameter("year_to")==null)?"":request.getParameter("year_to");
int yearFrom = Integer.parseInt(year_from);
int yearTo = Integer.parseInt(year_to);
String count = "";
String score = "";
int k = 0;
Hashtable distinctSections = (request.getAttribute("distinctSections")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSections");
Enumeration distinctSectionsEnum = distinctSections.keys();
Hashtable distinctSectionsScore = (request.getAttribute("distinctSectionsScore")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSectionsScore");
Hashtable distinctSectionsCount = (request.getAttribute("distinctSectionsCount")==null)?new Hashtable():(Hashtable)request.getAttribute("distinctSectionsCount");
Hashtable yearScoreTotal = (request.getAttribute("yearScoreTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("yearScoreTotal");
Hashtable yearCountTotal = (request.getAttribute("yearCountTotal")==null)?new Hashtable():(Hashtable)request.getAttribute("yearCountTotal");
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
					<x:Name>YearlyReport</x:Name>
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
		<TD>Yearly Report</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
	<TR>
		<TD>
			<TABLE>
				<TR class="intestazione">
					<TD>Score (Points)</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD><%=i%></TD>
				<%}%>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
				<TD><%=i%></TD>
				<%}%>
				</TR>
				<TR class="celle">
					<TD>&nbsp;</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD>&nbsp;</TD>
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
					<%for(int i = yearFrom; i <= yearTo; i++) {
						score = "";
						try{
							score = ((Hashtable)distinctSectionsScore.get(id)).get(i+"").toString();
						}catch(Exception e){}
					%>
					<TD class="score"><%=it.vidiemme.clipping.utils.Utils.roundUS(score)%></TD>
					<%}%>
					<%for(int i = yearFrom; i <= yearTo; i++) {
						score = "";
						try{
							score = ((Hashtable)distinctSectionsScore.get(id)).get(i+"").toString();
						}catch(Exception e){}
					%>
					<TD class="score"><B><%=it.vidiemme.clipping.utils.Utils.roundUS(score)%></B></TD>
					<%}%>
				</TR>
				<%}%>
				<TR class="celle">
					<TD><B>TOTAL</B></TD>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD class="score"><B><%=it.vidiemme.clipping.utils.Utils.roundUS((yearScoreTotal.get(i+"")==null)?"":yearScoreTotal.get(i+"")+"")%></B></TD>
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
					<TD><%=i%></TD>
				<%}%>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD><%=i%></TD>
				<%}%>
				</TR>
				<TR class="celle">
					<TD>&nbsp;</TD>
				<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD>&nbsp;</TD>
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
					<%for(int i = yearFrom; i <= yearTo; i++) {
						count = "";
						try{
							count = ((Hashtable)distinctSectionsCount.get(id)).get(i+"").toString();
						}catch(Exception e){}
					%>
						<TD><%=count%></TD>
					<%}%>
					<%for(int i = yearFrom; i <= yearTo; i++) {
						count = "";
						try{
							count = ((Hashtable)distinctSectionsCount.get(id)).get(i+"").toString();
						}catch(Exception e){}
					%>
					<TD><B><%=count%></B></TD>
					<%}%>
				</TR>
				<%}%>
				<TR class="celle">
					<TD><B>TOTAL</B></TD>
					<%for(int i = yearFrom; i <= yearTo; i++) {%>
					<TD><B><%=(yearCountTotal.get(i+"")==null)?"":yearCountTotal.get(i+"")%></B></TD>
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