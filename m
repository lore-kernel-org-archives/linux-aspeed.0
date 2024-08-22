From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 22 Aug 2024 12:27:26 +0800
Subject: [PATCH v1 0/5] usb drivers use devm_clk_get_enabled() helpers
In-Reply-To: <20240822040734.29412-1-liulei.rjpt@vivo.com>
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
Message-ID: <2024082210-stadium-sly-cf06@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 22, 2024 at 12:07:25PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> ---
> The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of 
> certain interfaces due to the lack of synchronization during the 
> commit updates. These issues have been corrected in the v1 version.
> 
> version 1 changes
> 1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
>   devm_clk_get_enabled().
> 2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
>   devm_clk_get_enabled().
> 3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
>   corrected to devm_clk_get_enabled().

Patch versions start at 1, this should be 2, right?

