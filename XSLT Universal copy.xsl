<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sap="http://www.sap.com/sapxsl" version="1.0">
  <xsl:strip-space elements="*"/> 
  <xsl:template match="/">
  
        <xsl:for-each select="ORDERS05/IDOC/*">
          <xsl:element name="{name()}">
            <xsl:call-template name="segmentFields"/>
          </xsl:element>
          
  </xsl:template>
  <!-- create Idoc segment with all fields -->
  <xsl:template name="segmentFields">
    <xsl:for-each select="attribute::node()">
      <xsl:attribute name="{name()}">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:for-each>
    <xsl:for-each select="*[count(child::*)=0]">
      <xsl:element name="{name()}">
        <xsl:value-of select="."/>
      </xsl:element>
    </xsl:for-each>
    <xsl:for-each select="*[count(child::*)&gt;0]">
      <xsl:element name="{name()}">
        <xsl:call-template name="segmentFields"/>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
</xsl:transform>            