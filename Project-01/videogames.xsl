<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
<head>
    <title>Video Game Catalog</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #1a1a1a; color: #eee; padding: 40px; }
        h1 { text-align: center; color: #f9ca24; text-transform: uppercase; letter-spacing: 2px; }
        .container { display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; margin-top: 30px; }
        
        .card { background: #2d2d2d; border-radius: 12px; padding: 20px; width: 220px; 
                box-shadow: 0 10px 20px rgba(0,0,0,0.3); border: 1px solid #444; transition: 0.3s; }
        .card:hover { transform: translateY(-5px); border-color: #f9ca24; }
        
        .title { font-size: 1.1em; font-weight: bold; color: #fff; margin-bottom: 10px; height: 45px; overflow: hidden; }
        .points { font-size: 1.4em; font-weight: bold; margin-bottom: 10px; }
        
        .excellent { color: #f9ca24; text-shadow: 0 0 5px rgba(249, 202, 36, 0.5); } /* Gold */
        .good { color: #6ab04c; }
        .regular { color: #f0932b; }
        .bad { color: #eb4d4b; }
        
        .info { font-size: 0.85em; color: #bbb; line-height: 1.6; border-top: 1px solid #444; pt: 10px; margin-top: 10px; }
        .platform-icon { font-size: 1.2em; margin-right: 5px; }
        .price { font-weight: bold; color: #fff; display: block; margin-top: 5px; font-size: 1.1em; }
    </style>
</head>
<body>
    <h1>🎮 Video Game Catalog 🎮</h1>
    <div class="container">
        <xsl:for-each select="catalog/game">
            <xsl:sort select="score" data-type="number" order="descending"/>
            
            <div class="card">
                <div class="title"><xsl:value-of select="title"/></div>
                
                <div class="points">
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="score &gt;= 9">points excellent</xsl:when>
                            <xsl:when test="score &gt;= 7">points good</xsl:when>
                            <xsl:when test="score &gt;= 5">points regular</xsl:when>
                            <xsl:otherwise>points bad</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    ⭐ <xsl:value-of select="score"/>
                </div>

                <div class="info">
                    <span class="platform-icon">
                        <xsl:choose>
                            <xsl:when test="platform = 'Nintendo Switch'">🕹️</xsl:when>
                            <xsl:when test="platform = 'PlayStation 5'">🎮</xsl:when>
                            <xsl:when test="platform = 'Xbox Series X'">💚</xsl:when>
                            <xsl:when test="platform = 'PC'">💻</xsl:when>
                            <xsl:when test="platform = 'Mobile'">📱</xsl:when>
                            <xsl:otherwise>🎲</xsl:otherwise>
                        </xsl:choose>
                    </span>
                    <xsl:value-of select="platform"/>
                    
                    <br/>📅 <xsl:value-of select="year"/>
                    <br/>🏷️ <xsl:value-of select="genre"/>
                    <span class="price"><xsl:value-of select="price"/> €</span>
                </div>
            </div>
        </xsl:for-each>
    </div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>