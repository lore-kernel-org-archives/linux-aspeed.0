From: Justin.Lee1@Dell.com <Justin.Lee1@Dell.com>
Date: Tue, 2 Oct 2018 16:53:51 +0000
Subject: [PATCH v2] net/ncsi: Add NCSI OEM command support
In-Reply-To: <1004987ef0ab138e772ed5740a0d839bffe39910.camel@mendozajonas.com>
References: <20180929010602.1025909-1-vijaykhemka@fb.com>
 <1004987ef0ab138e772ed5740a0d839bffe39910.camel@mendozajonas.com>
Message-ID: <4876838166d140bab331280efcfd771d@AUSX13MPS306.AMER.DELL.COM>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

Looks good. Please see my comment below.

Thanks,
Justin


> On Fri, 2018-09-28 at 18:06 -0700, Vijay Khemka wrote:
> > This patch adds OEM commands and response handling. It also defines OEM
> > command and response structure as per NCSI specification along with its
> > handlers.
> > 
> > ncsi_cmd_handler_oem: This is a generic command request handler for OEM
> > commands
> > ncsi_rsp_handler_oem: This is a generic response handler for OEM commands
> > 
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> 
> Hi Vijay - looks good to me, and should be a good common base for your
> and Justin's changes.
> 
> Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> 
> > ---
> >  net/ncsi/internal.h |  4 ++++
> >  net/ncsi/ncsi-cmd.c | 31 ++++++++++++++++++++++++++++---
> >  net/ncsi/ncsi-pkt.h | 16 ++++++++++++++++
> >  net/ncsi/ncsi-rsp.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 91 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> > index 8055e3965cef..c16cb7223064 100644
> > --- a/net/ncsi/internal.h
> > +++ b/net/ncsi/internal.h
> > @@ -68,6 +68,10 @@ enum {
> >  	NCSI_MODE_MAX
> >  };
> >  
> > +/* OEM Vendor Manufacture ID */
> > +#define NCSI_OEM_MFR_MLX_ID             0x8119
> > +#define NCSI_OEM_MFR_BCM_ID             0x113d
> > +
> >  struct ncsi_channel_version {
> >  	u32 version;		/* Supported BCD encoded NCSI version */
> >  	u32 alpha2;		/* Supported BCD encoded NCSI version */
> > diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
> > index 7567ca63aae2..2f98533eba46 100644
> > --- a/net/ncsi/ncsi-cmd.c
> > +++ b/net/ncsi/ncsi-cmd.c
> > @@ -211,6 +211,26 @@ static int ncsi_cmd_handler_snfc(struct sk_buff *skb,
> >  	return 0;
> >  }
> >  
> > +static int ncsi_cmd_handler_oem(struct sk_buff *skb,
> > +				struct ncsi_cmd_arg *nca)
> > +{
> > +	struct ncsi_cmd_oem_pkt *cmd;

OEM command doesn't not have the fixed data size. Should we use pointer instead?
struct ncsi_cmd_oem_pkt {
	struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
	__be32                  mfr_id;      /* Manufacture ID    */
	unsigned char           *data;       /* OEM Payload Data  */
};

> > +	unsigned int len;
> > +
> > +	len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> > +	if (nca->payload < 26)
> > +		len += 26;

Why does it add 26? I knew the other place in ncsi_alloc_command() is also add 26.
If it is less than 26, then it should be a fixed size of structure ncsi_cmd_pkt (46), right?

> > +	else
> > +		len += nca->payload;
> > +
> > +	cmd = skb_put_zero(skb, len);
> > +	cmd->mfr_id = nca->dwords[0];
> > +	memcpy(cmd->data, &nca->dwords[1], nca->payload - 4);

Netlink request is using the new nca->data pointer to pass the data as the request payload
is not the same size and some command payload is bigger than 16 bytes.
Will you consider to use the same data pointer? So, we don't need to have a checking here.
If the command is used less than 16 bytes, we can simply assigned &nca->bytes[0] to it.

> > +	ncsi_cmd_build_header(&cmd->cmd.common, nca);
> > +
> > +	return 0;
> > +}
> > +
> >  static struct ncsi_cmd_handler {
> >  	unsigned char type;
> >  	int           payload;
> > @@ -244,7 +264,7 @@ static struct ncsi_cmd_handler {
> >  	{ NCSI_PKT_CMD_GNS,    0, ncsi_cmd_handler_default },
> >  	{ NCSI_PKT_CMD_GNPTS,  0, ncsi_cmd_handler_default },
> >  	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
> > -	{ NCSI_PKT_CMD_OEM,    0, NULL                     },
> > +	{ NCSI_PKT_CMD_OEM,   -1, ncsi_cmd_handler_oem     },
> >  	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
> >  	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
> >  };
> > @@ -316,8 +336,13 @@ int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca)
> >  		return -ENOENT;
> >  	}
> >  
> > -	/* Get packet payload length and allocate the request */
> > -	nca->payload = nch->payload;
> > +	/* Get packet payload length and allocate the request
> > +	 * It is expected that if length set as negative in
> > +	 * handler structure means caller is initializing it
> > +	 * and setting length in nca before calling xmit function
> > +	 */
> > +	if (nch->payload >= 0)
> > +		nca->payload = nch->payload;
> >  	nr = ncsi_alloc_command(nca);
> >  	if (!nr)
> >  		return -ENOMEM;
> > diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
> > index 91b4b66438df..1f338386810d 100644
> > --- a/net/ncsi/ncsi-pkt.h
> > +++ b/net/ncsi/ncsi-pkt.h
> > @@ -151,6 +151,22 @@ struct ncsi_cmd_snfc_pkt {
> >  	unsigned char           pad[22];
> >  };
> >  
> > +/* OEM Request Command as per NCSI Specification */
> > +struct ncsi_cmd_oem_pkt {
> > +	struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
> > +	__be32                  mfr_id;      /* Manufacture ID    */
> > +	unsigned char           data[64];    /* OEM Payload Data  */
> > +	__be32                  checksum;    /* Checksum          */
> > +};
> > +
> > +/* OEM Response Packet as per NCSI Specification */
> > +struct ncsi_rsp_oem_pkt {
> > +	struct ncsi_rsp_pkt_hdr rsp;         /* Command header    */
> > +	__be32                  mfr_id;      /* Manufacture ID    */
> > +	unsigned char           data[64];    /* Payload data      */
> > +	__be32                  checksum;    /* Checksum          */
> > +};
> > +

