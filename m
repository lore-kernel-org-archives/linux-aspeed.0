From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Aug 2023 12:09:46 -0500
Subject: [PATCH] Title: Select GPIO command source.
In-Reply-To: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
References: <20230823160810.1067102-1-peteryin.openbmc@gmail.com>
Message-ID: <169281058628.2496450.12875634767226591718.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Thu, 24 Aug 2023 00:08:10 +0800, peteryin wrote:
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
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-gpio-command-source
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml
>  create mode 100644 drivers/soc/aspeed/aspeed-command-source.c
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:38:3: [error] syntax error: expected <block end>, but found '?' (syntax)
./Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:39:6: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.example.dts'
Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:38:3: expected <block end>, but found '?'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml:38:3: expected <block end>, but found '?'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/aspeed/gpio-command-source.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230823160810.1067102-1-peteryin.openbmc at gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

