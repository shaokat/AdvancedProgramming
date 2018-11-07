/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package smalltalk.Server;

import java.net.MalformedURLException;
import java.rmi.AccessException;
import java.rmi.AlreadyBoundException;
import java.rmi.Naming;
import java.rmi.RemoteException;

/**
 *
 * @author RajibTheKing
 */
public class ServerStartingPoint
{
    public static void main(String args[]) throws RemoteException, MalformedURLException, AccessException, AlreadyBoundException
    {
        TheKingServer server = new TheKingServer();
        //ServerInterface stub = (ServerInterface) UnicastRemoteObject.exportObject(server, 0);
        Naming.rebind("TheKingChatServer", server); 
        // Bind the remote object's stub in the registry
        //LocateRegistry.createRegistry(Registry.REGISTRY_PORT);
        //Registry registry = server.getRegistryObj();
        //registry.rebind("TheKingChatServer", stub);
        System.err.println("Server ready");
            
        
        
    }
    
}
