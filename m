From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 5 Nov 2018 19:50:31 +0100
Subject: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
Message-ID: <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/11/2018 19:43, Tao Ren wrote:
> On 10/7/18, 2:03 PM, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>>
>> On Wed, Oct 3, 2018 at 11:54 PM Tao Ren <taoren@fb.com> wrote:
>>
>>> TIMER_INTR_MASK register (Base Address of Timer + 0x38) is not designed
>>> for masking interrupts on ast2500 chips, and it's not even listed in
>>> ast2400 datasheet, so it's not safe to access TIMER_INTR_MASK on aspeed
>>> chips.
>>>
>>> Similarly, TIMER_INTR_STATE register (Base Address of Timer + 0x34) is
>>> not interrupt status register on ast2400 and ast2500 chips. Although
>>> there is no side effect to reset the register in fttmr010_common_init(),
>>> it's just misleading to do so.
>>>
>>> Besides, "count_down" is renamed to "is_aspeed" in "fttmr010" structure,
>>> and more comments are added so the code is more readble.
>>>
>>> Signed-off-by: Tao Ren <taoren@fb.com>
>>> ---
>>> Changes in v2:
>>>   - "count_down" is renamed to "is_aspeed" in "fttmr010" structure.
>>>   - more comments are added to make the code more readable.
>>  
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Hi Daniel / Thomas,
> 
> Any further comments on the patch? Or is there anything needed from my side?

Oh right, sorry. Should it go to stable also ? Is there a Fixes tag it
can apply ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

