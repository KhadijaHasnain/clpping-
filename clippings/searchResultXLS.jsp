<%@page contentType="text/html" import="java.util.*,it.vidiemme.clipping.utils.*,it.vidiemme.clipping.beans.UserBean"%>
<%
UserBean user = (session.getAttribute("user") == null)? new UserBean():(UserBean)session.getAttribute("user");
response.setContentType("application/vnd.ms-excel");
response.addHeader( "Content-Disposition", "attachment; filename=searchClippingResult.xls");

String[] country_id_search = (request.getParameterValues("country_id_search")==null)?new String[0]:request.getParameterValues("country_id_search");
String[] area_id_search = (request.getParameterValues("area_id_search")==null)?new String[0]:request.getParameterValues("area_id_search");
if(area_id_search.length > 0 && area_id_search[0].contains(","))
	area_id_search = area_id_search[0].split(",");
if(country_id_search.length > 0 && country_id_search[0].contains(","))
	country_id_search = country_id_search[0].split(",");
String publication_id_search = (request.getParameter("publication_id_search")==null)?"":request.getParameter("publication_id_search");
String audience_id_search = (request.getParameter("audience_id_search")==null)?"":request.getParameter("audience_id_search");
String title_search = (request.getParameter("title_search")==null)?"":request.getParameter("title_search");
String fieldstory_id_search = (request.getParameter("fieldstory_id_search")==null)?"":request.getParameter("fieldstory_id_search");
String datepublished_from_search = (request.getParameter("datepublished_from_search")==null)?"":request.getParameter("datepublished_from_search");
String datepublished_to_search = (request.getParameter("datepublished_to_search")==null)?"":request.getParameter("datepublished_to_search");
String lengthofarticle_id_search = (request.getParameter("lengthofarticle_id_search")==null)?"":request.getParameter("lengthofarticle_id_search");
String tone_id_search = (request.getParameter("tone_id_search")==null)?"":request.getParameter("tone_id_search");
String graphic_id_search = (request.getParameter("graphic_id_search")==null)?"":request.getParameter("graphic_id_search");
String cover_id_search = (request.getParameter("cover_id_search")==null)?"":request.getParameter("cover_id_search");
String score_search = (request.getParameter("score_search")==null)?"":request.getParameter("score_search");
Vector resultVector = DbUtils.getSearchClippingsXLS(area_id_search, country_id_search, publication_id_search, audience_id_search, title_search, fieldstory_id_search, datepublished_from_search, datepublished_to_search, lengthofarticle_id_search, tone_id_search, graphic_id_search, cover_id_search, score_search, "", user);
int countryClippingNumber = 0;
double countryClippingScore = 0d;
int areaClippingNumber = 0;
double areaClippingScore = 0d;
String oldCountry = "";
String oldArea = "";
String oldCountryDesc = "";
String oldAreaDesc = "";
%>

<HTML xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">

