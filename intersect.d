import std.algorithm;
import std.array;
import std.stdio;
import std.string;
import std.socket;

int main(string[] args)
{
	if(args.length < 4)
	{
		writeln("Usage : " ~ args[0] ~ " <from> <to> <domain>");
		return 1;
	}

	string from = args[1];
	string to = args[2];
	string domain = args[3];

	string[] addrs = domain.getAddress.map!(x => x.toAddrString).uniq.array;
	string[] results;

	foreach(ip; from.ipToInt .. to.ipToInt)
	{
		string ipAddr = ip.intToIp;
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
