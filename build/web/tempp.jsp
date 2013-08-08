<%-- 
    Document   : netflow
    Created on : 16 May, 2013, 2:50:06 PM
    Author     : sriramya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="me.prettyprint.hector.api.beans.Row"%>
<%@page import="me.prettyprint.cassandra.serializers.UUIDSerializer"%>
<%@page import="me.prettyprint.hector.api.beans.Rows"%>
<%@page import="me.prettyprint.hector.api.query.MultigetSliceQuery"%>
<%@page import="me.prettyprint.hector.api.Keyspace"%>
<%@page import="me.prettyprint.hector.api.factory.HFactory"%>
<%@page import="java.nio.ByteBuffer"%>
<%@page import="me.prettyprint.cassandra.utils.TimeUUIDUtils"%>
<%@page import="java.lang.String"%>

<%@page import="com.eaio.util.lang.Hex"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="static me.prettyprint.hector.api.factory.HFactory.createKeyspace"%>
<%@page import="static me.prettyprint.hector.api.factory.HFactory.getOrCreateCluster"%>
<%@page import="me.prettyprint.cassandra.model.CqlQuery"%>
<%@page import="me.prettyprint.cassandra.model.CqlRows"%>
<%@page import="me.prettyprint.cassandra.serializers.StringSerializer"%>
<%@page import="me.prettyprint.cassandra.serializers.ByteBufferSerializer"%>
<%@page import="me.prettyprint.hector.api.Cluster"%>
<%@page import="me.prettyprint.hector.api.beans.HColumn"%>
<%@page import="me.prettyprint.hector.api.query.QueryResult"%>
<%@include file="Cassconnect.jsp"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
       public class Flowobj {
	
  String srcaddr = new String();   // Source IP address obj.srcaddr obj.dstaddr obj.nexthop obj.input 
                                     //obj.output obj.dPkts obj.dOctets obj.first obj.last obj.srcport obj.dstport
                                    // obj.prot obj.tos obj.src_as obj.dst_as
  String dstaddr = new String();   // Destination IP address 
  String nexthop = new String();   // Next hop router's IP address
  int input;     // Ingress interface SNMP ifIndex
  int output;    // Egress interface SNMP ifIndex
  long dPkts;    // Packets in the flow
  long dOctets;  // Octets (bytes) in the flow
  long first;    // SysUptime at start of the flow
  long last;     // SysUptime at the time the last packet of the flow was received
  int srcport;   // Layer 4 source port number or equivalent
  int dstport;   // Layer 4 destination port number or equivalent
  // public String pad1 = new String();      // Unused (zero) byte (non applicable)
  // public String tcp_flags = new String(); // Cumulative OR of TCP flags (non applicable)
  int prot;      // Layer 4 protocol (for example, 6=TCP, 17=UDP)
  int tos;       // IP type-of-service byte
  int src_as;   // Autonomous system number of the source, either origin or peer
  int dst_as;  // Autonomous system number of the destination, either origin or peer
  // public String src_mask = new String();  // Source address prefix mask bits (non applicable)
  // public String dst_mask = new String();  // Destination address prefix mask bits (non applicable)
  // public String pad2 = new String();      // Unused (zero) byte (non applicable)

  //A constructor!
  public Flowobj() {

  }
}
        
        public synchronized String ipaddr_to_String(byte[] IP_Address) {
    String String_IP_Address = new String();

    String_IP_Address = String.valueOf(byte_int0255(IP_Address[0])) + "." +
        String.valueOf(byte_int0255(IP_Address[1])) + "." +
        String.valueOf(byte_int0255(IP_Address[2])) + "." +
        String.valueOf(byte_int0255(IP_Address[3]));

    return String_IP_Address;
  }
 public synchronized int byte_int0255(byte x_byte) {

    int x_int = x_byte & 0xFF;

    return x_int;
  }
       
  public synchronized int byte_arr_to_int(int n, byte[] byte_arr) {
	// use all n bytes as an unsigned integer (2^n - 1), for n<=3
	String proc_name = new String("byte_arr_to_int() : ");  
	
    int[] num = new int[n];
    int result = -1; // -1 in case of an error
  
    try {
    num[0] = byte_int0255(byte_arr[0]);
    result = num[0];
    for (int i = 1; i <= n - 1; i++) {
      num[i] = (byte_int0255(byte_arr[i]) << 8 * i);
      result += num[i];
    }
    
    } // end try Open
    catch (Exception e) {
    	System.out.println(proc_name + " : " + e.toString());
    	
    }
    return result;
  }

  
  
  
  public synchronized long byte_arr_to_long(int n, byte[] byte_arr) {
    // use all n bytes as an unsigned integer (2^n - 1), for 4<=n<=7
    String proc_name = new String("byte_arr_to_long() : ");  

    long[] num = new long[n];
    long result = -1; // -1 in case of an error

    try {
    num[0] = byte_int0255(byte_arr[0]);
    result = num[0];
    for (int i = 1; i <= n - 1; i++) {
      long f = byte_int0255(byte_arr[i]);
      num[i] = f << 8 * i;
      result += num[i];
    }
    } // end try Open
    catch (Exception e) {
    	System.out.println(proc_name + " : " + e.toString());
    	
    }
    return result;
  }

 