OEM command doesn't not have the fixed response data size too.
Should we use pointer instead?

> >  /* Get Link Status */
> >  struct ncsi_rsp_gls_pkt {
> >  	struct ncsi_rsp_pkt_hdr rsp;        /* Response header   */
> > diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> > index 930c1d3796f0..22664ebdc93a 100644
> > --- a/net/ncsi/ncsi-rsp.c
> > +++ b/net/ncsi/ncsi-rsp.c
> > @@ -596,6 +596,48 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
> >  	return 0;
> >  }
> >  
> > +static struct ncsi_rsp_oem_handler {
> > +	unsigned int	mfr_id;
> > +	int		(*handler)(struct ncsi_request *nr);
> > +} ncsi_rsp_oem_handlers[] = {
> > +	{ NCSI_OEM_MFR_MLX_ID, NULL },
> > +	{ NCSI_OEM_MFR_BCM_ID, NULL }
> > +};
> > +
> > +
> > +/* Response handler for OEM command */
> > +static int ncsi_rsp_handler_oem(struct ncsi_request *nr)
> > +{
> > +	struct ncsi_rsp_oem_pkt *rsp;
> > +	struct ncsi_rsp_oem_handler *nrh = NULL;
> > +	unsigned int mfr_id, i;
> > +
> > +	/* Get the response header */
> > +	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> > +	mfr_id = ntohl(rsp->mfr_id);
> > +
> > +	/* Check for manufacturer id and Find the handler */
> > +	for (i = 0; i < ARRAY_SIZE(ncsi_rsp_oem_handlers); i++) {
> > +		if (ncsi_rsp_oem_handlers[i].mfr_id == mfr_id) {
> > +			if (ncsi_rsp_oem_handlers[i].handler)
> > +				nrh = &ncsi_rsp_oem_handlers[i];
> > +			else
> > +				nrh = NULL;
> > +
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!nrh) {
> > +		netdev_err(nr->ndp->ndev.dev, "Received unrecognized OEM packet with MFR-ID (0x%x)\n",
> > +			   mfr_id);
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* Process the packet */
> > +	return nrh->handler(nr);
> > +}
> > +
> >  static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
> >  {
> >  	struct ncsi_rsp_gvi_pkt *rsp;
> > @@ -932,7 +974,7 @@ static struct ncsi_rsp_handler {
> >  	{ NCSI_PKT_RSP_GNS,   172, ncsi_rsp_handler_gns     },
> >  	{ NCSI_PKT_RSP_GNPTS, 172, ncsi_rsp_handler_gnpts   },
> >  	{ NCSI_PKT_RSP_GPS,     8, ncsi_rsp_handler_gps     },
> > -	{ NCSI_PKT_RSP_OEM,     0, NULL                     },
> > +	{ NCSI_PKT_RSP_OEM,    -1, ncsi_rsp_handler_oem     },
> >  	{ NCSI_PKT_RSP_PLDM,    0, NULL                     },
> >  	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  }
> >  };
