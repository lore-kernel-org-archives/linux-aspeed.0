From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 3 Oct 2018 14:28:09 +0200
Subject: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
 <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
 <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
Message-ID: <6e7703e4-461b-77bf-5c9d-cc9e91c5ef3d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 03/10/2018 09:46, Tao Ren wrote:
> On 10/2/18, 11:57 PM, "Linus Walleij" <linus.walleij@linaro.org>
> wrote:
> 
>> My thought is go for (2) and do all changes in one patch :)
> 
> No problem, Linus. One more question: looks like my first patch
> 4451d3f59f2a (fix set_next_event handler) is not merged back to
> "timers/core". Should I generate this patch on top of the first patch
> or on top of the current "timers/core"? Which one would be easier for
> you (or Daniel/Thomas)? Sorry I'm pretty new to the community..


Hi Tao,

the branch tip:timers/urgent will be merged in tip:/timers/core, so the
fixes will be propagated to the master branch.

Base your change in top of tip:timers/urgent, the merge will happen soon
and both fixes will end up in tip:timers/core.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

