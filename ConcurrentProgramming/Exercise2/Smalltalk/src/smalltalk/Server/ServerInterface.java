/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package smalltalk.Server;

import java.rmi.Remote;
import java.rmi.RemoteException;
import smalltalk.Client.ClientInterface;

/**
 *
 * @author RajibTheKing
 */
public interface ServerInterface extends Remote{
    
    public void registerNewClient(ClientInterface clientIF, String name) throws RemoteException;
    public void unRegisterClient(String name) throws RemoteException;
    public void broadCastMessage(String msg) throws RemoteException; 
    public void requestToGetUserList(ClientInterface clientIF) throws RemoteException;
    public void sendMessage(String from, String to, String message) throws RemoteException;
}
