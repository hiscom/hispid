<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/" xmlns:dc="http://purl.org/dc/terms/">
	<xsl:import href="template-text.xsl"/>
	<xsl:import href="template-vocabulary.xsl"/>
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4" page-width="210mm" page-height="297mm" margin-left="20mm" margin-right="20mm" margin-top="10mm" margin-bottom="10mm">
					<fo:region-body region-name="body" margin-bottom="15mm" margin-top="10mm"/>
					<fo:region-before region-name="body-before" extent="10mm"/>
					<fo:region-after region-name="body-after" extent="15mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="Cover" page-width="210mm" page-height="297mm" margin-left="20mm" margin-right="20mm" margin-top="20mm" margin-bottom="10mm">
					<fo:region-body region-name="body" margin-bottom="10mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Cover" font-family="Arial, 'Arial Unicode MS', Courier" font-selection-strategy="character-by-character">
				<fo:flow flow-name="body">
						<xsl:call-template name="FrontCover"/>
				</fo:flow>
			</fo:page-sequence>
			<fo:page-sequence master-reference="A4" font-family="Arial, 'Arial Unicode MS', Courier" font-selection-strategy="character-by-character">
				<fo:flow flow-name="body">
						<xsl:call-template name="FrontMatter"/>
				</fo:flow>
			</fo:page-sequence>
			<fo:page-sequence master-reference="A4" font-family="Arial, 'Arial Unicode MS', Courier"  initial-page-number="1">
				<fo:static-content flow-name="body-before" >
					<fo:block border-bottom="thin #95B73D solid" color="#95B73D"> </fo:block>
				</fo:static-content>
				<fo:static-content flow-name="body-after">
					<fo:block text-align="center" border-top="thin #BFD9BF solid" color="#BFD9BF" font-size="8pt" padding-top="3mm"><fo:page-number  /></fo:block>
				</fo:static-content>
				<fo:flow flow-name="body">
					<!--<fo:block text-align="center" font-weight="bold" font-size="1.2em">Introduction</fo:block>-->
					<xsl:apply-templates select="document('Resources/Introduction.xml')/Content/child::node()"/>
					<!--<fo:block>
						<xsl:value-of select="//rdf:Description[1]/dcterms:provenance"/>
					</fo:block>-->
				</fo:flow>
			</fo:page-sequence>
			
			<fo:page-sequence master-reference="A4" font-family="Arial, 'Arial Unicode MS', Courier" font-selection-strategy="character-by-character">
				<fo:static-content flow-name="body-before" >
					<fo:block border-bottom="thin #BFD9BF solid" color="#BFD9BF">
						<fo:retrieve-marker retrieve-class-name="class" retrieve-position="first-including-carryover" retrieve-boundary="page-sequence"/>
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="body-after">
					<fo:block text-align="center" border-top="thin #BFD9BF solid" color="#BFD9BF" font-size="8pt" padding-top="3mm"><fo:page-number  /></fo:block>
				</fo:static-content>
				<fo:flow flow-name="body">
						<fo:block font-weight="bold" font-size="2em">Terms</fo:block>
						<xsl:apply-templates select="//rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2000/01/rdf-schema#Class']" mode="Class"/>
				</fo:flow>
			</fo:page-sequence>
			<fo:page-sequence master-reference="A4" font-family="Arial, 'Arial Unicode MS', Courier" font-selection-strategy="character-by-character">
				<fo:static-content flow-name="body-before" >
					<fo:block border-bottom="thin #BFD9BF solid" color="#BFD9BF">
						<fo:retrieve-marker retrieve-class-name="class" retrieve-position="first-including-carryover" retrieve-boundary="page-sequence"/>
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="body-after">
					<fo:block text-align="center" border-top="thin #BFD9BF solid" color="#BFD9BF" font-size="8pt" padding-top="3mm"><fo:page-number  /></fo:block>
				</fo:static-content>
				<fo:flow flow-name="body">
					<fo:block font-weight="bold" font-size="2em">Vocabularies</fo:block>
					<xsl:apply-templates select="document('Resources/Vocabularies-Combined.xml')//thesaurus"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template name="FrontCover">
		<fo:block> </fo:block>
		<fo:block font-size="2em" space-before="80mm">
			<xsl:value-of select="//rdf:Description[1]/dcterms:title"/>
		</fo:block>
		<fo:block  font-size="1.5em" space-before="25mm">
			<xsl:value-of select="//rdf:Description[1]/dcterms:creator"/>
		</fo:block>
		<fo:block font-size="1.5em" space-before="25mm">
			<xsl:value-of select="year-from-dateTime(//rdf:Description[1]/dcterms:modified)"/>
		</fo:block>
		<fo:block text-align="center" space-before="70mm">
			<fo:external-graphic src="url('Resources/CHAH-Logo.jpg')" scaling="uniform" width="40mm" content-height="scale-to-fit" content-width="scale-to-fit"/>
		</fo:block>
	</xsl:template>
	<xsl:template name="FrontMatter">
		<fo:block> </fo:block>
		<fo:block space-before="50mm">
			<xsl:text>Contributors: </xsl:text>
			<xsl:value-of select="//rdf:Description[1]/dcterms:contributor"/>
		</fo:block>
		<fo:block space-before="20mm">
			<xsl:text>Publisher: </xsl:text>
			<xsl:value-of select="//rdf:Description[1]/dcterms:publisher"/>
		</fo:block>
		<fo:block space-before="20mm">
			<xsl:variable name="vLicense" select="//rdf:Description[1]/dcterms:license"/>
			<xsl:choose>
				<xsl:when test="$vLicense='CC-BY 4.0'">
					<fo:block><fo:external-graphic src="url('Resources/cc-by.png')"/></fo:block>
					<fo:block>This work is licensed under a <fo:basic-link external-destination="http://creativecommons.org/licenses/by/4.0/" >Creative Commons Attribution 4.0 International License</fo:basic-link>.</fo:block></xsl:when>
				<xsl:otherwise><xsl:value-of select="//rdf:Description[1]/dcterms:license"/></xsl:otherwise>
			</xsl:choose>
		</fo:block>
		<fo:block space-before="20mm">
			<xsl:value-of select="//rdf:Description[1]/dcterms:bibliographicCitation"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="rdf:Description" mode="Class">
		<xsl:variable name="vClass" select="@rdf:about"/>
		<fo:block keep-with-next="always" font-weight="bold" space-before="2em" font-size="2em">
			<fo:marker marker-class-name="class">Class: <xsl:value-of select="rdfs:label"/></fo:marker>
			<xsl:text>Class: </xsl:text>
			<xsl:value-of select="rdfs:label"/>
		</fo:block>
		<fo:block>
			<fo:table space-before="0.5em" keep-together="always">
				<fo:table-column column-number="1" column-width="40mm"/> 
				<fo:table-column column-number="2" column-width="130mm"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">Identifier:</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block><xsl:value-of select="@rdf:about"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">Definition:</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block><xsl:value-of select="skos:definition"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">Defined by:</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block> <xsl:value-of  select="rdfs:isDefinedBy/@rdf:resource"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<!--<xsl:if test="skos:definition !=''">
			<fo:block>
				<xsl:value-of select="skos:definition"/>
			</fo:block>
		</xsl:if>-->
		<xsl:apply-templates select="//rdf:Description[dwcattributes:organizedInClass/@rdf:resource=$vClass]" mode="Property"/>
	</xsl:template>
	<xsl:template match="rdf:Description" mode="Property">
		<xsl:variable name="vNameSpace" select="rdfs:isDefinedBy/@rdf:resource"/>
		<xsl:variable name="vProperty" select="substring-after(@rdf:about, $vNameSpace)"/>
		<fo:table space-before="1.5em" margin-left="5mm" keep-together="always"><!-- border-top-style="solid" border-top-width="0.1em" border-bottom-style="solid" border-bottom-width="0.01em">-->
			<fo:table-column column-number="1" column-width="35mm"/> 
			<fo:table-column column-number="2" column-width="130mm"/> 
			<fo:table-body>
				<fo:table-row background-color="#E6F0E6">
					<fo:table-cell>
						<fo:block font-weight="bold" font-size="1.2em">Property</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block  font-size="1.2em"><xsl:value-of select="$vProperty"/></fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-weight="bold">Identifier</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block><xsl:value-of select="@rdf:about"/></fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-weight="bold">Label</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block><xsl:value-of select="rdfs:label"/></fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-weight="bold">Definition</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block><xsl:value-of select="skos:definition"/></fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-weight="bold">Namespace</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block><xsl:value-of select="rdfs:isDefinedBy/@rdf:resource"/></fo:block>
					</fo:table-cell>
				</fo:table-row>
				<xsl:if test="dwcattributes:abcdEquivalence!=''">
					<fo:table-row>
						<fo:table-cell>
							<fo:block  font-weight="bold">ABCD 2.06</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block><xsl:value-of select="dwcattributes:abcdEquivalence"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
				<xsl:if test="skos:scopeNote!=''">
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">Scope/Usage</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block><xsl:apply-templates select="skos:scopeNote"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
				<xsl:if test="skos:Note!=''">
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">Note</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block><xsl:apply-templates select="skos:Note"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
			</fo:table-body>
		</fo:table>	
	</xsl:template>	
	<xsl:template match="skos:scopeNote | skos:Note">
		<fo:block><xsl:value-of select="."/></fo:block>
	</xsl:template>
</xsl:stylesheet>
