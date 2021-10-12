From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 12 Oct 2021 10:02:03 +0200
Subject: [PATCH] net: ncsi: Adding padding bytes in the payload
In-Reply-To: <20211012062240.GA5761@gmail.com>
References: <20211012062240.GA5761@gmail.com>
Message-ID: <e8204e87-5b07-2049-3fdb-23dd8e4e21a6@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Kumar,


Thank you for your patch.

Nit: Could you please use the imperative mood in the commit message summary:

 > net: ncsi: Add padding bytes in the payload

Or more descriptive:

 > net: ncsi: Padd payload to be 32-bit aligned to fix dropped packets

Am 12.10.21 um 08:22 schrieb Kumar Thangavel:
> Update NC-SI command handler (both standard and OEM) to take into
> account of payload paddings in allocating skb (in case of payload
> size is not 32-bit aligned).
> 
> The checksum field follows payload field, without taking payload
> padding into account can cause checksum being truncated, leading to
> dropped packets.

How can this be reproduced?

> Signed-off-by: Kumar Thangavel <thangavel.k@hcl.com>
> 
> ---
>   net/ncsi/ncsi-cmd.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
> index ba9ae482141b..4625fc935603 100644
> --- a/net/ncsi/ncsi-cmd.c
> +++ b/net/ncsi/ncsi-cmd.c
> @@ -214,11 +214,19 @@ static int ncsi_cmd_handler_oem(struct sk_buff *skb,
>   	struct ncsi_cmd_oem_pkt *cmd;
>   	unsigned int len;
>   
> +	/* NC-SI spec requires payload to be padded with 0

It?d be great, if you included the specification version, and section if 
the requirement.

> +	 * to 32-bit boundary before the checksum field.
> +	 * Ensure the padding bytes are accounted for in
> +	 * skb allocation
> +	 */
> +

Please remove the blank line.

> +	unsigned short payload = ALIGN(nca->payload, 4);
> +
>   	len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> -	if (nca->payload < 26)
> +	if (payload < 26)
>   		len += 26;
>   	else
> -		len += nca->payload;
> +		len += payload;
>   
>   	cmd = skb_put_zero(skb, len);
>   	memcpy(&cmd->mfr_id, nca->data, nca->payload);
> @@ -272,6 +280,7 @@ static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
>   	struct net_device *dev = nd->dev;
>   	int hlen = LL_RESERVED_SPACE(dev);
>   	int tlen = dev->needed_tailroom;
> +	int payload;
>   	int len = hlen + tlen;
>   	struct sk_buff *skb;
>   	struct ncsi_request *nr;
> @@ -281,14 +290,18 @@ static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
>   		return NULL;
>   
>   	/* NCSI command packet has 16-bytes header, payload, 4 bytes checksum.
> +	 * Payload needs padding so that the checksum field follwoing payload is

following

> +	 * aligned to 32bit boundary.

32-bit

>   	 * The packet needs padding if its payload is less than 26 bytes to
>   	 * meet 64 bytes minimal ethernet frame length.
>   	 */
>   	len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> -	if (nca->payload < 26)
> +
> +	payload = ALIGN(nca->payload, 4);
> +	if (payload < 26)
>   		len += 26;
>   	else
> -		len += nca->payload;
> +		len += payload;
>   
>   	/* Allocate skb */
>   	skb = alloc_skb(len, GFP_ATOMIC);
> 

Besides the nits, this looks fine to me.


Kind regards,

Paul
