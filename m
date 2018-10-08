From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 8 Oct 2018 19:18:04 +0000
Subject: [PATCH net-next 1/2] net/ncsi: Add NCSI Broadcom OEM command
In-Reply-To: <ee398ff59257b33e64ba7b641bf29096972a5006.camel@mendozajonas.com>
References: <20181005190126.983734-1-vijaykhemka@fb.com>
 <ee398ff59257b33e64ba7b641bf29096972a5006.camel@mendozajonas.com>
Message-ID: <567088A2-66B2-45FD-A2CA-46E476BFC856@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/7/18, 5:58 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:

    On Fri, 2018-10-05 at 12:01 -0700, Vijay Khemka wrote:
    > This patch adds OEM Broadcom commands and response handling. It also
    > defines OEM Get MAC Address handler to get and configure the device.
    > 
    > ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
    > getting mac address.
    > ncsi_rsp_handler_oem_bcm: This handles response received for all
    > broadcom OEM commands.
    > ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
    > set it to device.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Hi Vijay,
    
    Looks good, and I've tested this on a BMC with a Broadcom network
    controller and it properly sets a MAC address. A question below about the
    response handler:

  Hi Sam,
  Thanks for feedback, I will update code for response handler. Please see my response below.
    

    > +/* Response handler for Broadcom command Get Mac Address */
    > +static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
    > +{
    > +	struct ncsi_rsp_oem_pkt *rsp;
    > +	struct ncsi_dev_priv *ndp = nr->ndp;
    > +	struct net_device *ndev = ndp->ndev.dev;
    > +	int ret = 0;
    > +	const struct net_device_ops *ops = ndev->netdev_ops;
    > +	struct sockaddr saddr;
    > +
    > +	/* Get the response header */
    > +	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
    > +
    > +	saddr.sa_family = ndev->type;
    > +	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
    > +	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
    > +	/* Increase mac address by 1 for BMC's address */
    > +	saddr.sa_data[ETH_ALEN - 1]++;
    
    Is this convention documented somewhere, and could you provide a link to
    it if so?
    
    Also what happens here if the final byte of the address is 0xff, this
    will overflow and not carry right?

  This is a Facebook requirement to increment MAC address by 1 as base address is defined for 
  server followed by BMC address. I will handle this Facebook specific code differently in new 
  patch. For generic Broadcom card, I will just get base mac address and not add any convention.
    
    > +	ret = ops->ndo_set_mac_address(ndev, &saddr);
    > +	if (ret < 0)
    > +		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
    
    Also a minor nitpick, there's a bonus "'" in this message.
    
  Will be taken care in next version.
    

