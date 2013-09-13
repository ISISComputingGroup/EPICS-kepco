import SocketServer
import re
import argparse

class Kepco100:
    def __init__(self):
        self.CURR = 0.0
        self.CURR_SP = 0.0
        self.VOLT = 0.0
        self.VOLT_SP = 0.0
        self.MODE = 0
        self.OUTP = 0
        self.IDN = "KEPCO Simulator, ISIS"
        
    def check_command(self, comstr):
        if comstr == "MEAS:CURR?":
            #Get actual value
            return str(self.CURR)
        elif comstr == "CURR?":
            #Get setpoint
            return str(self.CURR_SP)
        elif comstr.startswith("CURR "):
            #Set setpoint
            m = re.match("CURR ([0-9]*\.?[0-9]+)", comstr)
            if not m is None:
                if len(m.groups()) > 0:
                    try:
                        self.CURR_SP = float(m.groups()[0])
                        #Set the "actual value" to the sp plus a little
                        self.CURR = self.CURR_SP + 0.0001
                    except:
                        #The cast to float failed for some reason
                        pass
        elif comstr == "*IDN?":
            return self.IDN
        elif comstr == "MEAS:VOLT?":
            #Get actual value
            return str(self.VOLT)
        elif comstr == "VOLT?":
            #Get setpoint
            return str(self.VOLT_SP)
        elif comstr.startswith("VOLT "):
            #Set setpoint
            m = re.match("VOLT ([0-9]*\.?[0-9]+)", comstr)
            if not m is None:
                if len(m.groups()) > 0:
                    try:
                        self.VOLT_SP = float(m.groups()[0])
                        #Set the "actual value" to the sp plus a little
                        self.VOLT = self.VOLT_SP + 0.0001
                    except:
                        #The cast to float failed for some reason
                        pass
        elif comstr == "FUNC:MODE?":
            return str(self.MODE)
        elif comstr == "FUNC:MODE VOLT":
            self.MODE = 0
        elif comstr == "FUNC:MODE CURR":
            self.MODE = 1
        elif comstr == "OUTP?":
            return str(self.OUTP)
        elif comstr == "OUTP 0":
            self.OUTP = 0
        elif comstr == "OUTP 1":
            self.OUTP = 1
        return None

class SimulatorTCPHandler(SocketServer.StreamRequestHandler):
    """
    The RequestHandler class for our server.
    It is instantiated once per connection to the server, and must
    override the handle() method to implement communication to the
    client.
    """       

    def handle(self):
        global SIMULATOR, DEBUG
        # self.request is the TCP socket connected to the client
        self.data = self.rfile.readline().strip()
        
        ans = SIMULATOR.check_command(self.data)
        
        if DEBUG :
            print self.data, "returned", ans
        
        if not ans is None:
            self.wfile.write(ans)
            
if __name__ == "__main__":
    #Argument parser - checks for debug mode and port
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--debug', action='store_true', help='put into debug mode')
    parser.add_argument('-p', '--port', type=int, nargs=1, default=9999, help='server port')
    args = parser.parse_args()
    DEBUG = args.debug
    
    #Define the type of simulator
    SIMULATOR = Kepco100()
    
    # Create the server, binding to localhost on port 
    server = SocketServer.TCPServer(("localhost", args.port), SimulatorTCPHandler)

    # Activate the server; this will keep running until you
    # interrupt the program with Ctrl-C
    server.serve_forever()