From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Nov 2021 19:07:49 -0600
Subject: [PATCH v3 2/6] dt-bindings: ipmi: bt-bmc: add 'clocks' as a
 required property
In-Reply-To: <20211108190200.290957-3-jae.hyun.yoo@intel.com>
References: <20211108190200.290957-1-jae.hyun.yoo@intel.com>
 <20211108190200.290957-3-jae.hyun.yoo@intel.com>
Message-ID: <YZb45WLaOzRtW9+g@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 08 Nov 2021 11:01:56 -0800, jae.hyun.yoo at intel.com wrote:
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> If LPC BT driver is registered ahead of lpc-ctrl module, LPC BT
> hardware block will be enabled without heart beating of LCLK until
> lpc-ctrl enables the LCLK. This issue causes improper handling on
> host interrupts when the host sends interrupts in that time frame.
> Then kernel eventually forcibly disables the interrupt with
> dumping stack and printing a 'nobody cared this irq' message out.
> 
> To prevent this issue, all LPC sub drivers should enable LCLK
> individually so this patch adds 'clocks' property as one of
> required properties to enable the LCLK by the LPC IBT driver.
> 
> Note: dtsi change in this patch series should be applied along with,
> and dtbs should be re-compiled after applying this series since
> it's adding a new required property otherwise the driver will not
> be probed correctly.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> v2 -> v3:
>  * Made commit message more descriptive.
> 
> v1 -> v2:
>  * Added 'clocks' property into ibt bindings using
>    'aspeed,ast2400-ibt-bmc.txt' because it's not merged into
>    'aspeed-lpc.yaml' yet. The bindings merging could be done using a
>    separate patch later.
> 
>  .../devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
