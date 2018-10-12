From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Fri, 12 Oct 2018 13:39:15 +1100
Subject: [PATCH net-next v7] net/ncsi: Extend NC-SI Netlink interface to
 allow user space to send NC-SI command
In-Reply-To: <cd371b0265b74889a10241a6af7e4843@AUSX13MPS302.AMER.DELL.COM>
References: <cd371b0265b74889a10241a6af7e4843@AUSX13MPS302.AMER.DELL.COM>
Message-ID: <d982edf8e0c774afaf5e77493e53c8ecb7b7a4b1.camel@mendozajonas.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-10-11 at 18:07 +0000, Justin.Lee1 at Dell.com wrote:
> The new command (NCSI_CMD_SEND_CMD) is added to allow user space application
> to send NC-SI command to the network card.
> Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.
> 
> The work flow is as below. 
> 
> Request:
> User space application
> 	-> Netlink interface (msg)
> 	-> new Netlink handler - ncsi_send_cmd_nl()
> 	-> ncsi_xmit_cmd()
> 
> Response:
> Response received - ncsi_rcv_rsp()
> 	-> internal response handler - ncsi_rsp_handler_xxx()
> 	-> ncsi_rsp_handler_netlink()
> 	-> ncsi_send_netlink_rsp ()
> 	-> Netlink interface (msg)
> 	-> user space application
> 
> Command timeout - ncsi_request_timeout()
> 	-> ncsi_send_netlink_timeout ()
> 	-> Netlink interface (msg with zero data length)
> 	-> user space application
> 
> Error:
> Error detected
> 	-> ncsi_send_netlink_err ()
> 	-> Netlink interface (err msg)
> 	-> user space application
> 
> 
> Signed-off-by: Justin Lee <justin.lee1@dell.com> 
> 

Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>


