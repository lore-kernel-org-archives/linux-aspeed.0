From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 1 Mar 2023 12:36:13 -0800
Subject: [PATCH v2 3/3] ARM: dts: aspeed: asrock: Correct firmware flash
 SPI clocks
In-Reply-To: <36da41c9-2396-5dd4-7fef-c85412f23045@kaod.org>
References: <20230224000400.12226-1-zev@bewilderbeest.net>
 <20230224000400.12226-4-zev@bewilderbeest.net>
 <CACPK8XdFT=+VJJ=iDhcmWPh9m9of2b+2UYxkrAisp6tdmWOWKg@mail.gmail.com>
 <36da41c9-2396-5dd4-7fef-c85412f23045@kaod.org>
Message-ID: <Y/+3PSQzo+ZGM+hk@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 28, 2023 at 11:33:58PM PST, C?dric Le Goater wrote:
>On 3/1/23 02:30, Joel Stanley wrote:
>>On Fri, 24 Feb 2023 at 00:04, Zev Weiss <zev@bewilderbeest.net> wrote:
>>>
>>>While I'm not aware of any problems that have occurred running these
>>>at 100 MHz, the official word from ASRock is that 50 MHz is the
>>>correct speed to use, so let's be safe and use that instead.
>>
>>:(
>>
>>Validated with which driver?
>>

spi-nor, FWIW.

>>C?dric, do you have any thoughts on this?
>
>Transactions on the Firmware SPI controller are usually configured at
>50MHz by U-Boot and Linux to stay on the safe side, specially CE0 from
>which the board boots. The other SPI controllers are generally set at
>a higher freq : 100MHz, because the devices on these buses are not for
>booting the BMC, they are mostly only written to (at a default lower
>freq). There are some exceptions when the devices and the wiring permit
>higher rates.
>
>For the record, we lowered the SPI freq on the AST2400 (palmetto)
>because some chips would freak out once in a while at 100MHz.
>
>C.
>

Yeah, this actually grew out of some OpenBMC bringup work on another 
ASRock board -- I started out with a 100MHz clock since that's what I'd 
been using without a hitch on previous ASRock systems (such as these), 
but saw sporadic data corruption.  Some discussion on the OpenBMC 
Discord 
(https://discord.com/channels/775381525260664832/775694683589574659/1074904879023263774 
and 
https://discord.com/channels/775381525260664832/775694683589574659/1075336116212875335) 
prompted me to try 50MHz instead, which seemed to solve the problem -- 
then after enquiring about it with ASRock I discovered that the 100MHz 
clocks we've been using on these boards are also officially out of spec.


Zev

