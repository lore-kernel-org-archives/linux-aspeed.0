From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Tue, 16 Oct 2018 16:46:01 +1100
Subject: [Potential Spoof] Re: [PATCH net-next v4] net/ncsi: Add NCSI
 Broadcom OEM command
In-Reply-To: <E82A7C2E-6DBF-437D-B571-5376F0122176@fb.com>
References: <E82A7C2E-6DBF-437D-B571-5376F0122176@fb.com>
Message-ID: <337567b2936725686459bdba7ef76dc46dea748a.camel@mendozajonas.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2018-10-15 at 17:38 +0000, Vijay Khemka wrote:
> 
> ?On 10/15/18, 10:27 AM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
> 
>     
>     
>     On 10/14/18, 8:51 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:
>     
>         On Mon, 2018-10-15 at 13:08 +1100, Samuel Mendoza-Jonas wrote:
>         > On Fri, 2018-10-12 at 11:20 -0700, Vijay Khemka wrote:
>         > > This patch adds OEM Broadcom commands and response handling. It also
>         > > defines OEM Get MAC Address handler to get and configure the device.
>         > > 
>         > > ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
>         > > getting mac address.
>         > > ncsi_rsp_handler_oem_bcm: This handles response received for all
>         > > broadcom OEM commands.
>         > > ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
>         > > set it to device.
>         > > 
>         > > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>         > > ---
>         > >  v4: updated as per comment from Sam, I was just wondering if I can remove
>         > >  NCSI_OEM_CMD_GET_MAC config option and let this code be valid always and
>         > >  it will configure mac address if there is get mac address handler for given 
>         > >  manufacture id.
>         > 
>         > Hi Vijay,
>         > 
>         > We can look at handling this a different way, but I don't think we want
>         > to unconditionally set the system's MAC address based on the OEM GMA
>         > command. If the user wants to set a custom MAC address, or in the case of
>         > OpenBMC for example who have their MAC address saved in flash, this will
>         > override that value with whatever the Network Controller has saved. In
>         > particular as it is set up it will override any MAC address every time a
>         > channel is configured, such as during a failover event.
>         > 
>         > We *could* always send the GMA command if it is available and move the
>         > decision whether to use the resulting address or not into the response
>         > handler. That would simplify the ncsi_configure_channel() logic a bit.
>         > Another idea may be to have a Netlink command to tell NCSI to ignore the
>         > GMA result; then we could drop the config option and the system can
>         > safely change the address if desired.
>         > 
>         > Any thoughts? I'll also ping some of the OpenBMC people and see what
>         > their expectations are.
>         
>         After a bit of a think and an ask around, to quote a colleague:
>         > I think we'd want it handled (overall) like any other net device; the MAC
>         > address in the device's ROM provides a default, and is overridden by anything
>         > specified by userspace 
>         
>         Which describes what I was thinking pretty well.
>         So if we can have it such that the NCSI driver only sets the MAC address
>         _once_, and then after then does not update it again, we should be able to call
>         the OEM GMA command without hiding it behind a config option. So the first time
>         a channel was configured we store and set the MAC address given, but then on
>         later configure events we don't continue to update it. What do you think?
>         
>         Cheers,
>         Sam
>     
>       I agree with you setting it only once. I gave a thought about config option and realize that 
>       we should allow user to configure it. If user wants to set mac address through device tree 
>       and not through ROM then we must not override mac set by device tree. So my proposal is 
>       setting of mac address in response should be hidden under config option. Getting mac address 
>       can still go without config option. Your thought?
>         
>   or simply guard following block under config and no other function declaration guard required. 
>   And set static variable flag in function " ncsi_oem_handler" for calling this only once.
> 
>   #if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
>     nca.type = NCSI_PKT_CMD_OEM;
>     nca.package = np->id;
>     nca.channel = nc->id;
>     ndp->pending_req_num = 1;
>     ret = ncsi_oem_handler(&nca, nc->version.mf_id);
> #endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
> 

Hi Vijay,

Either way is likely fine; although you might need to take care you don't
get an unused function warning depending on how you guard
ncsi_oem_handler(). Also a flag in the ncsi_dev_priv struct could be
easier to keep track of than having a static variable in the handler
function.

Sam

