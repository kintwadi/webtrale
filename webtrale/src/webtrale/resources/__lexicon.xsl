<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="utf-8"/>

    <xsl:template match="/">

        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
                <link href="__wt.css" rel="stylesheet" type="text/css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
                <link href='https://fonts.googleapis.com/css?family=Balthazar' rel='stylesheet'/>
                <!-- jQuery library -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

                <!-- Latest compiled JavaScript -->
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
                <base target="viewpan"/>
                <style>
                    .list{
                    background-color: #02111b;
                   
                    } 
                    li a{
                    color:white;
                    font-family: 'Tangerine';font-size: 13px;
                    
                    text-align: justify;
            
                    } 
                    ul{
                   
                    text-align: center;
          
                    }
                    li{
                    list-style-type: none;
                    margin: auto;
                    text-align: center;
                    }
                    div{
                    height: 100%;
                    width:100%;
                    float:left;
                    text-align: center;
                    
                    }  
                    table {
                    font-family: arial, sans-serif;
                    border-style:10px solid;
          
                    border-color:#02111b;
                    width: 100%;
                    }

                    td, th {
                    
                 
                    padding: 7px;
                  
                    text-align: center;
                    }

                    tr:nth-child(even) {
                  
                    }
                    a{
                    color:white;
                    font-family: 'Tangerine';font-size: 13px;
                    
                    text-align: justify;
            
                    } 
                </style>
      
            </head>
            <body class="list">
                <div  >
                  
                    <xsl:for-each select="//word">
                            
                        <table>
                            <tr>
                                <th></th>
                                    
   
                            </tr>
                            <tr>
                                    
                                <td>
                                    <a href="lex?q={@uri-encoded-utf8}">
                                        <xsl:value-of select="."/>
                                    </a>
                                </td>
    
                            </tr>
  
  
                        </table>
                            
           
                    </xsl:for-each>
                    
                </div>
            </body>
        </html>

    </xsl:template>
</xsl:stylesheet>
