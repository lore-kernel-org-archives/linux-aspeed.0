From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 25 Aug 2020 09:18:08 -0500
Subject: [PATCH 4/5] ARM: dts: aspeed: minipack: Update 64MB FMC flash
 layout
In-Reply-To: <20200824211948.12852-5-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-5-rentao.bupt@gmail.com>
Message-ID: <20200825141808.GH3532@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 02:19:47PM -0700, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Set 64Mb FMC flash layout in Minipack device tree explicitly because the
> flash layout was removed from "ast2500-facebook-netbmc-common.dtsi".
> 
> Please note "data0" partition' size is updated to 4MB to be consistent
> with other Facebook OpenBMC platforms.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-minipack.dts | 47 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 2 deletions(-)
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200825/14ce7100/attachment.sig>
