<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml file:///C:/www/hispid/terms/HISPID2015.xml?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/" xmlns:dcterms="http://purl.org/dc/terms/">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:variable name="nsRdf">
		<xsl:text>http://www.w3.org/1999/02/22-rdf-syntax-ns#</xsl:text>
	</xsl:variable>
	<xsl:variable name="nsRdfs">
		<xsl:text>http://www.w3.org/2000/01/rdf-schema#</xsl:text>
	</xsl:variable>
	<xsl:variable name="nsSkos">
		<xsl:text>http://www.w3.org/2004/02/skos/core#</xsl:text>
	</xsl:variable>
	<xsl:variable name="nsHispid">
		<xsl:text>http://hiscom.chah.org.au/hispid/terms/</xsl:text>
	</xsl:variable>
	<xsl:variable name="nsHispid5">
		<xsl:text>http://hiscom.chah.org.au/hispid/5/terms/</xsl:text>
	</xsl:variable>
	
	<xsl:template match="/">
		<xsl:result-document href="../terms.rdf">
			<rdf:RDF xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dc="http://purl.org/dc/elements/1.1/#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dwc="http://rs.tdwg.org/dwc/terms/#" xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/" xmlns:abcd="http://rs.tdwg.org/abcd/2.06/b/ABCD_2.06b.xsd#" xmlns:hispid5="http://hiscom.chah.org.au/hispid/5/terms/" xmlns:hispid4="http://hiscom.chah.org.au/hispid/4/terms/" xmlns:hispid3="http://hiscom.chah.org.au/hispid/3/terms/" xml:base="http://hiscom.chah.org.au/hispid/terms/">
				<rdf:Description rdf:about="http://hiscomchah.org.au/hispid/terms/">
					<dc:title>HISPID terms</dc:title>
					<rdfs:comment/>
					<dc:publisher>Herbarium Information Systems Committee (HISCOM), Australia</dc:publisher>
					<dcterms:publisher rdf:resource="http://hiscom.chah.org.au"/>
					<dc:modified>
						<xsl:value-of select="current-dateTime()"/>
					</dc:modified>
				</rdf:Description>
				<xsl:apply-templates select="hispid/terms/term"/>
			</rdf:RDF>
		</xsl:result-document>
	</xsl:template>
	
	
	<xsl:template match="term">
		<xsl:variable name="name" select="name"/>
		<rdf:Description rdf:about="{$name}">
			<xsl:variable name="type">
				<xsl:value-of select="type"/>
			</xsl:variable>
			<xsl:if test="label">
				<rdfs:label>
					<xsl:value-of select="label"/>
				</rdfs:label>
			</xsl:if>
			<rdf:type rdf:resource="{$nsRdf}{$type}"/>
			<skos:definition>
				<xsl:value-of select="definition"/>
			</skos:definition>
			<xsl:if test="status">
				<dwcattributes:status>
					<xsl:value-of select="status"/>
				</dwcattributes:status>
			</xsl:if>
			<!--xsl:if test="namespace != $nsHispid">
				<xsl:variable name="qualName">
					<xsl:value-of select="qualName"/>
				</xsl:variable>
				<skos:exactMatch rdf:resource="{$qualName}"/>
			</xsl:if-->
			<xsl:variable name="namespace">
				<xsl:value-of select="namespace"/>
			</xsl:variable>
			<rdfs:isDefinedBy rdf:resource="{$namespace}"/>
			<xsl:if test="issued">
				<dcterms:issued>
					<xsl:value-of select="issued"/>
				</dcterms:issued>
			</xsl:if>
			<xsl:if test="modified">
				<xsl:variable name="version">
					<xsl:value-of select="modified"/>
				</xsl:variable>
				<dcterms:modified>
					<xsl:value-of select="$version"/>
				</dcterms:modified>
				<xsl:if test="$namespace = $nsHispid">
					<dcterms:hasVersion rdf:resource="{$nsHispid}{$name}-{$version}"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="examples">
				<xsl:for-each select="examples/example">
					<skos:example>
						<xsl:value-of select="."/>
					</skos:example>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="abcd">
				<dwcattributes:abcdEquivalence>
					<xsl:value-of select="abcd"/>
				</dwcattributes:abcdEquivalence>
			</xsl:if>
			<xsl:if test="replaces">
				<xsl:for-each select="replaces/term">
					<xsl:variable name="replTerm" select="."/>
					<dcterms:replaces rdf:resource="{$nsHispid}{$replTerm}-hispid5"/>
				</xsl:for-each>
				<!--xsl:if test="contains(hispid4, ' ') = false()">
					<xsl:variable name="hispid4"><xsl:value-of select="hispid4" /></xsl:variable>
					<dcterms:replaces rdf:resource="{$nsHispid5}/{$hispid4}"/>
				</xsl:if-->
			</xsl:if>
			<xsl:if test="usage">
				<skos:scopeNote>
					<xsl:value-of select="usage"/>
				</skos:scopeNote>
			</xsl:if>
			<xsl:if test="vocabulary">
				<skos:scopeNote>
					<xsl:text>Vocabulary: </xsl:text>
					<xsl:value-of select="vocabulary"/>
				</skos:scopeNote>
			</xsl:if>
			<xsl:if test="comments">
				<skos:note>
					<xsl:value-of select="comments"/>
				</skos:note>
			</xsl:if>
			<xsl:if test="gitHub">
				<skos:note>
					<xsl:text>GitHub: </xsl:text>
					<xsl:value-of select="gitHub"/>
				</skos:note>
			</xsl:if>
			<xsl:if test="inClass">
				<xsl:variable name="inClass">
					<xsl:value-of select="substring-after(inClass, $nsHispid)"/>
				</xsl:variable>
				<dwcattributes:organizedInClass rdf:resource="{$inClass}"/>
			</xsl:if>
		</rdf:Description>
	</xsl:template>
</xsl:stylesheet>