public Flowobj get_record_ver5(int start, byte[] packet ) {
	  
    String proc_name = new String("get_record_ver5() : ");
    String newflow = new String();
    
    Flowobj fl = new Flowobj();
    byte[] flow = new byte[4];
    byte[] IP_Address = new byte[4];
    String text = new String();
    
    try {
    	// (bytes 0-3) Source IP
    	System.arraycopy(packet, start + 0, IP_Address, 0, 4);
    	fl.srcaddr = ipaddr_to_String(IP_Address);
    	newflow = newflow + "srcaddr = " + fl.srcaddr + ",";

    	// (bytes 4-7) Destination IP
    	System.arraycopy(packet, 4, IP_Address, 0, 4);
    	fl.dstaddr = ipaddr_to_String(IP_Address);
    	newflow = newflow + "dstaddr = " + fl.dstaddr + ",";

    	// (bytes 8-11) NextHop router IP
    	System.arraycopy(packet, 8, IP_Address, 0, 4);
    	fl.nexthop = ipaddr_to_String(IP_Address);
    	newflow = newflow + "nexthop = " + fl.nexthop + ",";

    	// (bytes 12-13) SNMP index of Input interface in the flow
    	flow[1] = packet[start + 12];
    	flow[0] = packet[start + 13];
    	fl.input = byte_arr_to_int(2, flow);
    	newflow = newflow + "input = " + fl.input + ",";

    	// (bytes 14-15) SNMP index of Output interface in the flow
    	flow[1] = packet[start + 14];
    	flow[0] = packet[start + 15];
    	fl.output = byte_arr_to_int(2, flow);
    	newflow = newflow + "output = " + fl.output + ",";

    	// (bytes 16-19) Packets in the flow
    	flow[3] = packet[start + 16];
    	flow[2] = packet[start + 17];
    	flow[1] = packet[start + 18];
    	flow[0] = packet[start + 19];
    	fl.dPkts = byte_arr_to_long(4, flow);
    	newflow = newflow + "dPkts = " + fl.dPkts + ",";

    	// (bytes 20-23) Octets in the flow
    	flow[3] = packet[start + 20];
    	flow[2] = packet[start + 21];
    	flow[1] = packet[start + 22];
    	flow[0] = packet[start + 23];
    	fl.dOctets = byte_arr_to_long(4, flow);
    	newflow = newflow + "dOctets = " + fl.dOctets + ",";

    	// (bytes 24-27) first = SystemUpIime (in Millisecs) at start of flow
    	flow[3] = packet[start + 24];
    	flow[2] = packet[start + 25];
    	flow[1] = packet[start + 26];
    	flow[0] = packet[start + 27];
    	fl.first = byte_arr_to_long(4, flow);
    	newflow = newflow + "first(msec) = " + fl.first + ",";

    	// (bytes 28-31) last = SystemUpIime (in Millisecs) at the time the last packet was received
    	flow[3] = packet[start + 28];
    	flow[2] = packet[start + 29];
    	flow[1] = packet[start + 30];
    	flow[0] = packet[start + 31];
    	fl.last = byte_arr_to_long(4, flow);
    	newflow = newflow + "last(msec) = " + fl.last + ",";
    	
    	long duration = fl.last - fl.first;
    	newflow = newflow + "duration(msec) = " + duration + ",";
 
    	// (bytes 32-33) Source port
    	flow[1] = packet[start + 32];
    	flow[0] = packet[start + 33];
    	fl.srcport = byte_arr_to_int(2, flow);
    	newflow = newflow + "srcport = " + fl.srcport + ",";

    	// (bytes 34-35) Destination port
    	flow[1] = packet[start + 34];
    	flow[0] = packet[start + 35];
    	fl.dstport = byte_arr_to_int(2, flow);
    	newflow = newflow + "dstport = " + fl.dstport + ",";

    	// (byte 36) pad1: Unused (zero) byte (non applicable)
    	// (byte 37) Cumulative OR of TCP flags (non applicable)
    
    	// (byte 38) protocol type
        String[] abc =null;
       String[] prot_name = abc;
    	fl.prot = byte_int0255(packet[start + 38]);
    	text = prot_name[fl.prot];
    	newflow = newflow + "prot = " + text + ",";

    	// (byte 39) IP Type of Service (ToS)
    	fl.tos = byte_int0255(packet[start + 39]);
    	newflow = newflow + "ToS = " + fl.tos + ",";
    	
    	// (bytes 40-41) Source AS
    	flow[1] = packet[start + 40];
    	flow[0] = packet[start + 41];
    	fl.src_as = byte_arr_to_int(2, flow);
    	newflow = newflow + "Src AS = " + fl.src_as + ",";

    	// (bytes 42-43) Destination AS
    	flow[1] = packet[start + 42];
    	flow[0] = packet[start + 43];
    	fl.dst_as = byte_arr_to_int(2, flow);
    	newflow = newflow + "Dst AS = " + fl.dst_as;

    	// (byte 44) Source address prefix mask bits (non applicable)
    	// (byte 45) Destination address prefix mask bits (non applicable)
    	// (bytes 46-47) pad2: Unused (zero) byte (non applicable)
    
    	System.out.println("  > " + newflow);
    
    } //try
    catch (Exception e) {
    	System.out.println(proc_name + " : " + e.toString());
    }
    return fl;

  }
