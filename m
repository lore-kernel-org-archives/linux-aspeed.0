From: Tao Ren <taoren@fb.com>
Date: Thu, 20 Jun 2019 02:28:06 +0000
Subject: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
In-Reply-To: <4c8b9ca5e84db7db67ad552d8fdbaa17d11b6432.camel@kernel.crashing.org>
References: <20190619205009.4176588-1-taoren@fb.com>
 <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
 <18565fcf-3dc1-b671-f826-e4417e4ad284@fb.com>
 <4c8b9ca5e84db7db67ad552d8fdbaa17d11b6432.camel@kernel.crashing.org>
Message-ID: <aefd4de2-31b4-1332-7cc0-92cc04fea045@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/19/19 4:02 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2019-06-19 at 22:32 +0000, Tao Ren wrote:
>> Thank you for the quick response, Brendan.
>>
>> Aspeed I2C bus frequency is defined by 3 parameters
>> (base_clk_divisor, clk_high_width, clk_low_width), and I choose
>> base_clk_divisor because it controls all the Aspeed I2C timings (such
>> as setup time and hold time). Once base_clk_divisor is decided
>> (either by the current logic in i2c-aspeed driver or manually set in
>> device tree), clk_high_width and clk_low_width will be calculated by
>> i2c-aspeed driver to meet the specified I2C bus speed.
>>
>> For example, by setting I2C bus frequency to 100KHz on AST2500
>> platform, (base_clock_divisor, clk_high_width, clk_low_width) is set
>> to (3, 15, 14) by our driver. But some slave devices (on CMM i2c-8
>> and Minipack i2c-0) NACK byte transactions with the default timing
>> setting: the issue can be resolved by setting base_clk_divisor to 4,
>> and (clk_high_width, clk_low_width) will be set to (7, 7) by our i2c-
>> aspeed driver to achieve similar I2C bus speed.
>>
>> Not sure if my answer helps to address your concerns, but kindly let
>> me know if you have further questions/suggestions.
> 
> Did you look at the resulting output on a scope ? I'm curious what
> might be wrong.... 
> 
> CCing Ryan from Aspeed, he might have some idea.
> 
> Could it be that with some specific dividers you have more jitter ?
> Still, i2c devices tend to be rather robust vs crappy clocks unless you
> are massively out of bounds, which makes me wonder whether something
> else might be wrong in your setup.
> 
> Cheers,
> Ben.

I've reached out to hardware team to see if they can provide more inputs (such as protocol decoder output) but so far I don't have such data. I'm suspecting it's caused by I2C timing mainly because:

1) the intermittent i2c transaction failures always happen to slave devices which are furthest away from ASPEED chip.

2) As the i2c-aspeed driver in my kernel 4.1 tree (derived from ASPEED SDK) works properly, and I copied I2CD04 (Clock and AC Timing Control) register value from kernel 4.1 and applied to the latest upstream driver: the transaction failure is fixed :)

Thank you Ben for looking into the issue and involving more experts (Ryan) for discussion. I have been suffering from the problem for several months and I'm looking forward for proper/right solutions.


Cheers,

Tao


