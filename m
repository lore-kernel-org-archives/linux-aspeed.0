From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Jul 2019 10:12:56 +0200
Subject: [v5 1/2] dt-bindings: gpio: aspeed: Add SGPIO support
In-Reply-To: <1563564291-9692-2-git-send-email-hongweiz@ami.com>
References: <1563564291-9692-1-git-send-email-hongweiz@ami.com>
 <1563564291-9692-2-git-send-email-hongweiz@ami.com>
Message-ID: <CACRpkdYhVoP75ZDfASW+DH5yf-a5diitiXsh7eLsJx5hsTC9sQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Hongwei,

after looking close at the driver and bindings I have this feeback:

On Fri, Jul 19, 2019 at 9:25 PM Hongwei Zhang <hongweiz@ami.com> wrote:

+- reg                  : Address and length of the register set for the device

This 0x100 range may look simple but in the driver it looks like
this:

+static const struct aspeed_sgpio_bank aspeed_sgpio_banks[] = {
+       {
+               .val_regs = 0x0000,
+               .rdata_reg = 0x0070,
+               .irq_regs = 0x0004,
+               .names = { "A", "B", "C", "D" },
+       },
+       {
+               .val_regs = 0x001C,
+               .rdata_reg = 0x0074,
+               .irq_regs = 0x0020,
+               .names = { "E", "F", "G", "H" },
+       },
+       {
+               .val_regs = 0x0038,
+               .rdata_reg = 0x0078,
+               .irq_regs = 0x003C,
+               .names = { "I", "J" },
+       },
+};

So first break this into up to 10 different instances with one device
per bank instead.

For each device:

reg = <0x1e780200 4>, <x1e780204 ..>, <0x1e780270 ..>;
reg-names = "val", "irq", "rdata";

This way you use the device tree features for locating the
register offsets instead of hard-coding it into the driver,
which will make the driver simpler.

> +- ngpios               : number of GPIO pins to serialise.
> +                         (should be multiple of 8, up to 80 pins)

This is wrong. This should be split into 10 different devices providing
8 GPIO lines each. The "ngpios" is not intended to subdivide
banks, but for the case where you use say bits 0..11 of 32 bits in
a register by setting ngpios to 12.

I see that they use the same clock divider and the same interrupt,
but this is better to partition into a separate clock divider driver
and up to 10 instances of GPIO devices with 8 GPIOs each.

I also see that they use the same interrupt. This is fine, in your
driver just grab a shared IRQ and all the IRQ handlers will be
traversed. This is a well known pattern for all operating systems.

> +- clocks                : A phandle to the APB clock for SGPM clock division
> +
> +- bus-frequency                : SGPM CLK frequency

I see that there is a common clock control register in offset 0x54.

Split this out to a separate clock driver that provides a divided clock
that all GPIO blocks can get, no matter if you use 1, 2 .. 10 of these
blocks.

The fact that these GPIO banks and the clock register is in the same
memory range does not really matter. Split up the memory range in
on reg = per GPIO chip and one reg for the clock.

> +  Example:
> +       sgpio: sgpio at 1e780200 {
> +               #gpio-cells = <2>;
> +               compatible = "aspeed,ast2500-sgpio";
> +               gpio-controller;
> +               interrupts = <40>;
> +               reg = <0x1e780200 0x0100>;
> +               clocks = <&syscon ASPEED_CLK_APB>;
> +               interrupt-controller;
> +               ngpios = <8>;
> +               bus-frequency = <12000000>;
> +       };

Splitting this up into a clock controller and 1-10 instances of sgpio
will make things simpler, because it will closer reflect what the hardware
people are doing: they have just created 10 instances of the same
block, and added a clock divider.

You can put the 1-10 instances and the clock divider inside a collected
node "simple-bus" in the device tree:

{
    compatible = "simple-bus";

    sgpio0: sgpio {
        compatible = "aspeed,ast2500-sgpio";
        reg = <0x1e780200 ...> ...;
        clk = <&sgpioclk>;
    };
    sgpio1: sgpio {
        ...
    };
    ...
    sgpioclk: clock {
          compatible = "aspeed,sgpio-clock";
          reg = 0x1e780254 4>;
    };
};

This is a better fit with the actual hardware and will make it much
easier to write drivers.

Admittedly DT device partitioning of SoC devices is a grey area,
but here I think the DT infrastructure helps you to break things
down and make it easier, I am thinking in a divide-and-conquer
way about it.

Yours,
Linus Walleij
