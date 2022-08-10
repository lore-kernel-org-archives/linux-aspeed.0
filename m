From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 10 Aug 2022 07:06:24 -0500
Subject: [PATCH 0/2] Update Facebook Bletchley BMC devicetree
In-Reply-To: <20220810004338.329832-1-potin.lai.pt@gmail.com>
References: <20220810004338.329832-1-potin.lai.pt@gmail.com>
Message-ID: <YvOfQEqj+XsYkuUH@heinlein.stwcx.org.github.beta.tailscale.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 10, 2022 at 12:43:36AM +0000, Potin Lai wrote:
> This patch series add modifications as below
> 1. add a IPMB node for USB debug card communication.
> 2. remove hdc1080 node due to incompatible 2nd source (si7021). 
> 
> Potin Lai (2):
>   ARM: dts: aspeed: bletchley: add USB debug card IPMB node
>   ARM: dts: aspeed: bletchley: remove hdc1080 node
> 
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> -- 
> 2.31.1
> 

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220810/dcc936c4/attachment.sig>
