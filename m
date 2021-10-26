From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 26 Oct 2021 08:33:56 -0700
Subject: [PATCH v3] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211026144953.GA15611@gmail.com>
References: <20211026144953.GA15611@gmail.com>
Message-ID: <20211026083356.0719fc5e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 26 Oct 2021 20:19:53 +0530 Kumar Thangavel wrote:
> Update NC-SI command handler (both standard and OEM) to take into
> account of payload paddings in allocating skb (in case of payload
> size is not 32-bit aligned).
> 
> The checksum field follows payload field, without taking payload
> padding into account can cause checksum being truncated, leading to
> dropped packets.
> 
> Signed-off-by: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
> Acked-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

You need to CC netdev@ if you want this applied to networking trees.

> diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
> index ba9ae482141b..179e39105072 100644
> --- a/net/ncsi/ncsi-cmd.c
> +++ b/net/ncsi/ncsi-cmd.c
> @@ -18,6 +18,8 @@
>  #include "internal.h"
>  #include "ncsi-pkt.h"
>  
> +#define MAX(X, Y) (((X) > (Y)) ? (X) : (Y))

Please use one of the existing max() macroes in the kernel.
