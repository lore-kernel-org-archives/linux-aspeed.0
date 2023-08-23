From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 24 Aug 2023 07:47:21 +0930
Subject: [PATCH] Title: Select GPIO command source.
In-Reply-To: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
References: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
Message-ID: <e536fefa-18b9-48e3-8c70-e56dcd30123a@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

On Thu, 24 Aug 2023, at 01:38, peteryin wrote:
> From: peteryin <peter.yin@quantatw.com>
>
> Description:
>   The capability to choose the GPIO command source
> between ARM LPC and Coprocessor CPU is supported.
>
> Test Plan:
> Get Bank gpio command source
>   e.g.
>   cd /sys/bus/platform/drivers/aspeed-command-source/
>   cat 1e780000.gpio-command-source/bank_abcd
>   ARM ARM ARM ARM
>
> Set Bank gpio command source.
>   e.g.
>   cd /sys/bus/platform/drivers/aspeed-command-source/
>
>   echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
>   or
>   echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
>   or$
>   echo "A COP" > 1e780000.gpio-command-source/bank_abcd
>
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
>  .../sysfs-driver-aspeed-gpio-command-source   |  24 ++
>  .../soc/aspeed/gpio-command-source.yaml       |  58 ++++
>  drivers/soc/aspeed/Kconfig                    |   9 +
>  drivers/soc/aspeed/Makefile                   |   1 +
>  drivers/soc/aspeed/aspeed-command-source.c    | 266 ++++++++++++++++++
>  5 files changed, 358 insertions(+)
>  create mode 100644 
> Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
>  create mode 100644 
> Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
>  create mode 100644 drivers/soc/aspeed/aspeed-command-source.c
>
> diff --git 
> a/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source 
> b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
> new file mode 100644
> index 000000000000..4698f47a1f75
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/platform/drivers/aspeed-command-source/\*command\*/bank\*
> +Date:		August 2023
> +Contact:	Peter Yin <peter.yin@quantatw.com>
> +Description:	Get or set the gpio command source for ARM, LPC or 
> Coprocessor CPU.
> +
> +		When read, each file shows the list of available options with bank
> +		that depends on the selected bank file.
> +
> +		e.g.
> +		get gpio command source
> +		cd /sys/bus/platform/drivers/aspeed-command-source/
> +		cat 1e780000.gpio-command-source/bank_abcd
> +		ARM ARM ARM ARM
> +		In this case, gets bank gpio command source.
> +
> +
> +		e.g.
> +		set gpio command source
> +		cd /sys/bus/platform/drivers/aspeed-command-source/
> +		echo "A ARM" > 1e780000.gpio-command-source/bank_abcd
> +		or
> +		echo "A LPC" > 1e780000.gpio-command-source/bank_abcd
> +		or
> +		echo "A COP" > 1e780000.gpio-command-source/bank_abcd
> diff --git 
> a/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml 
> b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
> new file mode 100644
> index 000000000000..034183667501
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2023 Quanta Inc.
> +%YAML 1.2
> +---
> +$id: 
> "http://devicetree.org/schemas/soc/aspeed/gpio-command-source.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Aspeed UART Routing Controller
> +
> +maintainers:
> +  - Peter Yin <peter.yin@quantatw.com>
> +
> +description:
> +  The Aspeed gpio command source control allow to dynamically write 
> the inputs for
> +  the built-in gpio command source.
> +
> +  This allows, for example, to connect the gpio command source to ARM 
> LPC or Coprocessor CPU.
> +  e.g. let LPC port80 to connect the gpio group.
> +
> +  This driver is for the BMC side. The sysfs files allow the BMC 
> userspace
> +  which owns the system configuration policy, to configure gpio 
> command source.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-gpio-command-source
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +  gpio0: gpio at 1e780000 {
> +    #gpio-cells = <2>;
> +    gpio-controller;
> +    compatible = "aspeed,ast2600-gpio", "simple-mfd", "syscon";
> +    reg = <0x1e780000 0x400>;
> +    interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +    gpio-ranges = <&pinctrl 0 0 208>;
> +    ngpios = <208>;
> +    clocks = <&syscon ASPEED_CLK_APB2>;
> +    interrupt-controller;
> +    #interrupt-cells = <2>;
> +
> +    #address-cells = <1>;
> +    #size-cells = <1>;
> +    ranges = <0x0 0x1e780000 0x400>;
> +    gpio_command_source: gpio-command-source at 0 {
> +      compatible = "aspeed,ast2600-gpio-command-source";

You're using the devicetree to load a specific driver rather than to describe the hardware.

The command source registers are fundamentally part of the GPIO block. As such, the kernel support for the feature should be integrated into the existing GPIO driver. It should not be necessary to add this binding to expose the feature.

Andrew
