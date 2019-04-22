<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8" standalone="no" media-type="text/html" />
    <xsl:param name="productIdentifier" select="'AMQ Online'"/>
    <xsl:param name="licenseAdviceText" select="'The following material has been provided for informational purposes only, and should not be relied upon or construed as a legal opinion or legal advice.'"/>
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz '" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ!'" />

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
                <style>
                    table {
                    border-collapse: collapse;
                    }

                    table, th, td {
                    border: 1px solid navy;
                    }

                    th {
                    text-align: left;
                    background-color: #BCC6CC;

                    }

                    th, td {
                    padding: 2px;
                    text-align: left;
                    }

                    tr:nth-child(even) {
                    background-color: #f2f2f2;
                    }
                </style>
            </head>
            <body>
                <h2><xsl:value-of select="$productIdentifier"/></h2>
                <xsl:if test="$licenseAdviceText">
                    <p><xsl:value-of select="$licenseAdviceText"/></p>
                </xsl:if>
                <table>
                    <tr>
                        <th>Package Name</th>
                        <th>Package Version</th>
                        <th>Local Licenses</th>
                    </tr>
                    <xsl:apply-templates select="//dependencies/dependency">
                        <xsl:sort select="packageName"/>
                    </xsl:apply-templates>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="dependency">
        <tr>
            <td>
                <xsl:value-of select="packageName"/>
            </td>
            <td>
                <xsl:value-of select="version"/>
            </td>
            <td>
                <xsl:for-each select="licenses/license">
                    <xsl:choose>
                        <xsl:when test="name = 'Public Domain'">
                            <xsl:value-of select="name"/>
                            <br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <a href="{./url}">
                                <xsl:value-of select="name"/>
                            </a>
                            <br/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </td>
        </tr>

    </xsl:template>
</xsl:stylesheet>
