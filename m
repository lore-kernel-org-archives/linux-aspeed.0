From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 15 Nov 2021 10:02:16 -0800
Subject: [PATCH v5] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211115144846.GA12078@gmail.com>
References: <20211115144846.GA12078@gmail.com>
Message-ID: <20211115100216.57cc4591@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 15 Nov 2021 20:18:46 +0530 Kumar Thangavel wrote:
> @@ -213,12 +215,16 @@ static int ncsi_cmd_handler_oem(struct sk_buff *skb,
>  {
>  	struct ncsi_cmd_oem_pkt *cmd;
>  	unsigned int len;
> +	/* NC-SI spec DSP_0222_1.2.0, section 8.2.2.2
> +	 * requires payload to be padded with 0 to
> +	 * 32-bit boundary before the checksum field.
> +	 * Ensure the padding bytes are accounted for in
> +	 * skb allocation
> +	 */
>  
> +	unsigned short payload = ALIGN(nca->payload, 4);
>  	len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;

This looks like mixing code and declarations.

If a piece of code is important enough to warrant a comment it should
not be placed as variable init.

> @@ -272,6 +278,7 @@ static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
>  	struct net_device *dev = nd->dev;
>  	int hlen = LL_RESERVED_SPACE(dev);
>  	int tlen = dev->needed_tailroom;
> +	int payload;
>  	int len = hlen + tlen;
>  	struct sk_buff *skb;
>  	struct ncsi_request *nr;
> @@ -281,14 +288,14 @@ static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
>  		return NULL;
>  
>  	/* NCSI command packet has 16-bytes header, payload, 4 bytes checksum.
> +	 * Payload needs padding so that the checksum field following payload is
> +	 * aligned to 32-bit boundary.
>  	 * The packet needs padding if its payload is less than 26 bytes to
>  	 * meet 64 bytes minimal ethernet frame length.
>  	 */
>  	len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> -	if (nca->payload < 26)
> -		len += 26;
> -	else
> -		len += nca->payload;
> +	payload = ALIGN(nca->payload, 4);
> +	len += max(payload, padding_bytes);

payload is int here, and padding_bytes is unsigned short, you either
have to use max_t() or change the types to agree.
