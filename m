From: Rob Herring <robh@kernel.org>
Date: Thu, 6 May 2021 20:06:01 -0500
Subject: [v3 0/2] Support pwm driver for aspeed ast26xx
In-Reply-To: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
References: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
Message-ID: <20210507010601.GA1110621@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 06, 2021 at 02:10:48PM +0800, Billy Tsai wrote:
> The legacy driver of aspeed pwm is binding with tach controller and it
> doesn't follow the pwm framworks usage. In addition, the pwm register
> usage of the 6th generation of ast26xx has drastic change. So these
> patch serials add the new aspeed pwm driver to fix up the problem above.
> 
> Changes since v2:
> - Remove the tach node, #address-cells and #size-cells from pwm-tach.yaml

So you don't need tach functions, they don't need it to be described in 
DT any more, or you plan to add them back later? The last one is not 
acceptable.

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
> 
> Billy Tsai (2):
>   dt-bindings: Add bindings for aspeed pwm-tach and pwm.
>   pwm: Add Aspeed ast2600 PWM support
> 
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  55 +++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  41 ++
>  drivers/pwm/Kconfig                           |   8 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-aspeed-g6.c                   | 368 ++++++++++++++++++
>  5 files changed, 473 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-aspeed-g6.c
> 
> -- 
> 2.25.1
> 
