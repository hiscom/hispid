<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dwcattributes="http://rs.tdwg.org/dwc/terms/attributes/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:dcterms="http://purl.org/dc/terms/">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="nsHispid">
		<xsl:text>http://hiscom.chah.org.au/hispid/terms</xsl:text>
	</xsl:variable>
	
	
	<xsl:template match="/">
		<xsl:result-document href="index.html">
			<html>
				<head>
					<title>HISPID terms</title>
					<meta name="description" content=""/>
					<meta name="viewport" content="width=device-width, initial-scale=1"/>
					<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
					<style>
							body {
								padding-top: 50px;
								padding-bottom: 20px;
							}
						</style>
					<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>
					<link rel="stylesheet" href="acessories/css/terms.css" rel="stylesheet"/>
					<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"/>
					<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"/>
					<script src="accessories/js/terms.js"/>
				</head>
				<body>
					<nav class="navbar navbar-inverse navbar-fixed-top">
						<div class="container-fluid">
							<div class="navbar-header">
								<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
									<span class="sr-only">Toggle navigation</span>
									<span class="icon-bar"/>
									<span class="icon-bar"/>
									<span class="icon-bar"/>
								</button>
								<a class="navbar-brand" href="#">
									<span class="logo">HISCOM</span>
								</a>
							</div>
							<div id="navbar" class="navbar-collapse collapse"/>
						</div>
					</nav>
					<!-- /,navbar -->
					<a id="top"/>
					<div class="jumbotron">
						<div class="container-fluid">
							<h1 class="text-center">HISPID Review 2015</h1>
						</div>
					</div>
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-3 sidebar" id="sidebar">
								<ul class="nav nav-sidebar toc">
									<li>
										<a href="#RecordLevelTerms">Record level terms</a>
										<ul>
											<xsl:apply-templates select="rdf:RDF/rdf:Description" mode="rlt-toc"/>
										</ul>
									</li>
									<xsl:apply-templates select="rdf:RDF/rdf:Description" mode="toc"/>
								</ul>
							</div>
							<!-- /.sidebar -->
							<div class="col-md-9">
								<div class="toc2">
									<div class="text-right">
										<label>
											<input type="checkbox" id="show-ns" value="1"/> Show namespaces
											</label>
									</div>
									<h2>
										<a href="#RecordLevelTerms">Record level terms</a>
									</h2>
									<p>
										<xsl:apply-templates select="rdf:RDF/rdf:Description" mode="rlt-toc2"/>
									</p>
									<xsl:apply-templates select="rdf:RDF/rdf:Description" mode="toc2"/>
								</div>
								<div class="concepts">
									<xsl:call-template name="rlterms"/>
									<xsl:apply-templates select="rdf:RDF/rdf:Description" mode="concepts"/>
								</div>
							</div>
						</div>
						<!-- /.row -->
						<hr/>
						<footer>
							<p class="text-right">
								<xsl:text disable-output-escaping="yes"><![CDATA[&copy;]]> Council of Heads of Australasian Herbaria (CHAH) 2015</xsl:text>
							</p>
						</footer>
					</div>
					<!-- /..container-fluid -->
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>
	
	
	<xsl:template match="rdf:Description" mode="rlt-toc">
		<xsl:if test="contains(rdf:type/@rdf:resource, '#Property')">
			<xsl:choose>
				<xsl:when test="dwcattributes:organizedInClass"/>
				<xsl:otherwise>
					<xsl:variable name="property">
						<xsl:choose>
							<xsl:when test="starts-with(@rdf:about, 'http://')">
								<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
									<xsl:matching-substring>
										<xsl:value-of select="regex-group(1)"/>
									</xsl:matching-substring>
								</xsl:analyze-string>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@rdf:about"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<li>
						<a href="#{$property}">
							<xsl:value-of select="$property"/>
						</a>
					</li>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="rdf:Description" mode="toc">
		<xsl:if test="contains(rdf:type/@rdf:resource, '#Class')">
			<xsl:variable name="class">
				<xsl:choose>
					<xsl:when test="starts-with(@rdf:about, 'http://')">
						<!-- xsl:value-of select="substring-after(@rdf:about, concat($nsHispid, '/'))"/ -->
						<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
							<xsl:matching-substring>
								<xsl:value-of select="regex-group(1)"/>
							</xsl:matching-substring>
						</xsl:analyze-string>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@rdf:about"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<li>
				<a href="#{$class}">
					<xsl:value-of select="$class"/>
				</a>
				<ul>
					<xsl:for-each select="../rdf:Description">
						<xsl:variable name="property">
							<xsl:choose>
								<xsl:when test="starts-with(@rdf:about, 'http://')">
									<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
										<xsl:matching-substring>
											<xsl:value-of select="regex-group(1)"/>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@rdf:about"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:if test="contains(dwcattributes:organizedInClass/@rdf:resource, $class)">
							<li>
								<a href="#{$property}">
									<xsl:value-of select="$property"/>
								</a>
							</li>
						</xsl:if>
					</xsl:for-each>
				</ul>
			</li>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="rdf:Description" mode="rlt-toc2">
		<xsl:if test="contains(rdf:type/@rdf:resource, '#Property')">
			<xsl:choose>
				<xsl:when test="dwcattributes:organizedInClass"/>
				<xsl:otherwise>
					<xsl:variable name="property">
						<xsl:choose>
							<xsl:when test="starts-with(@rdf:about, 'http://')">
								<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
									<xsl:matching-substring>
										<xsl:value-of select="regex-group(1)"/>
									</xsl:matching-substring>
								</xsl:analyze-string>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@rdf:about"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="ns" select="rdfs:isDefinedBy/@rdf:resource"/>
					<a href="#{$property}" data-namespace="{$ns}">
						<xsl:value-of select="$property"/>
					</a>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="rdf:Description" mode="toc2">
		<xsl:if test="contains(rdf:type/@rdf:resource, '#Class')">
			<xsl:variable name="class">
				<xsl:choose>
					<xsl:when test="starts-with(@rdf:about, 'http://')">
						<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
							<xsl:matching-substring>
								<xsl:value-of select="regex-group(1)"/>
							</xsl:matching-substring>
						</xsl:analyze-string>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@rdf:about"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<h2>
				<a href="#{$class}">
					<xsl:value-of select="$class"/>
				</a>
			</h2>
			<p>
				<xsl:for-each select="../rdf:Description">
					<xsl:if test="contains(dwcattributes:organizedInClass/@rdf:resource, $class)">
						<xsl:variable name="property">
							<xsl:choose>
								<xsl:when test="starts-with(@rdf:about, 'http://')">
									<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
										<xsl:matching-substring>
											<xsl:value-of select="regex-group(1)"/>
										</xsl:matching-substring>
									</xsl:analyze-string>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@rdf:about"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="ns" select="rdfs:isDefinedBy/@rdf:resource"/>
						<a href="#{$property}" data-namespace="{$ns}">
							<xsl:value-of select="$property"/>
						</a>
					</xsl:if>
				</xsl:for-each>
			</p>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template name="rlterms">
		<h2>
			<a id="RecordLevelTerms"/>
			<xsl:text>Record Level Terms</xsl:text>
		</h2>
		<xsl:for-each select="//rdf:Description">
			<xsl:if test="contains(rdf:type/@rdf:resource, '#Property')">
				<xsl:choose>
					<xsl:when test="dwcattributes:organizedInClass"/>
					<xsl:otherwise>
						<xsl:variable name="this" select="."/>
						<xsl:call-template name="processTerm">
							<xsl:with-param name="term" select="$this"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	
	<xsl:template match="rdf:Description" mode="concepts">
		<xsl:if test="contains(rdf:type/@rdf:resource, '#Class')">
			<xsl:variable name="this" select="."/>
			<xsl:call-template name="processTerm">
				<xsl:with-param name="term" select="$this"/>
			</xsl:call-template>
			<xsl:variable name="class">
				<xsl:choose>
					<xsl:when test="starts-with(@rdf:about, 'http://')">
						<xsl:analyze-string select="@rdf:about" regex="[/|#]([A-Za-z0-9]+)$">
							<xsl:matching-substring>
								<xsl:value-of select="regex-group(1)"/>
							</xsl:matching-substring>
						</xsl:analyze-string>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@rdf:about"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:for-each select="../rdf:Description">
				<xsl:variable name="this" select="."/>
				<xsl:if test="ends-with(rdf:type/@rdf:resource, '#Property')">
					<xsl:if test="ends-with(dwcattributes:organizedInClass/@rdf:resource, $class)">
						<xsl:call-template name="processTerm">
							<xsl:with-param name="term" select="$this"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template name="processTerm">
		<xsl:param name="term"/>
		<xsl:variable name="property">
			<xsl:choose>
				<xsl:when test="starts-with($term/@rdf:about, 'http://')">
					<!--xsl:value-of select="substring-after(@rdf:about, concat($nsHispid, '/'))"/-->
					<xsl:analyze-string select="$term/@rdf:about" regex="/([A-Za-z0-9]+)$">
						<xsl:matching-substring>
							<xsl:value-of select="regex-group(1)"/>
						</xsl:matching-substring>
					</xsl:analyze-string>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$term/@rdf:about"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<a id="{$property}"/>
		<table class="table table-condensed table-bordered hispid-table">
			<thead>
				<tr>
					<th colspan="2">
						<xsl:choose>
							<xsl:when test="contains(rdf:type/@rdf:resource, '#Property')">
								<h3>
									<xsl:text>Property: </xsl:text>
									<xsl:value-of select="$property"/>
								</h3>
							</xsl:when>
							<xsl:otherwise>
								<h2>
									<xsl:text>Class: </xsl:text>
									<xsl:value-of select="$property"/>
								</h2>
							</xsl:otherwise>
						</xsl:choose>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<xsl:text>Identifier</xsl:text>
					</td>
					<td>
						<!--xsl:choose>
							<xsl:when test="skos:exactMatch">
								<xsl:value-of select="skos:exactMatch/@rdf:resource"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@rdf:about"/>
							</xsl:otherwise>
						</xsl:choose-->
						<xsl:choose>
							<xsl:when test="starts-with(@rdf:about, 'http://')">
								<xsl:value-of select="@rdf:about"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="rdfs:isDefinedBy/@rdf:resource"/><xsl:value-of select="@rdf:about"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Namespace</xsl:text>
					</td>
					<td>
						<xsl:value-of select="rdfs:isDefinedBy/@rdf:resource"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Label</xsl:text>
					</td>
					<td>
						<xsl:value-of select="rdfs:label"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Definition</xsl:text>
					</td>
					<td>
						<xsl:value-of select="skos:definition"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Class</xsl:text>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="dwcattributes:organizedInClass">
								<xsl:analyze-string select="dwcattributes:organizedInClass/@rdf:resource" regex="/([A-Za-z0-9]+)$">
									<xsl:matching-substring>
										<xsl:variable name="cl" select="regex-group(1)"/>
										<a href="#{$cl}">
											<xsl:value-of select="$cl"/>
										</a>
									</xsl:matching-substring>
								</xsl:analyze-string>
							</xsl:when>
							<xsl:when test="contains(rdf:type/@rdf:resource, '#Property')">
								<xsl:text>all</xsl:text>
							</xsl:when>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>ABCD 2.06</xsl:text>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="dwcattributes:abcdEquivalence">
								<xsl:value-of select="dwcattributes:abcdEquivalence"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Not in ABCD</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Replaces</xsl:text>
					</td>
					<td>
						<xsl:if test="dcterms:replaces">
							<xsl:for-each select="dcterms:replaces">
								<xsl:analyze-string select="@rdf:resource" regex="/([A-Za-z0-0]+)-hispid5$">
									<xsl:matching-substring>
										<xsl:variable name="repl" select="regex-group(1)"/>
										<a href="history/#{$repl}-hispid5">
											<xsl:value-of select="$repl"/>
										</a>
									</xsl:matching-substring>
								</xsl:analyze-string>
								<xsl:if test="position() &lt; count(../dcterms:replaces)">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Usage</xsl:text>
					</td>
					<td>
						<xsl:if test="skos:scopeNote">
							<xsl:for-each select="skos:scopeNote">
								<xsl:choose>
									<xsl:when test="starts-with(., 'Vocabulary')"/>
									<xsl:otherwise>
										<xsl:value-of select="."/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Vocabulary</xsl:text>
					</td>
					<td>
						<xsl:if test="skos:scopeNote">
							<xsl:for-each select="skos:scopeNote">
								<xsl:choose>
									<xsl:when test="starts-with(., 'Vocabulary')">
										<xsl:variable name="vocab" select="substring-after(., 'Vocabulary: ')"/>
										<a href="{$vocab}">
											<xsl:value-of select="$vocab"/>
										</a>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Examples</xsl:text>
					</td>
					<td>
						<xsl:if test="skos:example">
							<xsl:for-each select="skos:example">
								<xsl:text>"</xsl:text>
								<xsl:value-of select="."/>
								<xsl:text>"</xsl:text>
								<xsl:if test="position() &lt; count(../skos:example)">
									<xsl:text>, </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Comments</xsl:text>
					</td>
					<td>
						<xsl:if test="skos:note">
							<xsl:for-each select="skos:note">
								<xsl:choose>
									<xsl:when test="starts-with(., 'GitHub')"/>
									<xsl:otherwise>
										<xsl:value-of select="."/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Discussion</xsl:text>
					</td>
					<td>
						<xsl:if test="skos:note">
							<xsl:for-each select="skos:note">
								<xsl:choose>
									<xsl:when test="starts-with(., 'GitHub')">
										<xsl:variable name="github" select="substring-after(., 'GitHub: ')"/>
										<a href="{$github}">
											<xsl:value-of select="$github"/>
										</a>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Date issued</xsl:text>
					</td>
					<td>
						<xsl:value-of select="dcterms:issued"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Date modified</xsl:text>
					</td>
					<td>
						<xsl:value-of select="dcterms:modified"/>
					</td>
				</tr>
				<tr>
					<td class="col-xs-4 col-lg-3">For the geeks among us</td>
					<td class="col-xs-8 col-lg-9">
						<div class="rdf-properties">
							<div class="row">
								<div class="dt col-md-4 col-lg-3">(rdf:about)</div>
								<div class="dd col-md-8 col-lg-9">
									<xsl:value-of select="@rdf:about"/>
								</div>
							</div>
							<xsl:for-each select="element()">
								<div class="row">
									<div class="dt col-md-4 col-lg-3">
										<xsl:value-of select="name()"/>
									</div>
									<div class="dd col-md-8 col-lg-9">
										<xsl:choose>
											<xsl:when test="@rdf:resource">
												<xsl:value-of select="@rdf:resource"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</div>
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
