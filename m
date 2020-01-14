From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 14 Jan 2020 11:53:23 -0800
Subject: [PATCH] clk: ast2600: enable BCLK for PCI/PCIe bus always
In-Reply-To: <CACPK8Xf0Oa62BsNOQ55rqAp_a=V-_9bm1c4nu_+Oo5zB=2+zpA@mail.gmail.com>
References: <20200113213453.27108-1-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xf0Oa62BsNOQ55rqAp_a=V-_9bm1c4nu_+Oo5zB=2+zpA@mail.gmail.com>
Message-ID: <255b53d2-d4b5-8bc0-393b-a2f531a98fc1@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

On 1/13/2020 10:15 PM, Joel Stanley wrote:
> On Mon, 13 Jan 2020 at 21:33, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> BCLK for PCI/PCIe bus should be enabled always with having the
>> CLK_IS_CRITICAL flag otherwise it will be disabled at kernel late
>> initcall phase as an unused clock, and eventually it causes
>> unexpected behavior on BMC features that are connected to the host
>> through PCI/PCIe bus.
> 
> This is true for systems that have PCIe connected. There are systems
> that do not, and in that case we don't want to have the clock enabled.
> 
> Are you doing this to support the case where the PCIe device not load
> a BMC driver? (eg for host VGA use). If not, then you can have the
> driver you're loading request the BCLK.
> 
> If this is for the host VGA device, then you will need to come up with
> a mechanism that makes the enabling of this clock depend on the device
> tree.

Is there any way to enable clock by just adding a node in device tree?
Do you want me to add a simple driver module for host VGA just for
enabling BCLK?

Thanks,

Jae

> Cheers,
> 
> Joel
> 
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/clk/clk-ast2600.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
>> index 392d01705b97..42bfdc16bf7a 100644
>> --- a/drivers/clk/clk-ast2600.c
>> +++ b/drivers/clk/clk-ast2600.c
>> @@ -64,7 +64,7 @@ static const struct aspeed_gate_data aspeed_g6_gates[] = {
>>          [ASPEED_CLK_GATE_GCLK]          = {  2,  7, "gclk-gate",        NULL,    0 },   /* 2D engine */
>>          /* vclk parent - dclk/d1clk/hclk/mclk */
>>          [ASPEED_CLK_GATE_VCLK]          = {  3,  6, "vclk-gate",        NULL,    0 },   /* Video Capture */
>> -       [ASPEED_CLK_GATE_BCLK]          = {  4,  8, "bclk-gate",        "bclk",  0 }, /* PCIe/PCI */
>> +       [ASPEED_CLK_GATE_BCLK]          = {  4,  8, "bclk-gate",        "bclk",  CLK_IS_CRITICAL }, /* PCIe/PCI */
>>          /* From dpll */
>>          [ASPEED_CLK_GATE_DCLK]          = {  5, -1, "dclk-gate",        NULL,    CLK_IS_CRITICAL }, /* DAC */
>>          [ASPEED_CLK_GATE_REF0CLK]       = {  6, -1, "ref0clk-gate",     "clkin", CLK_IS_CRITICAL },
>> --
>> 2.17.1
>>
> 
