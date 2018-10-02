From: Justin.Lee1@Dell.com <Justin.Lee1@Dell.com>
Date: Tue, 2 Oct 2018 17:36:55 +0000
Subject: [PATCH net v2] net/ncsi: Extend NC-SI Netlink interface to allow
 user space to send NC-SI command
In-Reply-To: <18e571bb7c5879a12754b1df20f51fd87ea48712.camel@mendozajonas.com>
References: <58fff61ffd8d4038b59f32b696e76bbc@AUSX13MPS306.AMER.DELL.COM>
 <18e571bb7c5879a12754b1df20f51fd87ea48712.camel@mendozajonas.com>
Message-ID: <89f75d6666e7489ab011cb71090646e5@AUSX13MPS306.AMER.DELL.COM>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Sam,

Sure, I will generate v3 after Vijay's patch is approved.

Thanks,
Justin


> On Fri, 2018-09-28 at 18:15 +0000, Justin.Lee1 at Dell.com wrote:
> > The new command (NCSI_CMD_SEND_CMD) is added to allow user space application 
> > to send NC-SI command to the network card.
> > Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.
> > 
> > The work flow is as below. 
> > 
> > Request:
> > User space application -> Netlink interface (msg)
> >                                               -> new Netlink handler - ncsi_send_cmd_nl()
> >                                               -> ncsi_xmit_cmd()
> > Response:
> > Response received - ncsi_rcv_rsp() -> internal response handler - ncsi_rsp_handler_xxx()
> >                                                                         -> ncsi_rsp_handler_netlink()
> >                                                                         -> ncsi_send_netlink_rsp ()
> >                                                                         -> Netlink interface (msg)
> >                                                                         -> user space application
> > Command timeout - ncsi_request_timeout() -> ncsi_send_netlink_timeout ()
> >                                                                                             -> Netlink interface (msg with zero data length)
> >                                                                                             -> user space application
> > Error:
> > Error detected -> ncsi_send_netlink_err () -> Netlink interface (err msg)
> >                                                                                        -> user space application
> > 
> > 
> > Signed-off-by: Justin Lee <justin.lee1@dell.com>
> 
> Hi Justin,
> 
> This is looking pretty good, combined with Vijay's base patch the two
> approaches should fit together nicely (
> http://patchwork.ozlabs.org/patch/976510/).
> 
> A good merge order would probably be the above patch first, then this
> patch and Vijay's further OEM patches based on top of that to reduce
> conflicts.
> 
> Cheers,
> Sam