%>
  <table>
	<thead>
		<tr>
                   
                    <th width ="10%">srcaddr</th>
                    <th width ="10%">dstaddr</th>
                    <th width ="10%">nexthop</th>
                    <th width ="10%">input</th> 
                    <th width ="10%">output</th>
                    <th width ="10%">dPkts</th>
                    <th width ="10%">dOctets</th>
                    <th width ="10%">first</th>
                    <th width ="10%">last</th>
                    <th width ="10%">srcport</th>
                    <th width ="10%">dstport</th>
                    <th width ="10%">prot</th>
                    <th width ="10%">tos</th>
                    <th width ="10%">src_as</th>
                    <th width ="10%">dst_as</th>
                    
                </tr>
	</thead>
<%
int i;
              Cluster c = getOrCreateCluster(CLUSTER_NAME, HOST_PORT);
              CqlQuery<String, String, String> cqlQuery1 = new CqlQuery<String, String, String>(
              createKeyspace("netflow", c), se, se, se);
              cqlQuery1.setQuery("select * from records limit 10");
                              
           
	    QueryResult<CqlRows<String, String, String>> result2 = cqlQuery1
	    .execute();
            
            if (result2 != null && result2.get() != null) {
	            java.util.List<me.prettyprint.hector.api.beans.Row<String, String, String>> list2 = result2.get().getList();
	            for (me.prettyprint.hector.api.beans.Row<String, String, String> row2 : list2) {
                        out.println();
                                    String colVal1 = row2.getColumnSlice().getColumns().get(1).getValue();
                                    String colVal2 = row2.getColumnSlice().getColumns().get(2).getValue();
                                    String colVal3 = row2.getColumnSlice().getColumns().get(3).getValue();
                                    String colVal4 = row2.getColumnSlice().getColumns().get(4).getValue();
                                out.println(colVal1+"---- "+ colVal2+"--- "+colVal3+" ---"+colVal4);
                                    Flowobj obj ;
                    

	         } }
                       
            
    %>

       
    </body>
</html>
