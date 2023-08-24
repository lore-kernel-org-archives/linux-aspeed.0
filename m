From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 24 Aug 2023 08:41:17 +0200
Subject: [PATCH] Title: Select GPIO command source.
In-Reply-To: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
References: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
Message-ID: <41cabea8-f694-f860-b3c1-757e9b8119f8@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/08/2023 18:08, peteryin wrote:
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

Bindings are separate patches. And it would be pointed out by checkpatch.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Please use standard email subjects, so with the PATCH keyword in the
title. `git format-patch` helps here to create proper versioned patches.
Another useful tool is b4. Skipping the PATCH keyword makes filtering of
emails more difficult thus making the review process less convenient.

>  drivers/soc/aspeed/Kconfig                    |   9 +
>  drivers/soc/aspeed/Makefile                   |   1 +
>  drivers/soc/aspeed/aspeed-command-source.c    | 266 ++++++++++++++++++
>  5 files changed, 358 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
>  create mode 100644 drivers/soc/aspeed/aspeed-command-source.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
> new file mode 100644
> index 000000000000..4698f47a1f75
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/platform/drivers/aspeed-command-source/\*command\*/bank\*
> +Date:		August 2023
> +Contact:	Peter Yin <peter.yin@quantatw.com>
> +Description:	Get or set the gpio command source for ARM, LPC or Coprocessor CPU.
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
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
> new file mode 100644
> index 000000000000..034183667501
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2023 Quanta Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/aspeed/gpio-command-source.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Best regards,
Krzysztof

