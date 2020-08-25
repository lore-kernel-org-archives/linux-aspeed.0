From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 25 Aug 2020 09:16:21 -0500
Subject: [PATCH 1/5] ARM: dts: aspeed: Remove flash layout from Facebook
 AST2500 Common dtsi
In-Reply-To: <20200824211948.12852-2-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-2-rentao.bupt@gmail.com>
Message-ID: <20200825141621.GE3532@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 02:19:44PM -0700, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Remove FMC flash layout from ast2500-facebook-netbmc-common.dtsi because
> flash size and layout varies across different Facebook AST2500 OpenBMC
> platforms.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  .../boot/dts/ast2500-facebook-netbmc-common.dtsi    | 13 -------------
>  1 file changed, 13 deletions(-)
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200825/5ae2b306/attachment.sig>
