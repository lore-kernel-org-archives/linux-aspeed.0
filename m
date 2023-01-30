From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 30 Jan 2023 15:00:50 +1030
Subject: [PATCH] pinctrl: aspeed-g5: Bypass clock check when fetching regmap
In-Reply-To: <CACPK8Xf3Nz8mZrGrwUXx9PZWp90jYwEOAoZ2giY4qKou3opn3w@mail.gmail.com>
References: <20230119235501.53294-1-joel@jms.id.au>
 <b565b254-45aa-4f7a-b158-99fb4c66167f@app.fastmail.com>
 <CACRpkdYGG8jA9x8Hb9ByvkhFXgbyG43K=LB5F0t4hLxyXtWKjQ@mail.gmail.com>
 <CACPK8Xf3Nz8mZrGrwUXx9PZWp90jYwEOAoZ2giY4qKou3opn3w@mail.gmail.com>
Message-ID: <e87f3c0f-4741-4b0e-8d56-eba3225a977e@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 30 Jan 2023, at 13:29, Joel Stanley wrote:
> On Fri, 27 Jan 2023 at 12:36, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Fri, Jan 20, 2023 at 3:35 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>> > On Fri, 20 Jan 2023, at 10:25, Joel Stanley wrote:
>>
>> > > A recent commit cf517fef601b ("pinctrl: aspeed: Force to disable the
>> > > function's signal") exposed a problem with fetching the regmap for
>> > > reading the GFX register.
>> > >
>> > > The Romulus machine the device tree contains a gpio hog for GPIO S7.
>> > > With the patch applied:
>> > >
>> > >   Muxing pin 151 for GPIO
>> > >   Disabling signal VPOB9 for VPO
>> > >   aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to acquire regmap for IP block 1
>> > >   aspeed-g5-pinctrl 1e6e2080.pinctrl: request() failed for pin 151
>> > >
>> > > The code path is aspeed-gpio -> pinmux-g5 -> regmap -> clk, and the
>> > > of_clock code returns an error as it doesn't have a valid struct clk_hw
>> > > pointer. The regmap call happens because pinmux wants to check the GFX
>> > > node (IP block 1) to query bits there.
>> > >
>> > > For reference, before the offending patch:
>> > >
>> > >   Muxing pin 151 for GPIO
>> > >   Disabling signal VPOB9 for VPO
>> > >   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>> > >   Disabling signal VPOB9 for VPOOFF1
>> > >   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>> > >   Disabling signal VPOB9 for VPOOFF2
>> > >   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>> > >   Enabling signal GPIOS7 for GPIOS7
>> > >   Muxed pin 151 as GPIOS7
>> > >   gpio-943 (seq_cont): hogged as output/low
>> > >
>> > > As a workaround, skip the clock check to allow pinmux to proceed.
>> >
>> > We'd want the clock on and and the device out of reset before this
>> > makes sense though. We're just assuming the IP is in an operational
>> > state? Was this just accidentally working because reading the register
>> > in a bad state is producing 0 instead of other undefined garbage?
>>
>> This makes sense, can we come up with a resonable patch for this
>> problem or should this one be merged as an intermediate remedy?
>
> Andrew is correct, my testing showed that we do need to take the
> device out of reset in order to write a value that sticks. Qemu is
> insufficient for testing this as it doesn't model the reset lines.
>
> We really don't want to enable the clocks just to set a value that
> doesn't need to be set. There's a big nasty delay in the clock driver.
>
> I suggest we revert the problematic patch until we can come up with a
> better solution.

Yeah, based on the testing I've just done the GFX logic is always
clocked (D1CLK might be an output clock?), it's the reset that matters.
I applied Joel's patch and did some testing using the romulus-bmc
machine in qemu and we still see some failures to request some GPIOs. 
Given that Joel's patch doesn't completely resolve the regression I agree
we revert Billy's patch for now, and I'll reconsider my life
choices^W^W^W^W think about how to deal with Billy's problem another
way.

Cheers,

Andrew
