From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Mon, 15 Oct 2018 14:51:01 +1100
Subject: [PATCH net-next v4] net/ncsi: Add NCSI Broadcom OEM command
In-Reply-To: <69cae9d44cbebb2cd4f468dc710d6a97210af835.camel@mendozajonas.com>
References: <20181012182008.1665690-1-vijaykhemka@fb.com>
 <69cae9d44cbebb2cd4f468dc710d6a97210af835.camel@mendozajonas.com>
Message-ID: <9c82f52a7ce3fb9052600709a10783b23ef88457.camel@mendozajonas.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2018-10-15 at 13:08 +1100, Samuel Mendoza-Jonas wrote:
> On Fri, 2018-10-12 at 11:20 -0700, Vijay Khemka wrote:
> > This patch adds OEM Broadcom commands and response handling. It also
> > defines OEM Get MAC Address handler to get and configure the device.
> > 
> > ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> > getting mac address.
> > ncsi_rsp_handler_oem_bcm: This handles response received for all
> > broadcom OEM commands.
> > ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> > set it to device.
> > 
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  v4: updated as per comment from Sam, I was just wondering if I can remove
> >  NCSI_OEM_CMD_GET_MAC config option and let this code be valid always and
> >  it will configure mac address if there is get mac address handler for given 
> >  manufacture id.
> 
> Hi Vijay,
> 
> We can look at handling this a different way, but I don't think we want
> to unconditionally set the system's MAC address based on the OEM GMA
> command. If the user wants to set a custom MAC address, or in the case of
> OpenBMC for example who have their MAC address saved in flash, this will
> override that value with whatever the Network Controller has saved. In
> particular as it is set up it will override any MAC address every time a
> channel is configured, such as during a failover event.
> 
> We *could* always send the GMA command if it is available and move the
> decision whether to use the resulting address or not into the response
> handler. That would simplify the ncsi_configure_channel() logic a bit.
> Another idea may be to have a Netlink command to tell NCSI to ignore the
> GMA result; then we could drop the config option and the system can
> safely change the address if desired.
> 
> Any thoughts? I'll also ping some of the OpenBMC people and see what
> their expectations are.

After a bit of a think and an ask around, to quote a colleague:
> I think we'd want it handled (overall) like any other net device; the MAC
> address in the device's ROM provides a default, and is overridden by anything
> specified by userspace 

Which describes what I was thinking pretty well.
So if we can have it such that the NCSI driver only sets the MAC address
_once_, and then after then does not update it again, we should be able to call
the OEM GMA command without hiding it behind a config option. So the first time
a channel was configured we store and set the MAC address given, but then on
later configure events we don't continue to update it. What do you think?

Cheers,
Sam

> 
> > +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
> > +
> > +/* NCSI OEM Command APIs */
> > +static void ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
> > +{
> > +	unsigned char data[NCSI_OEM_BCM_CMD_GMA_LEN];
> > +	int ret = 0;
> > +
> > +	nca->payload = NCSI_OEM_BCM_CMD_GMA_LEN;
> > +
> > +	memset(data, 0, NCSI_OEM_BCM_CMD_GMA_LEN);
> > +	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_BCM_ID);
> > +	data[5] = NCSI_OEM_BCM_CMD_GMA;
> > +
> > +	nca->data = data;
> > +
> > +	ret = ncsi_xmit_cmd(nca);
> > +	if (ret)
> > +		netdev_err(nca->ndp->ndev.dev,
> > +			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
> > +			   nca->type);
> > +}
> 
> As a side note while unlikely we probably want to propagate the return
> value of ncsi_xmit_cmd() from here; otherwise we'll miss a failure and
> the configure process will stall.
> 
> Regards,
> Sam
> 


