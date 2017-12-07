<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:keycloak="urn:jboss:domain:keycloak-server:1.1">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="//keycloak:subsystem">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
				<providers>
					<provider>
						classpath:/opt/eap/providers/*
					</provider>
				</providers>            
        </xsl:copy>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>