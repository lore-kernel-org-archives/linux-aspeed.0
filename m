From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Dec 2021 06:45:47 +0000
Subject: [v14 0/2] Support pwm driver for aspeed ast26xx
In-Reply-To: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
Message-ID: <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Tue, 30 Nov 2021 at 05:58, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> The legacy driver of aspeed pwm is binding with tach controller and it
> doesn't follow the pwm framworks usage. In addition, the pwm register
> usage of the 6th generation of ast26xx has drastic change. So these
> patch serials add the new aspeed pwm driver to fix up the problem above.

Sorry for not taking a look earlier. Well done on making it this far.

There's a few things that need to be addressed before merging this.

Firstly, the bindings need fixing up. I think these should be the one
file. The device tree bindings are supposed to describe the hardware,
and it doesn't make sense to separate them out just because we plan on
using two subsystems to implement the functionality.

Rob, please chime in if you would prefer something different.

Secondly, we need to clarify why this is a pwm driver and not a hwmon
driver like we had for the 2500 hardware, and that you're planning on
submitting a hwmon driver for the other half of the registers.

Finally, do you really need to use regmap? It's lots of overhead for a
mmio driver, and I like to see it avoided where possible. I know the
regions are shared, but are there any individual registers shared?

Cheers,

Joel



>
> Change since v13:
> - pwm-aspeed-ast2600.c
>   - Fix the usage of the braces to meet the coding-style.rst
>   - Use min function to reduce the times of division.
>
> Change since v12:
> - pwm-aspeed-ast2600.c
>   - Fix the comment about the duty cycle and period of the PWM.
>   - Configured to max period when request period > max period.
>   - Remove unnecessary curly braces.
>
> Change since v11:
> - pwm-aspeed-ast2600.c
>   - Request reset controller before clock enable.
>
> Change since v10:
> - pwm-aspeed-ast2600.c
>   - Add more comment to explain the feature of PWM
>   - Fix the naming of some parameters.
>   - Set pin_enable and clk_enable at the same time.
>   - Always set fixed divisor to hw register when apply.
>
> Change since v9:
> - dt-bindings:
>   - Change the naming of tach subnode channel setting property to
>   aspeed,tach-ch.
> - pwm-aspeed-ast2600.c
>   - Fix the naming of some parameters.
>   - Capitalise error messages.
>   - Handling potentially mult overflow when .apply
>
> Change since v8:
> - pwm-aspeed-ast2600.c
>   - Replace "* _BITULL(div_h)" to "<< div_h"
>   - Fix duty_cycle precision problem.
>   - Add the comment about the formula of duty_cycle.
>
> Change since v7:
> - pwm-aspeed-g6.c
>   - Rename the driver: pwm-aspeed-g6.c -> pwm-aspeed-ast2600.c.
>   - Macro remove "_CH" part of the register name.
>   - Unroll the aspeed_pwm_get_period and remove it.
>   - Simplify the formula to get duty_pt
>   - Reduce the number of writing register. Organize all the fields and
>     write them at once.
>
> Change since v6:
> - dt-bindings:
>   - Add blank line between each DT property.
>   - Change the sub-node name from fan to tach-ch.
> - pwm-aspeed-g6.c
>   - Merge aspeed_pwm_set_period and aspeed_pwm_set_duty into .apply.
>   - Convert the factor type to u64 when calculating the period value.
>   - Using ROUND_UP strategy to calculate div_h for finer resolution.
>
> Change since v5:
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K?nig
>   - Move the divide at the end of the calculation.
>   - Unified the prefix of the function name.
>   - Use div64_u64 to calculate the divider of frequency.
>
> Change since v4:
> - dt_binding:
>   - pwm/tach yaml: Replace child-node with additionalProperties
>   - pwm-tach yaml: Replace child-node with patternProperties
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K?nig
>   - The bit definitions contained the name of the register.
>   - Remove single caller function and fold it to the caller.
>   - Avoid to divide by the result of a division.
>   - Remove unnecessary condition in .apply().
>   - Use goto for error handling
>
> Changes since v3:
> - Add the dt_binding for aspeed,ast2600-tach.
> - Describe the pwm/tach as child-node of pwm-tach mfd.
> - Complete the properties of pwm node.
>
> Changes since v2:
> - Remove the tach node, #address-cells and #size-cells from pwm-tach.yaml
> - Add clocks and reset properties to pwm-tach.yaml
> - Kconfig/Makfile sorted alphabetically
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K?nig
>   - Add more hardware descriptions at top of the driver.
>   - Remove unused api request and free
>   - Move the initialize settings of all pwm channel to probe.
>   - Change the method of getting the approximate period.
>   - Read the hardware register values to fill the state for .get_state()
>
> Changes since v1:
> - Fix the dt_binding_check fail suggested by Rob Herring
> - Add depends to PWM_ASPEED_G6 configure suggested by Uwe Kleine-Konig
> - pwm-aspeed-g6.c suggested by Uwe Kleine-K?nig
>   - Fix license header
>   - Use bitfiled.h macro to define register fields
>   - Implement .remove device function
>   - Implement .get_state pwm api
>
> Billy Tsai (2):
>   dt-bindings: Add bindings for aspeed pwm-tach.
>   pwm: Add Aspeed ast2600 PWM support
>
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   |  68 ++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  76 ++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  64 ++++
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-aspeed-ast2600.c              | 325 ++++++++++++++++++
>  6 files changed, 544 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
>
> --
> 2.25.1
>