<HEAD>
    <STYLE>
        .titolo{
            mso-style-parent:style0;
            font-size:9.0pt;
            font-weight:700;
            font-family:Verdana, sans-serif;
            mso-font-charset:0;
            text-align:center;
            white-space:normal;
        }
        .intestazione{
            mso-style-parent:style0;
			font-size:9.0pt;
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
			font-size:9.0pt;
            font-family:Verdana, sans-serif;
            mso-font-charset:0;
            border:.5pt solid windowtext;
            white-space:normal;
        }
        .score{
            mso-style-parent:style0;
			font-size:9.0pt;
            font-family:Verdana, sans-serif;
			mso-font-charset:0;
			mso-number-format:\@;
            border:.5pt solid windowtext;
            white-space:normal;
        }
        .total{
			height: 40px;
            mso-style-parent:style0;
            font-size:9.0pt;
			font-weight: bold;
            font-family:Verdana, sans-serif;
            mso-font-charset:0;
            mso-number-format:\@;
            text-align:left;
            white-space:normal;
        }
		.total_clippings{
			height: 40px;
            mso-style-parent:style0;
            font-size:9.0pt;
			font-weight: bold;
            font-family:Verdana, sans-serif;
            mso-font-charset:0;
            mso-number-format:\@;
            text-align:center;
            white-space:normal;
        }
    </STYLE>
    <!--[if gte mso 9]>
    <xml>
            <x:ExcelWorkbook>
                    <x:ExcelWorksheets>
                            <x:ExcelWorksheet>
                                    <x:Name>SearchClippingResult</x:Name>
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
            <TD>CLIPPINGS - SEARCH CLIPPING RESULT</TD>
	</TR>
	<TR><TD>&nbsp;</TD></TR>
        <TR>
            <TD class="total_clippings">
                Total Clipping: <B><%=resultVector.size()%></B>
            </TD>
        </TR>
        <TR><TD>&nbsp;</TD></TR>
	<TR>
            <TD>
                <TABLE>
                    <TR class="intestazione">
                        <TD>Area/Country</TD>
                        <TD>Clipping Title</TD>
                        <TD>Event</TD>
                        <TD>Length of Article</TD>
                        <TD>Tone</TD>
                        <TD>Graphic</TD>
                        <TD>Cover</TD>
                        <TD>Type of Story</TD>
                        <TD>Lengthscore</TD>
                        <TD>Publication Title</TD>
                        <TD>Date Published</TD>
						<TD>Audience</TD>
						<TD>Level Of Press</TD>
						<TD>Size</TD>
						<TD>Frequency</TD>
						<TD>Medium</TD>
                        <TD>Score</TD>
                    </TR>
                    <%
                    for(int i = 0; i < resultVector.size(); i++){
						String area = ((Hashtable)resultVector.elementAt(i)).get("area_code").toString();
						String country = ((Hashtable)resultVector.elementAt(i)).get("country_code").toString();
                        String areaId = ((Hashtable)resultVector.elementAt(i)).get("areaid").toString();
						String countryId = ((Hashtable)resultVector.elementAt(i)).get("countryid").toString();
                        String title = ((Hashtable)resultVector.elementAt(i)).get("title").toString();
                        String eventid = ((Hashtable)resultVector.elementAt(i)).get("eventtitle").toString();
                        String lengthid = ((Hashtable)resultVector.elementAt(i)).get("length").toString();
                        String toneid = ((Hashtable)resultVector.elementAt(i)).get("tone").toString();
                        String graphicid = ((Hashtable)resultVector.elementAt(i)).get("graphic").toString();
                        String coverid = ((Hashtable)resultVector.elementAt(i)).get("cover").toString();
                        String fieldstoryid = ((Hashtable)resultVector.elementAt(i)).get("fieldstory").toString();
                        String lengthscore = ((Hashtable)resultVector.elementAt(i)).get("lengthscore").toString();
                        String publication = ((Hashtable)resultVector.elementAt(i)).get("name").toString();
                        String datepublished = ((Hashtable)resultVector.elementAt(i)).get("datepublished").toString();
						String audience = ((Hashtable)resultVector.elementAt(i)).get("audience").toString();
						String level = ((Hashtable)resultVector.elementAt(i)).get("level").toString();
						String size = ((Hashtable)resultVector.elementAt(i)).get("size").toString();
						String frequency = ((Hashtable)resultVector.elementAt(i)).get("frequency").toString();
						String medium = ((Hashtable)resultVector.elementAt(i)).get("medium").toString();
                        String score = ((Hashtable)resultVector.elementAt(i)).get("score").toString();
						title = title.equals("")||title==null?"":Utils.formatStringForView(title);

						/*eventid = eventid.equals("")||eventid==null?"":DbUtils.getEventDescription(eventid);
                        lengthid = lengthid.equals("")||lengthid==null?"":DbUtils.getLengthDescription(lengthid);
                        toneid = toneid.equals("")||toneid==null?"":DbUtils.getToneDescription(toneid);
                        graphicid = graphicid.equals("")||graphicid==null?"":DbUtils.getGraphicDescription(graphicid);
                        coverid = coverid.equals("")||coverid==null?"":DbUtils.getCoverDescription(coverid);
                        fieldstoryid = fieldstoryid.equals("")||fieldstoryid==null?"":DbUtils.getFieldstoryDescription(fieldstoryid);
 						*/
                        lengthscore = lengthscore.equals("")||lengthscore==null?"":lengthscore;
                        //publicationId = publicationId.equals("")||publicationId==null?"":DbUtils.getPublicationDescription(publicationId);
                        datepublished = datepublished.equals("")||datepublished==null?"":Utils.formatDateForView(datepublished);
                        score = score.equals("")||score==null?"0.00":score;
                    %>
                    <%if(!oldCountry.equals(countryId) && !oldCountry.equals("")) {%>
					<TR>
						<TD class="total" colspan="16"><%=oldCountryDesc%> (<%=countryClippingNumber%> clipping)</TD>
						<TD class="total"><%=Utils.roundUS(countryClippingScore+"")%></TD>
					</TR>
                    <%	countryClippingNumber = 0;
						countryClippingScore = 0;
					}%>
					<%if(!oldArea.equals(areaId) && !oldArea.equals("")) {%>
					<TR>
						<TD colspan="16" class="total"><%=oldAreaDesc%>(<%=areaClippingNumber%> clipping)</TD>
						<TD class="total"><%=Utils.roundUS(areaClippingScore+"")%></TD>
					</TR>
                    <%
						areaClippingNumber = 0;
						areaClippingScore = 0;
					}%>
                    <%
						oldArea = areaId;
						oldCountry = countryId;
						oldAreaDesc = area;
						oldCountryDesc = country;
						if(!countryId.equals("")) {
							countryClippingNumber++;
							try {
								countryClippingScore += Double.parseDouble(((Hashtable)resultVector.elementAt(i)).get("score").toString());
							} catch (Exception e) {
							}
						}
						areaClippingNumber++;
						try {
							areaClippingScore += Double.parseDouble(((Hashtable)resultVector.elementAt(i)).get("score").toString());
						} catch (Exception e) {
						}
					%>
					<TR class="celle">
                        <TD><%=area + ((country.equals(""))?"":" / "+country)%></TD>
                        <TD><%=title%></TD>
                        <TD><%=eventid%></TD>
                        <TD><%=lengthid%></TD>
                        <TD><%=toneid%></TD>
                        <TD><%=graphicid%></TD>
                        <TD><%=coverid%></TD>
                        <TD><%=fieldstoryid%></TD>
                        <TD><%=lengthscore%></TD>
                        <TD><%=publication%></TD>
                        <TD><%=datepublished%></TD>
						<TD><%=audience%></TD>
						<TD><%=level%></TD>
						<TD><%=size%></TD>
						<TD><%=frequency%></TD>
						<TD><%=medium%></TD>
						<TD class="score"><%=Utils.roundUS(score)%></TD>
                    </TR>
					<%}%>
					<%if(!oldCountry.equals("")) {%>
					<TR>
						<TD class="total" colspan="16"><%=oldCountryDesc%> (<%=countryClippingNumber%> clipping)</TD>
						<TD class="total"><%=Utils.roundUS(countryClippingScore+"")%></TD>
					</TR>
                    <%	countryClippingNumber = 0;
						countryClippingScore = 0;
					}%>
					<%if(!oldArea.equals("")) {%>
					<TR>
						<TD colspan="16" class="total"><%=oldAreaDesc%>(<%=areaClippingNumber%> clipping)</TD>
						<TD class="total"><%=Utils.roundUS(areaClippingScore+"")%></TD>
					</TR>
                    <%
						areaClippingNumber = 0;
						areaClippingScore = 0;
					}%>
					<%if(resultVector.size() == 0){%>
                    <TR>
                        <TD colspan="12" class="total"><B>THERE ARE NO CLIPPINGS WITH THE SEARCHING PARAMETERS</B></TD>
                    </TR>
                    <%}%>
                </TABLE>
            </TD>
	</TR>
</TABLE>

</BODY>

</HTML>