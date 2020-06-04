<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ce="http://www.elsevier.com/xml/common/dtd" 
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:els1="http://www.elsevier.com/xml/ja/dtd"    
    xmlns:els2="http://www.elsevier.com/xml/cja/dtd"
    xmlns:s1="http://www.elsevier.com/xml/si/dtd"
    xmlns:wiley="http://www.wiley.com/namespaces/wiley"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">
    
    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:param name="datecreation"/>
    <xsl:param name="rawfulltextpath"/>
    
    <xsl:include href="Imports.xsl"/>

    <xsl:include href="SpringerCommon.xsl"/>
    <xsl:include href="SpringerStage2.xsl"/>
    <xsl:include href="SpringerStage3.xsl"/>
    <xsl:include href="SpringerBookChapter.xsl"/>
	
    <xsl:template match="/">
        <xsl:choose> 
            <xsl:when test="Article/ArticleInfo">
                <xsl:message>Converting a Springer stage 2 article</xsl:message>
            </xsl:when>
            <xsl:when test="Publisher/PublisherInfo and not(Publisher/Series/Book/descendant::Chapter)">
                <xsl:message>Converting a Springer stage 3 article</xsl:message>
            </xsl:when>
            <xsl:when test="count(Publisher/Series/Book/descendant::Chapter)=1">
                <xsl:message>Converting a Springer book chapter</xsl:message>
            </xsl:when>
            <!-- RL: vérif encore très stricte pour le nouveau cas -->
            <xsl:when test="(
                               contains(/article/article-metadata/article-data/copyright, 'IOP')
                            or contains(/article/article-metadata/jnl-data/jnl-imprint, 'IOP')
                            or contains(/article/article-metadata/jnl-data/jnl-imprint, 'Institute of Physics')
                            )
                            and /article/article-metadata/article-data/article-type[@sort='regular']">
                <xsl:message>Converting an IOP regular article</xsl:message>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:message>Converting a non-identified article: - name: <xsl:value-of
                        select="name(*)"/> - local-name: <xsl:value-of select="local-name(*)"/> -
                    namespace-uri: <xsl:value-of select="namespace-uri(*)"/>
                </xsl:message>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
