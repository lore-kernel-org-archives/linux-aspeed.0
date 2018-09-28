From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 28 Sep 2018 23:22:22 +0000
Subject: [PATCH net v2] net/ncsi: Extend NC-SI Netlink interface to allow
 user space to send NC-SI command
In-Reply-To: <58fff61ffd8d4038b59f32b696e76bbc@AUSX13MPS306.AMER.DELL.COM>
References: <58fff61ffd8d4038b59f32b696e76bbc@AUSX13MPS306.AMER.DELL.COM>
Message-ID: <0491255B-B4FB-42A1-9633-1AB44FFC5A52@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?>On 9/28/18, 11:16 AM, "Justin.Lee1 at Dell.com" <Justin.Lee1@Dell.com> wrote:

  >  The new command (NCSI_CMD_SEND_CMD) is added to allow user space application 
  >  to send NC-SI command to the network card.
  >  Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.
  > 
  >  The work flow is as below. 
  >  
  >  Request:
  >  User space application -> Netlink interface (msg)
                                                  -> new Netlink handler - ncsi_send_cmd_nl()
                                                  -> ncsi_xmit_cmd()
  >  Response:
  >  Response received - ncsi_rcv_rsp() -> internal response handler - ncsi_rsp_handler_xxx()
                                                                            -> ncsi_rsp_handler_netlink()
                                                                            -> ncsi_send_netlink_rsp ()
                                                                            -> Netlink interface (msg)
                                                                            -> user space application
  >  Command timeout - ncsi_request_timeout() -> ncsi_send_netlink_timeout ()
                                                                                                -> Netlink interface (msg with zero data length)
                                                                                                -> user space application
  >  Error:
  >  Error detected -> ncsi_send_netlink_err () -> Netlink interface (err msg)
                                                                                           -> user space application
    
    
    I will request to keep 2 patch, one for OEM handler and other one for netlink user space handling.

