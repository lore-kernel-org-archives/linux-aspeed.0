From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 25 Aug 2020 09:17:38 -0500
Subject: [PATCH 3/5] ARM: dts: aspeed: yamp: Set 32MB FMC flash layout
In-Reply-To: <20200824211948.12852-4-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-4-rentao.bupt@gmail.com>
Message-ID: <20200825141738.GG3532@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 02:19:46PM -0700, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Set 32MB FMC flash layout in Yamp device tree explicitly because flash
> layout settings were removed from "ast2500-facebook-netbmc-common.dtsi".
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200825/8b7bf50f/attachment-0001.sig>
