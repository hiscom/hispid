<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:template match="Heading1">
		<fo:block font-weight="bold" font-size="1.5em" keep-with-next="always" space-before="6mm"><xsl:apply-templates /></fo:block>
	</xsl:template>
	<xsl:template match="Heading2">
		<fo:block font-weight="bold" font-size="1.2em" keep-with-next="always" space-before="4mm"><xsl:apply-templates /></fo:block>
	</xsl:template>
	<xsl:template match="Paragraph">
		<fo:block space-before="2mm"><xsl:apply-templates /></fo:block>
	</xsl:template>
	<xsl:template match="ul">
		<fo:list-block start-indent="5mm" provisional-distance-between-starts="10mm" space-before="2mm">
			<xsl:apply-templates/>
		</fo:list-block>
	</xsl:template>
	<xsl:template match="li">
		<fo:list-item>
			<fo:list-item-label end-indent="label-end()">
			</fo:list-item-label>
			<fo:list-item-body start-indent="body-start()">
				<fo:block>
					<xsl:apply-templates />
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
</xsl:stylesheet>
