From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 05 Aug 2024 13:22:12 +0930
Subject: [PATCH v6 2/2] ARM: dts: aspeed: catalina: add Meta Catalina BMC
In-Reply-To: <20240802-potin-catalina-dts-v6-2-0b8f61b80688@gmail.com>
References: <20240802-potin-catalina-dts-v6-0-0b8f61b80688@gmail.com>
	 <20240802-potin-catalina-dts-v6-2-0b8f61b80688@gmail.com>
Message-ID: <1176b2ddb609b462004fa7e7b36fe6657b89bbf0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Potin,

On Fri, 2024-08-02 at 17:07 +0800, Potin Lai wrote:
> Add linux device tree entry for Meta(Facebook) Catalina compute-tray
> BMC using AT2600 SoC.
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>

Running this past checkpatch gave me the following:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Potin Lai <potin.lai.pt@gmail.com>' != 'Signed-off-by: Potin Lai <potin.lai@quantatw.com>'

If you can't send from potin.lai at quantatw.com then perhaps you could
work around this by adding a `From: ...` line as the first line of your
commit message body as documented here:

https://docs.kernel.org/process/maintainer-tip.html#ordering-of-commit-tags

Alternatively, change your S-o-B tag to potin.lai.pt at gmail.com

... 

> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
> new file mode 100644
> index 000000000000..70cec690f541
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
> @@ -0,0 +1,965 @@
> 

...

> +&gpio0 {
> +	pinctrl-names = "default";

Not sure why you need this, but I think it also causes the following
warning:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: gpio at 1e780000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Might be best to drop it.

Andrew
