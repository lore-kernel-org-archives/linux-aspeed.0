From: Rob Herring <robh@kernel.org>
Date: Mon, 1 Apr 2024 08:56:37 -0500
Subject: [PATCH v6 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
In-Reply-To: <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
Message-ID: <20240401135637.GA342928-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 28, 2024 at 10:22:30AM +0800, Peter Yin wrote:
> To use the SCU register to obtain reset flags for supporting
> bootstatus.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index 3208adb3e52e..80a1f58b5a2e 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -8,6 +8,8 @@ Required properties:
>  
>   - reg: physical base address of the controller and length of memory mapped
>     region
> + - aspeed,scu: a reference to the System Control Unit node of the Aspeed
> +   SOC.

You cannot add new required properties as that is an ABI break.

If there's only 1 SCU instance, you can just fetch its node by 
compatible with no DT change.

What's the plan for converting this binding to schema? This is the 2nd 
new property in 6 months.

Rob
