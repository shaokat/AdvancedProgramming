/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package smalltalk.Client;

/**
 *
 * @author RajibTheKing
 */
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import smalltalk.Server.ServerInterface;

/**
 * This implements a simple Chat Client via RMI
 */
public class ClientSkeleton extends UnicastRemoteObject implements ClientInterface{

    private ServerInterface serverIF;
    private String name;
    
    public ClientSkeleton(String name, ServerInterface serverIF) throws RemoteException    
    {
        super();
        this.name = name;
        this.serverIF =  serverIF;
        this.serverIF.registerNewClient(this, this.name);
        
    }
    public String getClientName()
    {
        return this.name;
    }
    /**
     * Create a new registry or connect to the existing one
     */
    private static Registry getOrCreateRegistry() {
        try {
            return LocateRegistry.createRegistry(Registry.REGISTRY_PORT);
        } catch (RemoteException _e) {
            try {
                return LocateRegistry.getRegistry();
            } catch (RemoteException _f) {
                return null;
            }
        }
    }

    /**
     * Receive a call
     */
    public synchronized void connect(ClientInterface other) {
        // your code
    }

    /**
     * Receive a good bye message
     */
    public synchronized void bye() {
        // your code
    }

    /**
     * Receive a message from the server and print it to the output
     */
    public void send(String msg) {
        // your code
    }

    /**
     * Establish a connection
     */
    private synchronized void waitForOther() {
        // your code
    }

    /**
     * A simple read-print-loop which reads messages from the input
     */
    public void talk() {
        boolean connected = false;

        waitForOther();
        connected = true;
        System.out.println("Welcome to talk, type ':q' to quit.");

        try (Scanner in = new Scanner(System.in)) {
            String msg;
            while (connected) {
                msg = in.nextLine();
                // your code
            }
        }
    }
    
    @Override
    public void broadCastedMsg(String msg) throws RemoteException {
        System.out.println(msg);
        ClientStartingPoint.getFrame().updateClientChatRoomPanel(msg);
    }
    
    public void sendMsgToServer(String msg) throws RemoteException
    {
        this.serverIF.broadCastMessage(this.name + ": " + msg);
    }
    public void sendMessage(String from, String to, String message) throws RemoteException
    {
        this.serverIF.sendMessage(from, to, message);
    }
    public void requestToGetUserList() throws RemoteException
    {
        this.serverIF.requestToGetUserList(this);
    }
    public void unRegisterclient() throws RemoteException
    {
        this.serverIF.unRegisterClient(this.name);
    }
    
    public void handleServerMsg(String msg) throws RemoteException
    {
        if(msg.compareTo("User Exists")==0)
        {
            JOptionPane.showConfirmDialog(null, "This userID: " + this.name + " already Exists. Please Try Different name");
            System.exit(0);
        }
    }
    
    public void gotUserList(ArrayList<String> names) throws RemoteException
    {
        ClientStartingPoint.getFrame().updateUserList(names);
    }
    
    public void gotMessage(String from, String to, String msg) throws RemoteException
    {
        if(ClientStartingPoint.prvtChat == null)
        {
            ClientStartingPoint.prvtChat = new privateChat(to, from);
            ClientStartingPoint.prvtChat.setVisible(true);
        }
        
        ClientStartingPoint.prvtChat.updatePrivateChatRoomPanel(from, msg);
    }

    
}
