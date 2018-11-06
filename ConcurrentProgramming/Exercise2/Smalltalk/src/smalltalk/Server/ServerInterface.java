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
    void registerNewClient(ClientInterface clientIF) throws RemoteException;
    void broadCastMessage(String msg) throws RemoteException; 
}
