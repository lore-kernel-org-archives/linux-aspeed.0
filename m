From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 12 Oct 2018 18:23:49 +0000
Subject: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
In-Reply-To: <0291dc2447720438a25c9c922252ab71e92985dd.camel@mendozajonas.com>
References: <20181011230518.3204700-1-vijaykhemka@fb.com>
 <0291dc2447720438a25c9c922252ab71e92985dd.camel@mendozajonas.com>
Message-ID: <51596B01-4863-44D6-AB0E-094E231A32BA@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/11/18, 5:42 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:

    > diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
    > index 091284760d21..75504ccd1b95 100644
    > --- a/net/ncsi/ncsi-manage.c
    > +++ b/net/ncsi/ncsi-manage.c
    > @@ -635,6 +635,39 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
    >  	return 0;
    >  }
    >  
    > +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
    > +
    > +/* NCSI OEM Command APIs */
    > +static void ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
    > +{
    > +	int ret = 0;
    > +	unsigned char data[NCSI_OEM_BCM_CMD_GMA_LEN];
    > +
    > +	nca->payload = NCSI_OEM_BCM_CMD_GMA_LEN;
    > +
    > +	memset(data, 0, NCSI_OEM_BCM_CMD_GMA_LEN);
    > +	*(unsigned int *)data = ntohl(NCSI_OEM_MFR_BCM_ID);
    > +	data[5] = NCSI_OEM_BCM_CMD_GMA;
    > +
    > +	nca->data = data;
    > +
    > +	ret = ncsi_xmit_cmd(nca);
    > +	if (ret)
    > +		netdev_err(nca->ndp->ndev.dev,
    > +			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
    > +			   nca->type);
    > +}
    > +
    > +/* OEM Command handlers initialization */
    > +static struct ncsi_oem_gma_handler {
    > +	unsigned int	mfr_id;
    > +	void		(*handler)(struct ncsi_cmd_arg *nca);
    > +} ncsi_oem_gma_handlers[] = {
    > +	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm }
    > +};
    > +
    > +#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
    > +
    >  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
    >  {
    >  	struct ncsi_dev *nd = &ndp->ndev;
    > @@ -685,6 +718,43 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
    >  			goto error;
    >  		}
    >  
    > +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
    > +		nd->state = ncsi_dev_state_config_oem_gma;
    > +		break;
    > +	case ncsi_dev_state_config_oem_gma:
    > +		nca.type = NCSI_PKT_CMD_OEM;
    > +		nca.package = np->id;
    > +		nca.channel = nc->id;
    > +		ndp->pending_req_num = 1;
    > +
    > +		/* Check for manufacturer id and Find the handler */
    > +		struct ncsi_oem_gma_handler *nch = NULL;
    > +		int i;
    > +
    
    This has the opposite affect, now if we do compile with
    CONFIG_NCSI_OEM_CMD_GET_MAC we get:
    
    ../net/ncsi/ncsi-manage.c: In function ?ncsi_configure_channel?:
    ../net/ncsi/ncsi-manage.c:769:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
       struct ncsi_oem_gma_handler *nch = NULL;
       ^~~~~~
    
    Perhaps we should lay this out slightly differently. For example we could go
    through the ncsi_dev_state_config_oem_gma state regardless and call some other
    function that finds and calls the handler, or does nothing if the config option
    isn't set.
    
    Regards,
    Sam
    
  Sam,
  I have created a new patch v4 and introduced new function. I was just wondering if I can remove
  CONFIG_NCSI_OEM_CMD_GET_MAC config all together. And it always get and set mac address if
  Handler is available. Looking for your thought here.
 
  -Vijay

