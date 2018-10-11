From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2018 09:59:36 -0700 (PDT)
Subject: [PATCH net-next v6] net/ncsi: Extend NC-SI Netlink interface
 to allow user space to send NC-SI command
In-Reply-To: <70bcb509b3f94eb4af186e604363770d@AUSX13MPS302.AMER.DELL.COM>
References: <70bcb509b3f94eb4af186e604363770d@AUSX13MPS302.AMER.DELL.COM>
Message-ID: <20181011.095936.1852167988265546410.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: <Justin.Lee1@Dell.com>
Date: Thu, 11 Oct 2018 06:21:10 +0000

> @@ -366,6 +368,203 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
>  	return 0;
>  }
>  
> +static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
> +{
> +	struct ncsi_dev_priv *ndp;
> +
> +	struct ncsi_cmd_arg nca;
> +	struct ncsi_pkt_hdr *hdr;
> +
> +	u32 package_id, channel_id;
> +	unsigned char *data;
> +	int len, ret;

Please order all local variable declarations from longest to shortest
line.  Please do not insert empty lines in the middle of a set of
variable declarations.

> +int ncsi_send_netlink_err(struct net_device *dev,
> +			  u32 snd_seq,
> +			  u32 snd_portid,
> +			  struct nlmsghdr *nlhdr,
> +			  int err)
> +{
> +	struct sk_buff *skb;
> +	struct nlmsghdr *nlh;
> +	struct nlmsgerr *nle;
> +	struct net *net;

Please order local variables from longest to shortest line.

> @@ -941,6 +956,26 @@ static int ncsi_rsp_handler_gpuuid(struct ncsi_request *nr)
>  	return 0;
>  }
>  
> +static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
> +{
> +	struct ncsi_rsp_pkt *rsp;
> +	struct ncsi_dev_priv *ndp = nr->ndp;
> +	struct ncsi_package *np;
> +	struct ncsi_channel *nc;
> +	int ret;

Likewise.
