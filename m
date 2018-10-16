From: David Miller <davem@davemloft.net>
Date: Mon, 15 Oct 2018 22:01:12 -0700 (PDT)
Subject: [PATCH net-next v7] net/ncsi: Extend NC-SI Netlink interface
 to allow user space to send NC-SI command
In-Reply-To: <cd371b0265b74889a10241a6af7e4843@AUSX13MPS302.AMER.DELL.COM>
References: <cd371b0265b74889a10241a6af7e4843@AUSX13MPS302.AMER.DELL.COM>
Message-ID: <20181015.220112.1806105081003593573.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: <Justin.Lee1@Dell.com>
Date: Thu, 11 Oct 2018 18:07:37 +0000

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

Applied.
