From: Tao Ren <taoren@fb.com>
Date: Wed, 19 Jun 2019 22:32:42 +0000
Subject: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
In-Reply-To: <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
Message-ID: <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/19/19 2:25 PM, Brendan Higgins wrote:
> On Wed, Jun 19, 2019 at 2:00 PM Tao Ren <taoren@fb.com> wrote:
>>
>> Some intermittent I2C transaction failures are observed on Facebook CMM and
>> Minipack (ast2500) BMC platforms, because slave devices (such as CPLD, BIC
>> and etc.) NACK the address byte sometimes. The issue can be resolved by
>> increasing base clock divisor which affects ASPEED I2C Controller's base
>> clock and other AC timing parameters.
>>
>> This patch allows to customize ASPEED I2C Controller's base clock divisor
>> in device tree.
> 
> First off, are you sure you actually need this?
> 
> You should be able to achieve an effectively equivalent result by just
> lowering the `bus-frequency` property specified in the DT. The
> `bus-frequency` property ultimately determines all the register
> values, and you should be able to set it to whatever you want by
> refering to the Aspeed documentation.
> 
> Nevertheless, the code that determines the correct dividers from the
> frequency is based on the tables in the Aspeed documentation. I don't
> think the equation makes sense when the base_clk_divisor is fixed; I
> mean it will probably just set the other divisor to max or min
> depending on the values chosen. I think if someone really wants to
> program this parameter manually, they probably want to set the other
> parameters manually too.
Thank you for the quick response, Brendan.

Aspeed I2C bus frequency is defined by 3 parameters (base_clk_divisor, clk_high_width, clk_low_width), and I choose base_clk_divisor because it controls all the Aspeed I2C timings (such as setup time and hold time). Once base_clk_divisor is decided (either by the current logic in i2c-aspeed driver or manually set in device tree), clk_high_width and clk_low_width will be calculated by i2c-aspeed driver to meet the specified I2C bus speed.

For example, by setting I2C bus frequency to 100KHz on AST2500 platform, (base_clock_divisor, clk_high_width, clk_low_width) is set to (3, 15, 14) by our driver. But some slave devices (on CMM i2c-8 and Minipack i2c-0) NACK byte transactions with the default timing setting: the issue can be resolved by setting base_clk_divisor to 4, and (clk_high_width, clk_low_width) will be set to (7, 7) by our i2c-aspeed driver to achieve similar I2C bus speed.

Not sure if my answer helps to address your concerns, but kindly let me know if you have further questions/suggestions.


Thanks,

Tao
