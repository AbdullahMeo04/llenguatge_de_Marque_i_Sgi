<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Game Inventory System</title>
                <style>
                    body { font-family: 'Segoe UI', sans-serif; background: #2a3650; color: #f1f5f9; padding: 30px; }
                    h1 { color: #4abaf1; border-bottom: 2px solid #38bdf8; padding-bottom: 10px; }
                    
                    table { width: 100%; border-collapse: collapse; margin-bottom: 40px; background: #1e293b; border-radius: 8px; overflow: hidden; }
                    th { background: #334155; color: #38bdf8; padding: 15px; text-align: left; text-transform: uppercase; font-size: 0.8em; }
                    td { padding: 15px; border-bottom: 1px solid #334155; }
                    tr:hover { background: #334155; }

                    .badge { padding: 4px 10px; border-radius: 20px; font-weight: bold; font-size: 0.9em; }
                    .bg-gold { background: #fbe524; color: #000; }
                    .bg-green { background: #22c55e; color: #000; }
                    .bg-orange { background: #f97316; color: #000; }
                    .bg-red { background: #ef4444; color: #000; }

                    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; }
                    .mobile-card { background: #0369a1; padding: 15px; border-radius: 8px; text-align: center; }
                    .PC-card { background: #5d4ca6; padding: 15px; border-radius: 8px; text-align: center; }

                    .summary { display: flex; gap: 20px; margin-top: 20px; }
                    .stat-card { background: #1e293b; padding: 20px; border-radius: 8px; flex: 1; border-left: 4px solid #38bdf8; }
                    .stat-label { font-size: 0.8em; color: #94a3b8; display: block; }
                    .stat-value { font-size: 1.5em; font-weight: bold; color: #fff; }
                </style>
            </head>
            <body>
                <h1>🕹️ Master Game Catalog</h1>
                
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Platform</th>
                        <th>Year</th>
                        <th>Genre</th>
                        <th>Score</th>
                        <th>Price</th>
                    </tr>
                    
                    <xsl:for-each select="catalog/game">
                        <xsl:sort select="score" data-type="number" order="descending"/>
                        <xsl:sort select="title" order="ascending"/>
                        
                        <tr>
                            <td><strong><xsl:value-of select="title"/></strong></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="platform='PC'">💻 PC</xsl:when>
                                    <xsl:when test="platform='Mobile'">📱 Mobile</xsl:when>
                                    <xsl:when test="platform='Nintendo Switch'">🕹️ Switch</xsl:when>
                                    <xsl:otherwise>🎮 <xsl:value-of select="platform"/></xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td><xsl:value-of select="year"/></td>
                            <td><xsl:value-of select="genre"/></td>
                            <td>
                                <span>
                                    <xsl:attribute name="class">
                                        <xsl:choose>
                                            <xsl:when test="score &gt;= 9">badge bg-gold</xsl:when>
                                            <xsl:when test="score &gt;= 7">badge bg-green</xsl:when>
                                            <xsl:when test="score &gt;= 5">badge bg-orange</xsl:when>
                                            <xsl:otherwise>badge bg-red</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:value-of select="score"/>
                                </span>
                            </td>
                            <td><xsl:value-of select="price"/> €</td>
                        </tr>
                    </xsl:for-each>
                </table>

                <h2>📱 Mobile Only </h2>
                <div class="grid">
                    <xsl:for-each select="catalog/game[platform='Mobile']">
                        <div class="mobile-card">
                            <div style="font-weight:bold"><xsl:value-of select="title"/></div>
                            <div style="font-size: 0.9em">Price: <xsl:value-of select="price"/> €</div>
                        </div>
                    </xsl:for-each>
                </div>
                
                <h2>💻 PC Only </h2>
                <div class="grid">
                    <xsl:for-each select="catalog/game[platform='PC']">
                        <div class="PC-card">
                            <div style="font-weight:bold"><xsl:value-of select="title"/></div>
                            <div style="font-size: 0.9em">Price: <xsl:value-of select="price"/> €</div>
                        </div>
                    </xsl:for-each>
                </div>

                <div class="summary">
                    <div class="stat-card">
                        <span class="stat-label">Total Games</span>
                        <span class="stat-value"><xsl:value-of select="count(catalog/game)"/></span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-label">Average Price</span>
                        <span class="stat-value">
                            <xsl:value-of select="format-number(sum(catalog/game/price) div count(catalog/game), '0.00')"/> €
                        </span>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>