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
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.ArrayList;

/** This is an interface for a simple RMI talk client */
public interface ClientInterface extends Remote {

    /** Connect to the talk client */
    public void connect(ClientInterface other) throws RemoteException;

    /** Hang up a connection */
    public void bye() throws RemoteException;

    /** Send a message to the talk client */
    public void send(String msg) throws RemoteException;
    
    public void broadCastedMsg(String msg) throws RemoteException;
    
    public void handleServerMsg(String msg) throws RemoteException;
    
    public void gotUserList(ArrayList<String> names) throws RemoteException;
    
    public void gotMessage(String from, String to, String msg) throws RemoteException;

}
