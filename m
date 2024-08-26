From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 09:14:54 +0200
Subject: [PATCH v2 0/5] usb drivers use devm_clk_get_enabled() helpers
In-Reply-To: <20240826070244.1835-1-liulei.rjpt@vivo.com>
References: <20240826070244.1835-1-liulei.rjpt@vivo.com>
Message-ID: <2024082621-mortuary-gazing-20b5@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 26, 2024 at 03:02:38PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().

Your email threading is broken for some reason :(

Please fix up and send a v3 series.

thanks,

greg k-h
