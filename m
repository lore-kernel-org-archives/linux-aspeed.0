From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 13 Jun 2022 11:54:45 -0500
Subject: [PATCH 0/4] Update Facebook Bletchley BMC DTS
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
Message-ID: <Yqdr1ZS6d71QeACd@heinlein.stwcx.org.github.beta.tailscale.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 13, 2022 at 05:51:46PM +0800, Potin Lai wrote:
> Update below items for Facebook Bletchley BMC devicetree.
> 
> Potin Lai (4):
>   ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
>   ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
>   ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
>   ARM: dts: aspeed: bletchley: update fusb302 nodes
> 
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 197 +++++++++++++-----
>  1 file changed, 148 insertions(+), 49 deletions(-)

The whole patch set looks good to me as the closest domain expert to the
Bletchley system after Potin.

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220613/5f94f531/attachment.sig>
