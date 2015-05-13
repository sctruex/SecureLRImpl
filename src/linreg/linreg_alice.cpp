// Bernardo's Code :)

#include <cstdlib>
#include <iostream>
#include <boost/asio.hpp>
#include <boost/lexical_cast.hpp>
#include <SLA/ntl_random.hpp>
#include <SLA/tcp_server_single.hpp>
#include <SLA/linreg_alice.hpp>

using boost::asio::ip::tcp;
using namespace NTL;

int main(int argc, char* argv[])
{
  try
  {


    ZZ q = boost::lexical_cast<ZZ>(argv[2]);
    ZZ_p::init(q);  
    set_seed_prng();    
    boost::asio::io_service io_service;
    tcp::endpoint endpoint(tcp::v4(), std::atoi(argv[3]));
    twoparty_runner_ptr protocol(new linreg_alice(argv[1],argv[4],argv[5],argv[6])); 
		tcp_server server(io_service, endpoint, protocol);
		//int tr=1;
		// kill "Address already in use" error message
		//if (setsockopt(7878,SOL_SOCKET,SO_REUSEADDR,&tr,sizeof(int)) == -1) {	
    //	perror("setsockopt");
    //	exit(1);
		//}
    io_service.run();
  }
  catch (std::exception& e)
  {
    std::cerr << "Exception: " << e.what() << "\n";
  }

  return 0;
}
