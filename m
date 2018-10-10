From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 10 Oct 2018 21:30:48 +0000
Subject: [PATCH net-next v5] net/ncsi: Extend NC-SI Netlink interface to
 allow user space to send NC-SI command
In-Reply-To: <245b32d9a3dd463f9334b9704b639ec4@AUSX13MPS302.AMER.DELL.COM>
References: <245b32d9a3dd463f9334b9704b639ec4@AUSX13MPS302.AMER.DELL.COM>
Message-ID: <7F21C163-21CD-4088-B32B-DACA9D46568D@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/10/18, 11:12 AM, "Justin.Lee1 at Dell.com" <Justin.Lee1@Dell.com> wrote:

    The new command (NCSI_CMD_SEND_CMD) is added to allow user space application
    to send NC-SI command to the network card.
    Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.
    
    The work flow is as below. 
    
    Request:
    User space application
    	-> Netlink interface (msg)
    	-> new Netlink handler - ncsi_send_cmd_nl()
    	-> ncsi_xmit_cmd()
    
    Response:
    Response received - ncsi_rcv_rsp()
    	-> internal response handler - ncsi_rsp_handler_xxx()
    	-> ncsi_rsp_handler_netlink()
    	-> ncsi_send_netlink_rsp ()
    	-> Netlink interface (msg)
    	-> user space application
    
    Command timeout - ncsi_request_timeout()
    	-> ncsi_send_netlink_timeout ()
    	-> Netlink interface (msg with zero data length)
    	-> user space application
    
    Error:
    Error detected
    	-> ncsi_send_netlink_err ()
    	-> Netlink interface (err msg)
    	-> user space application
    
    
    Signed-off-by: Justin Lee <justin.lee1@dell.com> 

  Reviewed-by : Vijay Khemka <vijaykhemka@fb.com>
  

