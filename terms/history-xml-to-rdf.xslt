<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
	xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/" 
	xmlns:dcterms="http://purl.org/dc/terms/" 
	>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:variable name="nsRdf"><xsl:text>http://www.w3.org/1999/02/22-rdf-syntax-ns#</xsl:text></xsl:variable>
	<xsl:variable name="nsRdfs"><xsl:text>http://www.w3.org/2000/01/rdf-schema#</xsl:text></xsl:variable>
	<xsl:variable name="nsSkos"><xsl:text>http://www.w3.org/2004/02/skos/core#</xsl:text></xsl:variable>
	<xsl:variable name="nsHispid"><xsl:text>http://hiscom.chah.org.au/hispid/terms</xsl:text></xsl:variable>
	<xsl:variable name="nsHispid5"><xsl:text>http://hiscom.chah.org.au/hispid/5/terms</xsl:text></xsl:variable>
	<xsl:variable name="base"><xsl:text>http://hiscom.chah.org.au/hispid/terms/history/#</xsl:text></xsl:variable>

	<xsl:template match="/">
		<xsl:result-document href="hispidtermshistory.rdf">
			<rdf:RDF
				xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
				xmlns:owl="http://www.w3.org/2002/07/owl#" 
				xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
				xmlns:dc="http://purl.org/dc/elements/1.1/#" 
				xmlns:dcterms="http://purl.org/dc/terms/" 
				xmlns:dwc="http://rs.tdwg.org/dwc/terms/#" 
				xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/" 
				xmlns:abcd="http://rs.tdwg.org/abcd/2.06/b/ABCD_2.06b.xsd#" 
				xmlns:hispid5="http://hiscom.chah.org.au/hispid/5/terms/" 
				xmlns:hispid4="http://hiscom.chah.org.au/hispid/4/terms/" 
				xmlns:hispid3="http://hiscom.chah.org.au/hispid/3/terms/" 
				xml:base="http://hiscom.chah.org.au/hispid/terms/history/#" >
				
				<rdf:Description rdf:about="http://hiscom.chah.org.au/hispid/terms/history#">
					<dc:title>HISPID terms</dc:title>
					<rdfs:comment></rdfs:comment>
					<dc:publisher>Herbarium Information Systems Committee (HISCOM), Australia</dc:publisher>
					<dcterms:publisher rdf:resource="http://hiscom.chah.org.au"/>
					<dc:modified><xsl:value-of select="current-dateTime()"/></dc:modified>
				</rdf:Description>
				
				<xsl:apply-templates select="//term" />
			</rdf:RDF>
		</xsl:result-document>
	</xsl:template>

<xsl:template match="term">
	<xsl:variable name="about" select="name"/>
	<xsl:variable name="version" select="version"/>
	<rdf:Description rdf:about="{$base}{$about}-{$version}">
		<rdf:type rdf:resource="http://www.w3.org/1999/02/22-rdf-syntax-ns#Property"/>
		<dcterms:hasVersion rdf:resource="{$about}-{$version}"/>
		<rdfs:label><xsl:value-of select="label"/></rdfs:label>
	</rdf:Description>
	
</xsl:template>

</xsl:stylesheet>
