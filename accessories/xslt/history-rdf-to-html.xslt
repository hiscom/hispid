<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
		xmlns:dcterms="http://purl.org/dc/terms/" 

>
		
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:variable name="nsHispid"><xsl:text>http://hiscom.chah.org.au/hispid/terms</xsl:text></xsl:variable>
	<xsl:variable name="base"><xsl:text>http://hiscom.chah.org.au/hispid/terms/history/#</xsl:text></xsl:variable>
	
		<xsl:template match="/">
			<xsl:result-document href="history/index.html">
				<html>
					<head>
						<title>HISPID terms history</title>
						<meta name="description" content=""/>
						<meta name="viewport" content="width=device-width, initial-scale=1"/>
				
						<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
						<style>
							body {
								padding-top: 50px;
								padding-bottom: 20px;
							}
						</style>
						<link href="../accessories/css/terms.css" rel="stylesheet" />
						<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>
						<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
						<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
						<script src="../accessories/js/terms.js"></script>
					</head>
					<body>
						<nav class="navbar navbar-inverse navbar-fixed-top">
						  <div class="container-fluid">
							<div class="navbar-header">
							  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							  </button>
								<a class="navbar-brand" href="#"><span class="logo">HISCOM</span></a>
							</div>
							<div id="navbar" class="navbar-collapse collapse"></div>
						  </div>
						</nav> <!-- /,navbar -->
					
						<a id="top"></a>
						<div class="jumbotron">
						  <div class="container-fluid">
							<h1 class="text-center">HISPID Review 2015 – legacy terms</h1>
						  </div>
						</div>
						
						<div class="container-fluid">
							<div class="row">
								<div class="col-md-12">
									<div class="concepts">
										<xsl:apply-templates select="rdf:RDF/rdf:Description" mode="concepts" />
									</div>
								</div>
							</div> <!-- /.row -->
							<hr/>
							<footer>
								<p class="text-right"><xsl:text disable-output-escaping="yes"><![CDATA[&copy;]]> Council of Heads of Australasian Herbaria (CHAH) 2015</xsl:text></p>
							</footer>
						</div> <!-- /..container-fluid -->
					</body>
				</html>
			</xsl:result-document>
		</xsl:template>
		
		<xsl:template match="rdf:Description" mode="concepts">
					<xsl:variable name="this" select="."/>
					<xsl:call-template name="processTerm">
						<xsl:with-param name="term" select="$this" />
					</xsl:call-template>
		</xsl:template>
		
		<xsl:template name="processTerm">
			<xsl:param name="term"/>
			<xsl:variable name="property" select="substring-after(@rdf:about, $base)"/>
			<xsl:variable name="termName" select="substring-before($property, '-')"/>
			<a id="{$property}"></a>
			<table class="table table-condensed table-bordered hispid-table">
				<thead>
					<tr>
						<th colspan="2"><h3><xsl:text>Term name: </xsl:text><xsl:value-of select="$termName" /></h3></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><xsl:text>Identifier</xsl:text></td>
						<td>
							<xsl:choose>
								<xsl:when test="skos:exactMatch/@rdf:about"><xsl:value-of select="skos:exactMatch/@rdf:about"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="@rdf:about"/></xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td><xsl:text>Namespace</xsl:text></td>
						<td><xsl:value-of select="rdfs:isDefinedBy/@rdf:resource"/></td>
					</tr>
					<tr>
						<td><xsl:text>Label</xsl:text></td>
						<td><xsl:value-of select="rdfs:label"/></td>
					</tr>
					<tr>
						<td><xsl:text>Definition</xsl:text></td>
						<td><xsl:value-of select="skos:definition"/></td>
					</tr>
					<tr>
						<td><xsl:text>Class</xsl:text></td>
						<td>
							<xsl:choose>
								<xsl:when test="dwcattributes:organizedInClass">
									<xsl:analyze-string select="dwcattributes:organizedInClass/@rdf:resource" regex="/([A-Za-z0-0]+)$">
										<xsl:matching-substring>
											<xsl:variable name="cl" select="regex-group(1)"/>
											<a href="#{$cl}"><xsl:value-of select="$cl"/></a>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:when>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td><xsl:text>ABCD 2.06</xsl:text></td>
						<td>
							<xsl:choose>
								<xsl:when test="dwcattributes:abcdEquivalence"><xsl:value-of select="dwcattributes:abcdEquivalence"/></xsl:when>
								<xsl:otherwise><xsl:text>Not in ABCD</xsl:text></xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td><xsl:text>Replaces</xsl:text></td>
						<td>
							<xsl:choose>
								<xsl:when test="dcterms:replaces">
									<xsl:analyze-string select="dcterms:replaces/@rdf:resource" regex="/([A-Za-z0-0]+)$">
										<xsl:matching-substring>
											<xsl:variable name="repl" select="regex-group(1)"/>
											<a href="#{$repl}"><xsl:value-of select="$repl"/></a>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:when>
							</xsl:choose>
						
						</td>
					</tr>
					
					<tr>
						<td><xsl:text>Usage</xsl:text></td>
						<td>
							<xsl:if test="skos:scopeNote">
								<xsl:for-each select="skos:scopeNote">
									<xsl:choose>
										<xsl:when test="starts-with(., 'Vocabulary')"></xsl:when>
										<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>
					
					<tr>
						<td><xsl:text>Vocabulary</xsl:text></td>
						<td>
							<xsl:if test="skos:scopeNote">
								<xsl:for-each select="skos:scopeNote">
									<xsl:choose>
										<xsl:when test="starts-with(., 'Vocabulary')">
											<xsl:variable name="vocab" select="substring-after(., 'Vocabulary: ')"/>
											<a href="{$vocab}"><xsl:value-of select="$vocab"/></a>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>
					
					<tr>
						<td><xsl:text>Examples</xsl:text></td>
						<td>
							<xsl:if test="skos:example">
								<xsl:for-each select="skos:example">
									<xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
									<xsl:if test="position() &lt; count(../skos:example)">
										<xsl:text>, </xsl:text>
									</xsl:if>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>
					
					<tr>
						<td><xsl:text>Comments</xsl:text></td>
						<td>
							<xsl:if test="skos:note">
								<xsl:for-each select="skos:note">
									<xsl:choose>
										<xsl:when test="starts-with(., 'GitHub')"></xsl:when>
										<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>

					<tr>
						<td><xsl:text>Discussion</xsl:text></td>
						<td>
							<xsl:if test="skos:note">
								<xsl:for-each select="skos:note">
									<xsl:choose>
										<xsl:when test="starts-with(., 'GitHub')">
											<xsl:variable name="github" select="substring-after(., 'GitHub: ')"/>
											<a href="{$github}"><xsl:value-of select="$github"/></a>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</td>
					</tr>
					
					<tr>
						<td><xsl:text>Date issued</xsl:text></td>
						<td><xsl:value-of select="dcterms:issued"/></td>
					</tr>

					<tr>
						<td><xsl:text>Date modified</xsl:text></td>
						<td><xsl:value-of select="dcterms:modified"/></td>
					</tr>

					<tr>
						<td class="col-xs-4 col-lg-3">For the geeks among us</td>
						<td class="col-xs-8 col-lg-9">
							<div class="rdf-properties">
								<xsl:for-each select="element()">
									<div class="row">
										<div class="dt col-md-4 col-lg-3"><xsl:value-of select="name()"></xsl:value-of></div>
										<xsl:choose>
											<xsl:when test="@rdf:resource">
												<div class="dd col-md-8 col-lg-9"><xsl:value-of select="@rdf:resource"></xsl:value-of></div>
											</xsl:when>
											<xsl:otherwise>
												<div class="dd col-md-8 col-lg-9"><xsl:value-of select="."></xsl:value-of></div>
											</xsl:otherwise>
										</xsl:choose>
									</div>
								</xsl:for-each>
							</div>
						
						</td>
					</tr>
				</tbody>
			</table>
			<xsl:text>&#xa;</xsl:text>
		</xsl:template>
</xsl:stylesheet>
