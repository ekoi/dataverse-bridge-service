<!--

    Copyright (C) 2018 DANS - Data Archiving and Networked Services (info@dans.knaw.nl)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://da-ra.de/schema/kernel-4">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="dvnJson"/>

    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template name="initialTemplate">
        <xsl:apply-templates select="json-to-xml($dvnJson)"/>
    </xsl:template>

    <xsl:template match="/" xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
         
        <resource>
            <resourceType>Collection</resourceType>
            <xsl:call-template name="resourceIdentifier"/>
            <xsl:call-template name="titles"/>
            <xsl:call-template name="creators"/>
            <xsl:call-template name="dataURLs"/>
            <xsl:call-template name="doiProposal"/>
            <xsl:call-template name="publicationDate"/>
            <xsl:call-template name="rights"/>
            <xsl:call-template name="resourceLanguage"/>
            <xsl:call-template name="freeKeywords"/>
            <xsl:call-template name="descriptions"/>
            <xsl:call-template name="dataSets"/>
            <xsl:call-template name="publications"/>
             
      
        </resource>
    </xsl:template>
 
    
    <xsl:template name="resourceIdentifier"  match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <xsl:variable name="versionStateR" select="map[1]/map[1]/map[1]/string[@key='versionState']"/>
        <xsl:choose>
            <xsl:when  test="$versionStateR = 'RELEASED'">
                <resourceIdentifier>
                    <identifier>
                        <xsl:value-of select="map[1]/map[1]/string[@key='identifier']"/>
                    </identifier>
                    <xsl:variable name="versionNumber" select="map[1]/map[1]/map[1]/number[@key='versionNumber']"/>
                    <xsl:variable name="versionMinorNumber" select="map[1]/map[1]/map[1]/number[@key='versionMinorNumber']"/>
                    <currentVersion>
                        <xsl:value-of select="concat($versionNumber, '.', $versionMinorNumber)"/>
                    </currentVersion>
                </resourceIdentifier>
            </xsl:when>
            <xsl:otherwise>
                <resourceIdentifier>
                    <identifier>
                        <xsl:value-of select="map[1]/map[1]/number[@key='id']"/>
                    </identifier>
                </resourceIdentifier>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="titles" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <titles>
            <title>
                <language>en</language>
                <titleName>
                    <xsl:value-of select="//array[@key='fields']/map[1]/string[@key='value']/."/>
                </titleName>
            </title>
        </titles>
    </xsl:template>
    <xsl:template name="creators" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <creators>
            <creator>
                <person>
                    <xsl:variable name="name" select="tokenize(//array[1]/map[2]/array[1]/map[1]/map[1]/string[3], ',')"/>
                    <firstName>
                        <xsl:value-of select="$name[2]"/>
                    </firstName>
                    <lastName>
                        <xsl:value-of select="$name[1]"/>
                    </lastName>
                </person>
            </creator>
            <creator>
                <institution>
                    <institutionName>
                        <xsl:value-of select="//array[1]/map[2]/array[1]/map[1]/map[2]/string[3]"/>
                    </institutionName>
                </institution>
            </creator>
        </creators>
    </xsl:template>
   
    <xsl:template name="dataURLs" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <dataURLs>
            <dataURL>
                <xsl:value-of select="//map[@key='data']/string[@key='persistentUrl']"/>
            </dataURL>
        </dataURLs>
    </xsl:template>
    
    <xsl:template name="doiProposal" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <xsl:variable name="AuthoriyValue" select="map[1]/map[1]/string[@key='authority']"/>
        <xsl:variable name="identifier" select="map[1]/map[1]/string[@key='identifier']"/>
        <doiProposal>
            <xsl:value-of select="concat($AuthoriyValue, '/', $identifier)"/>
        </doiProposal>
    </xsl:template>

    <xsl:template name="publicationDate" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <xsl:variable name="versionStateR" select="/map/map[@key='data']/string[@key='versionState']/."/>
        <xsl:if test="$versionStateR = 'RELEASED'">
            <publicationDate>
                <date>
                    <xsl:value-of select="map[1]/map[1]/string[@key='publicationDate']"/>
                </date>
            </publicationDate>
        </xsl:if>
        <xsl:if test="$versionStateR = 'DRAFT'">
            <publicationDate>
                <date>
                    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]')"/>
                </date>
            </publicationDate>
        </xsl:if>
    </xsl:template>
    <xsl:template name="rights" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <xsl:variable name="versionStateR" select="map[1]/map[1]/map[1]/string[@key='versionState']"/>
        <xsl:if  test="$versionStateR = 'RELEASED'">
            <rights>
                <licenseType> 
                    <xsl:value-of select="map[1]/map[1]/map[1]/string[@key='license']"/>
                </licenseType>
                <right>
                    <language>en</language>
                    <freetext>
                        <xsl:value-of select="map[1]/map[1]/map[1]/string[@key='termsOfAccess']"/>
                    </freetext>
                </right>
            </rights>
        </xsl:if>
    </xsl:template>
  
    <xsl:template name="resourceLanguage" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <resourceLanguage>eng</resourceLanguage>
    </xsl:template>
   
   
    <xsl:template name="freeKeywords" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <freekywords>
            <language>eng</language>
            <keywordSchema>null</keywordSchema>
            <keywords>
                <xsl:for-each select="//array[1]/map[6]/array[1]/map[*]/map[@key='keywordValue']">
                    <keyword>
                        <xsl:value-of select="string[3]"/>
                    </keyword>
                </xsl:for-each>
            </keywords>
        </freekywords>
    </xsl:template>

    <xsl:template name="descriptions" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <descriptions>
            <description>
                <language>en</language>
                <freetext>
                    <xsl:value-of select="//array[1]/map[4]/array[1]/map[1]/map[1]/string[3]"/>
                </freetext>
                <descriptionType>Abstract</descriptionType>
            </description>
        </descriptions>
    </xsl:template>
    <xsl:template name="dataSets" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <dataSets>
            <xsl:for-each select="//array[@key='files']/map[*]">
                <dataSet>
                    <files>
                        <file>
                            <name>
                                <xsl:value-of select="map[@key='dataFile']/string[@key='filename']"/>
                            </name>
                            <format>
                                <xsl:value-of select="map[@key='dataFile']/string[@key='contentType']"/>
                            </format>
                            <size>
                                <xsl:value-of select="map[@key='dataFile']/number[@key='filesize']"/>
                            </size>
                        </file>
                    </files>
                </dataSet>
            </xsl:for-each>
        </dataSets>
    </xsl:template>
        
    <xsl:template name="publications" match="." xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
        <publications>
            <xsl:for-each select="//array[1]/map[7]/array[1]/map[*]">
                <publication>
                    <unstructuredPublication>
                        <freetext>
                            <xsl:value-of select="map[@key='publicationCitation']/string[@key='value']"/>
                        </freetext>
                        <PIDs>
                            <PID>
                                <xsl:variable name="pubIDNumber" select="tokenize(map[@key='publicationIDNumber']/string[@key='value'], '/')"/>
                                <ID>
                                    <xsl:value-of select="$pubIDNumber[2]"/>
                                </ID>
                                <pidType>
                                    <xsl:value-of select="map[@key='publicationIDType']/string[@key='value']"/>
                                </pidType>
                            </PID>
                                
                        </PIDs>

                    </unstructuredPublication>
                </publication>
            </xsl:for-each>
        </publications>
    </xsl:template>
    
</xsl:stylesheet>
