<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:variable name="specialisms" select="'Leader|Combat|Zealot|Demolitions|Comms|Veteran|Scout|Heavy|Medic|Sniper|Strength|Strategist'"/>
    <xsl:variable name="advances" select="'1. Fleet|2. Lucky|3. Courageous|4. Skilled|5. Lethal|6. Die-hard'"/>

	<xsl:template match="bs:roster/bs:forces/bs:force">
		<html>
		<head>
			<style>
					<!-- inject:../build/style.css -->
					@import url("https://fonts.googleapis.com/css?family=Oswald:600|EB+Garamond:400,400i,700");
body {
  font-family: "EB Garamond", serif; }

th {
  background-color: #E1501E;
  padding: 2px;
  font-family: "Oswald", sans-serif; }

h1 {
  text-align: center;
  font-size: 3em;
  text-transform: uppercase;
  font-family: "Oswald", sans-serif;
  font-weight: bold;
  margin: 0; }

h2 {
  font-size: 0.8em;
  font-family: "Oswald", sans-serif;
  margin: 0;
  padding-left: 0.1cm; }

#resources {
  margin-bottom: 0.5cm; }

table.campaign {
  width: 100%; }
  table.campaign th, table.campaign td {
    width: 20%; }
  table.campaign tr > th:first-child {
    text-align: left;
    padding-left: 0.2cm; }
  table.campaign tr > td:last-child {
    width: 10%;
    text-align: center; }
  table.campaign td {
    border: 1px solid #666666; }
  table.campaign table.resource {
    width: 100%; }
    table.campaign table.resource td {
      border: none; }
    table.campaign table.resource td:last-child {
      text-align: right;
      width: 50%;
      padding-right: 0.5cm; }

table.roster {
  width: 100%;
  background-color: #FFFFFF; }
  table.roster th {
    width: 14.28571%;
    font-size: 0.9em;
    font-family: 'Oswald', sans-serif;
    text-transform: uppercase; }
  table.roster td {
    background-color: #dfdfdf;
    text-align: center;
    font-size: 0.7em; }

.card {
  width: 11.3cm;
  min-height: 7.3cm;
  background-color: #FFFFFF;
  border-radius: 0.4em;
  padding: 0.2cm;
  font-size: 0.8em;
  border: 0.02cm solid #bbbbbb;
  display: table; }
  .card .header {
    display: flex;
    flex-direction: row;
    padding-bottom: 1px; }
    .card .header > div {
      flex-basis: 33%;
      text-align: center; }
      .card .header > div:first-child {
        text-align: left;
        text-transform: uppercase;
        font-weight: bold; }
      .card .header > div:last-child {
        text-align: right;
        text-transform: uppercase;
        font-weight: bold; }
  .card table {
    width: 100%;
    font-size: 0.7em;
    text-align: center;
    text-transform: uppercase; }
  .card th {
    border-top: 1px solid #222E33;
    border-bottom: 1px solid #222E33; }
    .card th:first-child {
      text-align: left;
      min-width: 2cm;
      padding-left: 0.1cm; }
  .card td {
    background-color: #dfdfdf;
    border-left: 1px solid #FFFFFF;
    border-right: 1px solid #FFFFFF;
    border-bottom: 2px solid #FFFFFF;
    text-transform: none; }
    .card td:first-child {
      text-align: left;
      min-width: 2cm;
      width: 2cm;
      padding-left: 0.1cm;
      border-left: none; }
    .card td:last-child {
      border-right: none; }
    .card td.sub-header {
      background-color: transparent;
      font-weight: bold;
      font-family: "Oswald", sans-serif; }
    .card td.sub-body {
      background-color: transparent;
      font-weight: bold;
      text-align: left;
      padding-left: 0.1cm; }

.unit th, .unit td {
  font-weight: bold; }
  .unit th:not(:first-child), .unit td:not(:first-child) {
    width: 0.91cm; }

.unit td {
  font-size: 1.2em; }

.weapons th:not(:first-child):not(:last-child), .weapons td:not(:first-child):not(:last-child) {
  width: 1.22cm; }

.weapons th:last-child, .weapons td:last-child {
  min-width: 3cm; }

.weapons td {
  border-bottom: 2px solid #FFFFFF; }

.specialism > div {
  float: left; }

.exp {
  font-size: 0.8em;
  display: table-footer-group;
  margin-left: 6px; }
  .exp > div {
    float: left;
    margin: 0 2px; }
    .exp > div > span {
      margin: 1px; }
    .exp > div > span:nth-child(3), .exp > div span:nth-child(7), .exp > div span:nth-child(12) {
      color: #E1501E; }

@media screen {
  #cards {
    display: flex;
    flex-wrap: wrap; }
    #cards .card {
      margin: 0.2cm; } }

@media print {
  #roster {
    page-break-after: always; }
  .card {
    float: left;
    page-break-inside: avoid; } }

					<!-- endinject -->
			</style>
		</head>
		<body>
			<xsl:apply-templates select="bs:selections/bs:selection[@name='List Configuration']" mode="list-configuration"/>
			<section id="cards">
				<xsl:apply-templates select="bs:selections/bs:selection[@type='model']" mode="card"/>
				<xsl:apply-templates select="bs:selections/bs:selection[@type='unit']/bs:selections/bs:selection[@type='model']" mode="card"/>
			</section>
		</body>
		</html>
	</xsl:template>
	
    <xsl:template match="bs:selection/bs:selections/bs:selection" mode="list-configuration">
        <xsl:if test="contains(@name, 'Campaign') or contains(@name, 'Roster')">
            <section>
                <div>
                    <h1>command roster</h1>
                </div>
            </section>
        </xsl:if>
		<xsl:if test="contains(@name, 'Campaign')">
			<section id="resources">
				<xsl:call-template name="campaign">
					<xsl:with-param name="resources" select="../../../bs:selection[@name='Resources']"/>
				</xsl:call-template>
			</section>
		</xsl:if>
		<xsl:if test="contains(@name, 'Roster')">
			<section id="roster">
				<table class="roster">
					<tr>
						<th>Name</th>
						<th>Model Type</th>
						<th>Wargear</th>
						<th>Exp</th>
						<th>Specialism/Abilities</th>
						<th>Demeanour</th>
						<th>Pts</th>
					</tr>
					<xsl:apply-templates select="../../../bs:selection[@type='model']" mode="roster"/>
					<xsl:apply-templates select="../../../bs:selection[@type='unit']/bs:selections/bs:selection[@type='model']" mode="roster"/>
				</table>
			</section>
		</xsl:if>
	</xsl:template>
	
    <!-- inject:campaign.xsl -->
    <xsl:template name="campaign">
    <xsl:param name="resources"/>
    <table class="campaign">
        <tr>
            <th>Player Name</th>
            <td></td>
            <th>Resources</th>
            <th>Current Kill Team Force</th>
            <td>
                <xsl:value-of select="round(../../../../../../bs:costs/bs:cost[@name='pts']/@value)"></xsl:value-of>
                 Points</td>
        </tr>
        <tr>
            <th>Faction</th>
            <td></td>
            <td>
                <table class="resource">
                    <tr>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Intelligence']/@name"/>
                        </td>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Intelligence']/@number"/>
                        </td>
                    </tr>
                </table>
            </td>
            <th>Current Kill Team's Name</th>
            <td></td>
        </tr>
        <tr>
            <th>Mission</th>
            <td></td>
            <td>
                <table class="resource">
                    <tr>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Materiel']/@name"/>
                        </td>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Materiel']/@number"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <th>Background</th>
            <td></td>
            <td>
                <table class="resource">
                    <tr>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Morale']/@name"/>
                        </td>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Morale']/@number"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <th>Squad Quirk</th>
            <td></td>
            <td>
                <table class="resource">
                    <tr>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Territory']/@name"/>
                        </td>
                        <td>
                            <xsl:value-of select="$resources/bs:selections/bs:selection[@name='Territory']/@number"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td></td>
            <td></td>
        </tr>
    </table>
</xsl:template>

    <!-- endinject -->

    <!-- inject:roster.xsl -->
    	
	<!-- Renders the rows of the units in the roster table -->
	<xsl:template match="bs:selection[@type='model']" mode="roster">
		<xsl:variable name="rosterPoints">
	        <xsl:for-each select="bs:selections/bs:selection">
	            <xsl:choose>
	                <xsl:when test="contains($specialisms, @name)">
	                    <xsl:for-each select="bs:selections/bs:selection/bs:costs/bs:cost">
	                        <ItemCost>
	                            <xsl:value-of select="@value"/>
	                        </ItemCost>
	                    </xsl:for-each>
	                </xsl:when>
	                <xsl:otherwise>
	                    <ItemCost>
	                        <xsl:value-of select="bs:costs/bs:cost/@value"/>
	                    </ItemCost>
	                </xsl:otherwise>
	            </xsl:choose>
	        </xsl:for-each>
	    </xsl:variable>
	    <xsl:variable name="subTotal" select="exslt:node-set($rosterPoints)"/>
	    <tr>
	        <td>
						<xsl:value-of select="@customName"/>
					</td>
	        <td>
	            <xsl:value-of select="@name"/>
	        </td>
	        <td>
	            <xsl:for-each select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Weapon']">
	                <xsl:value-of select="@name"/>, 
	            </xsl:for-each>
	            <xsl:for-each select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Wargear']">
	                <xsl:value-of select="@name"/>, 
	            </xsl:for-each>
	        </td>
	        <td></td>
	        <td>
						<xsl:for-each select="bs:selections/bs:selection">
							<xsl:if test="contains($specialisms, @name)">
								<xsl:value-of select="@name"/>, 
							</xsl:if>
						</xsl:for-each>
						
							<xsl:if test="bs:selections/bs:selection/bs:categories/bs:category">
								<xsl:value-of select="bs:selections/bs:selection/bs:categories/bs:category/@name"/>, 							
							</xsl:if>
	            <xsl:for-each select="bs:profiles/bs:profile[@typeName='Ability']">
	                <xsl:value-of select="@name"/>,                                 
	            </xsl:for-each>
	        </td>
	        <td></td>
	        <td>
	            <xsl:value-of select="sum($subTotal/ItemCost) + bs:costs/bs:cost/@value"/>
	        </td>
	    </tr>
	</xsl:template>
    <!-- endinject -->

    <!-- inject:card.xsl -->
    	<!-- Renders the unit cards -->
	<xsl:template match="bs:selection[@type='model']" mode="card">
		<xsl:variable name="nodePoints">
	        <xsl:for-each select="bs:selections/bs:selection">
	            <xsl:choose>
	                <xsl:when test="contains($specialisms, @name)">
	                    <xsl:for-each select="bs:selections/bs:selection/bs:costs/bs:cost">
	                        <ItemCost>
	                            <xsl:value-of select="@value"/>
	                        </ItemCost>
	                    </xsl:for-each>
	                </xsl:when>
	                <xsl:otherwise>
	                    <ItemCost>
	                        <xsl:value-of select="bs:costs/bs:cost/@value"/>
	                    </ItemCost>
	                </xsl:otherwise>
	            </xsl:choose>
	        </xsl:for-each>
	    </xsl:variable>
	    <xsl:variable name="subTotal" select="exslt:node-set($nodePoints)"/>
		<div class="card">
			<div class="header"> <!-- NAME -->
	            <div> <!-- CUSTOM NAME -->
	                <xsl:value-of select="@customName"/>
	            </div>
							<div>  <!-- SUBFACTION -->
								<xsl:value-of select="bs:selections/bs:selection/bs:categories/bs:category/@name"/>
							</div>
	            <div> <!-- POINTS -->
	                <xsl:value-of select="sum($subTotal/ItemCost) + bs:costs/bs:cost/@value"/>
	                 Points
	            </div>
	        </div>
			<div>
				<table class="unit" cellspacing="0">
		            <tr>
		                <th>
		                    Name
		                </th>
		                <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Model']" mode="header"/>
		            </tr>
		            <tr>
		                <td>
		                    <xsl:value-of select="@name"/>
		                </td>
		                <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Model']" mode="body"/>
		            </tr>
		        </table>
			</div>
			<div> <!-- WEAPONS -->
	            <xsl:variable name="weapons" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Weapon']"/>
	            <table class="weapons" cellspacing="0">
	                <tr>
	                    <xsl:for-each select="$weapons[1]">
	                        <th>
	                            <xsl:value-of select="@typeName"/>
	                        </th>
	                        <xsl:apply-templates mode="header"/>                    
	                    </xsl:for-each>
	                </tr>
	                <xsl:for-each select="$weapons">
	                    <tr>
	                        <td>
	                            <xsl:value-of select="@name"/>
	                        </td>
	                        <xsl:apply-templates mode="body"/>                    
	                    </tr>
	                </xsl:for-each>
	            </table>
	        </div>
	        <div> <!-- WARGEAR -->
	            <xsl:variable name="wargear" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Wargear']"/>
	            <table class="weapons" cellspacing="0">
	                <xsl:for-each select="$wargear">
	                    <tr>
	                        <td>
	                            <xsl:value-of select="@name"/>
	                        </td>
	                        <xsl:apply-templates mode="body"/>
	                    </tr>
	                </xsl:for-each>
	            </table>
	        </div>
	        <div> <!-- ABILITIES -->
				<div>
					<h2>Abilities</h2>				
				</div>
	            <xsl:variable name="abilities" select="bs:profiles/bs:profile[@typeName='Ability']"/>
	            <table cellspacing="0">
	                <xsl:for-each select="$abilities">
	                    <tr>
	                        <td>
	                            <xsl:value-of select="@name"/>
	                        </td>
	                        <xsl:apply-templates mode="body"/>
	                    </tr>
	                </xsl:for-each>
	            </table>
	        </div>
	        
	            <xsl:variable name="specialism" select="bs:selections/bs:selection[contains($specialisms, @name)]"/>
	            <xsl:if test="$specialism">
				<div class="specialism">
					<div>
						<h2>Specialism</h2>				
					</div>
					<div>
						<h2><xsl:value-of select="$specialism/@name"/></h2>
					</div>
	                <table cellspacing="0">
	                    <tr>
	                        <td>
	                            <xsl:value-of select="$specialism/bs:selections/bs:selection/bs:profiles/bs:profile/@name"/>
	                        </td>
	                            <xsl:apply-templates select="$specialism" mode="body"/>
	                            <!-- <xsl:value-of select="$specialism"/>                         -->
	                    </tr>
	                </table>
	        </div>

	            </xsl:if>
			<div class="exp">
				<div>Experience: <span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span><span>&#9744;</span></div>
				<div>Flesh Wounds: &#9744; &#9744; &#9744;</div>
				<div>Convalescence: &#9744;</div>
				<div>New Recruit: &#9744;</div>
			</div>
		</div>
	</xsl:template>
    <!-- endinject -->
	
    <xsl:template match="bs:characteristics/bs:characteristic" mode="header">
        <th>
            <xsl:value-of select="@name"/>
        </th>
    </xsl:template>
    <xsl:template match="bs:characteristics/bs:characteristic" mode="body">
        <td>
            <xsl:value-of select="."/>    
        </td>
    </xsl:template>

</xsl:stylesheet>