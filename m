From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 15 Jan 2020 17:44:51 -0800
Subject: [PATCH 1/2] clk: aspeed: add critical clock setting logic
In-Reply-To: <CACPK8Xez9XQPQCsUU1Fu_POTJ3dh3tGJvK=otJdMYv40aZLqsw@mail.gmail.com>
References: <20200115212639.4998-1-jae.hyun.yoo@linux.intel.com>
 <20200115212639.4998-2-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xez9XQPQCsUU1Fu_POTJ3dh3tGJvK=otJdMYv40aZLqsw@mail.gmail.com>
Message-ID: <2088ff06-2bf0-b158-6df7-17171dde4e03@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/15/2020 5:38 PM, Joel Stanley wrote:
> On Wed, 15 Jan 2020 at 21:25, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit adds critical clock setting logic that applies
>> CLK_IS_CRITICAL flag if it detects 'clock-critical' property in
>> device tree.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/clk/clk-aspeed.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
>> index 411ff5fb2c07..d22eeb574ede 100644
>> --- a/drivers/clk/clk-aspeed.c
>> +++ b/drivers/clk/clk-aspeed.c
>> @@ -541,8 +541,11 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>>
>>          for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
>>                  const struct aspeed_gate_data *gd = &aspeed_gates[i];
>> +               unsigned long flags = gd->flags;
>>                  u32 gate_flags;
>>
>> +               of_clk_detect_critical(pdev->dev.of_node, i, &flags);
> 
> This makes sense to me.
> 
>> +
>>                  /* Special case: the USB port 1 clock (bit 14) is always
>>                   * working the opposite way from the other ones.
>>                   */
>> @@ -550,7 +553,7 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>>                  hw = aspeed_clk_hw_register_gate(dev,
>>                                  gd->name,
>>                                  gd->parent_name,
>> -                               gd->flags,
>> +                               flags,
> 
> For completeness should we make this
> 
>   flags | gd->flags

Not needed. of_clk_detect_critical uses OR operation inside.

>>                                  map,
>>                                  gd->clock_idx,
>>                                  gd->reset_idx,
>> --
>> 2.17.1
>>
