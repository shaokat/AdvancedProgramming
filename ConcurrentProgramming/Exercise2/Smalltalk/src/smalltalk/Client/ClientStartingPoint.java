/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package smalltalk.Client;

import java.rmi.Naming;
import java.rmi.RemoteException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import smalltalk.Server.ServerInterface;

/**
 *
 * @author RajibTheKing
 */
public class ClientStartingPoint {
    /**
     * Start a new talk client
     */
    private static ClientFrame clientFrame = new ClientFrame();
    public static privateChat prvtChat = null;
    private static ClientSkeleton client;
    public static ClientFrame getFrame()
    {
        return clientFrame;
    }
    
    public static ClientSkeleton getClient()
    {
        return client;
    }
    
    
    public static void main(String[] args) throws Exception {
        Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
            public void run() {
                try {
                    if(ClientStartingPoint.getClient() != null)
                        ClientStartingPoint.getClient().unRegisterclient();
                } catch (RemoteException ex) {
                    Logger.getLogger(ClientStartingPoint.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
        }, "Shutdown-thread"));
        
        String serverURL = "rmi://localhost/TheKingChatServer";
        ServerInterface serverIF = (ServerInterface) Naming.lookup(serverURL);
        
        JFrame frame = new JFrame("InputDialogBox");
        String name = JOptionPane.showInputDialog(frame, "Register Your name: ");
        client = new ClientSkeleton(name, serverIF);
        
        getFrame().setClientName(name);
        getFrame().setVisible(true);
        
        
        /*
        switch (args.length) {
            case 1:
            // your code
            case 2:
            // your code
            default:
                System.out.println("Usage:");
                System.out.println("To receive a call: java TalkClientImpl <user>");
                System.out.println("To call someone  : java TalkClientImpl <user> <host>");
                //System.exit(1);
        }
        */

        //System.exit(0);
    }
}
