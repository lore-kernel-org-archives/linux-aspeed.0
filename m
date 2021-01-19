From: Paul Fertser <fercerpav@gmail.com>
Date: Tue, 19 Jan 2021 15:04:26 +0300
Subject: [PATCH v29 2/6]  dt-binding: jtag: Aspeed 2400 and 2500 series
In-Reply-To: <20200413222920.4722-3-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
 <20200413222920.4722-3-ernesto.corona@intel.com>
Message-ID: <20210119120426.GE2971@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 13, 2020 at 03:29:16PM -0700, Ernesto Corona wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +      jtag: jtag at 1e6e4000 {
> +          compatible = "aspeed,ast2500-jtag";
> +          reg = <0x1e6e4000 0x1c>;
> +          clocks = <&syscon ASPEED_CLK_APB>;
> +          resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
> +          interrupts = <43>;
> +      };

It's nice to have an example but shouldn't it also be included in
aspeed-g5.dtsi as part of the patch series if it's known that the
driver works on those SoCs and the peripheral is always present?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
