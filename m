From: Joel Stanley <joel@jms.id.au>
Date: Tue, 14 Apr 2020 08:38:08 +0000
Subject: AST2600 clock gates
In-Reply-To: <CABoTLcQE8r=yu6-doLoGmFgwFcJas5Y9gV-rar+2WHz_DjBuZw@mail.gmail.com>
References: <CABoTLcTN4PnifNTeLp71cnT5Ej_+zVB7yfAPDnPXkGHA0OiUKA@mail.gmail.com>
 <CABoTLcQE8r=yu6-doLoGmFgwFcJas5Y9gV-rar+2WHz_DjBuZw@mail.gmail.com>
Message-ID: <CACPK8XcYUaJ4r7p5Ve1dmAZx3QQhSHZiYt9=KoDZb0=SLDmZ0Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2020 at 00:24, Oskar Senft <osk@google.com> wrote:
>
> OMG, I'm sorry. Ignore. I got confused between ASPEED_CLK_* being random identifiers and ASPEED_RESET_* actually being bits in the registers. Sorry.

No worries. The arragement is not straight forward, I'm glad you worked it out.

I look forward to reviewing your patches on the list :)

Cheers,

Joel

>
> Oskar.
>
> On Sun, Apr 12, 2020 at 7:22 PM Oskar Senft <osk@google.com> wrote:
>>
>> Hey Joel and Andrew
>>
>> I'm working on the AST2600 EVB trying to get some eSPI functionality to work using https://github.com/AspeedTech-BMC/linux/blob/aspeed-dev-v5.1/drivers/soc/aspeed/aspeed-espi.c. The driver is missing support for clock enablement so I dug into how this could be added.
>>
>> I noticed that you guys worked on include/dt-bindings/clock/ast2600-clock.h but from what I can tell the ASPEED_CLK_GATE_* definitions have not yet been updated from AST2500 to AST2600.
>>
>> Am I looking at the latest version of the file? I'm happy to update the clock gate bits, but I don't want to duplicate work that you have in the pipeline.
>>
>> Thanks
>> Oskar.
