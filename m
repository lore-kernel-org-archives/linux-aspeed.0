From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 15 Dec 2021 11:05:47 -0600
Subject: [PATCH] ARM: dts: Add openbmc-flash-layout-64-alt.dtsi
In-Reply-To: <20211210093443.2140557-1-yulei.sh@bytedance.com>
References: <20211210093443.2140557-1-yulei.sh@bytedance.com>
Message-ID: <Yboga8RUoYrXoPB1@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 10, 2021 at 05:34:43PM +0800, Lei YU wrote:
> Add openbmc-flash-layout-64-alt.dtsi to describe the partitions of the
> secondary flash for OpenBMC's 64M static layout.
> The layout is the same as openbmc-flash-layout-64.dtsi and the labels
> are prepended with "alt-" for the partitions.
> 
> Signed-off-by: Lei YU <yulei.sh@bytedance.com>
> ---
>  .../boot/dts/openbmc-flash-layout-64-alt.dtsi | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211215/82a4e8d2/attachment.sig>
