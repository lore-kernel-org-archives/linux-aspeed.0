From: Linux regression tracking #update (Thorsten Leemhuis) <regressions@leemhuis.info>
Date: Wed, 15 Feb 2023 15:52:46 +0100
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
In-Reply-To: <3af98200-7240-9e93-bd6a-d0e2f71ab1c4@leemhuis.info>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
 <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
 <3af98200-7240-9e93-bd6a-d0e2f71ab1c4@leemhuis.info>
Message-ID: <05f6936f-f8e0-d0e5-7f8f-d0278dc03753@leemhuis.info>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Link: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 21.01.23 13:32, Linux kernel regression tracking (#adding) wrote:
> On 19.01.23 02:54, Joel Stanley wrote:
>> On Fri, 26 Aug 2022 at 22:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>>> On Sat, 27 Aug 2022, at 07:26, Linus Walleij wrote:
>>>> On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>>>>
>>>>> When the driver want to disable the signal of the function, it doesn't
>>>>> need to query the state of the mux function's signal on a pin. The
>>>>> condition below will miss the disable of the signal:
>>
>>>> I can't see the verdict for this patch? Will there be a new
>>>> version, or are we in the middle of a discussion?
>>>> I'd really like Andrew's ACK on the result before merging.
>>>
>>> Apologies, it's been a bit of A Week :)
>>>
>>> Given the approach has been discussed with the IP designer and solves a bug I'm okay for it to be merged. If we run into issues it is easy enough to back it out.
>>
>> As foreseen by Andrew, this caused a regression. On the Romulus
>> machine the device tree contains a gpio hog for GPIO S7. With the
>> patch applied:
> 
> #regzbot ^introduced cf517fef601b
> #regzbot title pinctrl: aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to
> acquire regmap for IP block 1
> #regzbot ignore-activity

#regzbot fix: 606d4ef4922662

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
