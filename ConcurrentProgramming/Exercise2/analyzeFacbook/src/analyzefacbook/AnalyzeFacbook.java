/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package analyzefacbook;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 *
 * @author RajibTheKing
 */
public class AnalyzeFacbook {

    /**
     * @param args the command line arguments
     */
    
    public static String getNameFromLink (String link)
    {
        Document doc;
        String name = "";
        try {
            doc = Jsoup.connect("https://"+link).get();
        
            //log(doc.title());
            //System.out.println(doc.title());
            //System.out.println(doc);
            //System.out.println(doc.getElementsByClass("_2nlw _2nlv"));
            
            String nowElement = doc.getElementsByClass("_2nlw _2nlv").toString();
            
            int check = 0;
            
            for(int i=0; i<nowElement.length() ; i++)
            {
                if(nowElement.charAt(i) == '<')
                    check = 0;
                if(check == 1)
                {
                    name += nowElement.charAt(i);
                }
                if(nowElement.charAt(i) == '>')
                    check = 1;
                
                
            }
            //System.out.println(name);
           
            //name = nowElement;
            
            
            Elements newsHeadlines = doc.select("#mp-itn b a");
            for (Element headline : newsHeadlines) {
              //log("%s\n\t%s", headline.attr("title"), headline.absUrl("href"));
            }
        } catch (IOException ex) {
            Logger.getLogger(AnalyzeFacbook.class.getName()).log(Level.SEVERE, null, ex);
        }
        return name;
    }
    public static void main(String[] args) {
        // TODO code application logic here
        
        //String testLink = "www.facebook.com/1451805404";
        //System.out.println(getNameFromLink(testLink));
        
        
        String filePath = "./userLibrary/hell2.txt";
        
        BufferedReader br = null;
	FileReader fr = null;
        
        try {
                fr = new FileReader(filePath);
                br = new BufferedReader(fr);

                String sCurrentLine;

                while ((sCurrentLine = br.readLine()) != null) {
                        System.out.println(sCurrentLine + " " + getNameFromLink(sCurrentLine));
                }

        } catch (IOException e) {

                e.printStackTrace();

        }

        
        
    }
    
}
