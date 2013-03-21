import std.algorithm;
import std.array;
import std.stdio;
import std.string;
import std.socket;

int main(string[] args)
{
	string from;
	string to;
	string domain;
	string[] addrs;
	string[] results;

	try
	{
		from = args[1];
		to = args[2];
		domain = args[3];
	}
	catch(RangeError e)
	{
		writeln("Usage : " ~ args[0] ~ " <from> <to> <domain>");
		return 0;
	}

	addrs = array(getAddress(domain).map!("a.toAddrString()").uniq());

	foreach(uint ip; ipToInt(from) .. ipToInt(to))
	{
		string ipAddr = intToIp(ip);
		if(addrs.countUntil(ipAddr) != -1)
		{
			results ~= ipAddr;
		}
	}

	writeln("Found the following IPs :");
	writeln(results.join("\n"));

	return 0;
}

uint ipToInt(string ip)
{
	return InternetAddress.parse(ip);
}

string intToIp(uint addr)
{
	return InternetAddress.addrToString(addr);
}
