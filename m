From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Feb 2020 12:14:41 -0600
Subject: [PATCH 2/7] docs: dt: fix several broken references due to renames
In-Reply-To: <83c5df4acbbe0fa55a1d58d4c4a435b51cd2a7ad.1582361737.git.mchehab+huawei@kernel.org>
References: <cover.1582361737.git.mchehab+huawei@kernel.org>
 <83c5df4acbbe0fa55a1d58d4c4a435b51cd2a7ad.1582361737.git.mchehab+huawei@kernel.org>
Message-ID: <20200224181441.GA23262@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 22, 2020 at 10:00:02AM +0100, Mauro Carvalho Chehab wrote:
> Several DT references got broken due to txt->yaml conversion.
> 
> Those are auto-fixed by running:
> 
> 	scripts/documentation-file-ref-check --fix
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt        | 2 +-
>  Documentation/devicetree/bindings/arm/arm,scpi.txt        | 2 +-
>  .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt         | 2 +-
>  .../devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt  | 2 +-
>  .../devicetree/bindings/arm/msm/qcom,idle-state.txt       | 2 +-
>  Documentation/devicetree/bindings/arm/omap/mpu.txt        | 2 +-
>  Documentation/devicetree/bindings/arm/psci.yaml           | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-apq8064.yaml       | 2 +-
>  .../devicetree/bindings/display/tilcdc/tilcdc.txt         | 2 +-
>  Documentation/devicetree/bindings/leds/common.yaml        | 2 +-
>  .../devicetree/bindings/leds/register-bit-led.txt         | 2 +-
>  .../devicetree/bindings/memory-controllers/ti/emif.txt    | 2 +-
>  Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt   | 2 +-
>  .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml          | 2 +-
>  .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml          | 2 +-
>  .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml          | 2 +-
>  .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml  | 2 +-
>  .../devicetree/bindings/reset/st,stm32mp1-rcc.txt         | 2 +-
>  .../devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml  | 2 +-
>  MAINTAINERS                                               | 8 ++++----
>  20 files changed, 23 insertions(+), 23 deletions(-)

Applied.

Rob
