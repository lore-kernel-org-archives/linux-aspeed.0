From: Conor Dooley <conor@kernel.org>
Date: Wed, 21 Aug 2024 13:28:28 +0100
Subject: [PATCH 4/5] usb: mpfs: Use devm_clk_get_enabled() helpers
In-Reply-To: <20240821121048.31566-5-liulei.rjpt@vivo.com>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
 <20240821121048.31566-5-liulei.rjpt@vivo.com>
Message-ID: <20240821-velocity-tribune-726bb3546ba8@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2024 at 08:10:42PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240821/49844545/attachment.sig>
