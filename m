From: Oskar Senft <osk@google.com>
Date: Wed, 5 Sep 2018 09:45:38 -0400
Subject: [PATCH 1/2] misc: aspeed: Add Aspeed UART routing control driver.
In-Reply-To: <CABoTLcRpQhC7L+Yk2uR91TJSB21i0cp+3BH5cgZWYOWmN6PzVQ@mail.gmail.com>
References: <20180904202018.198707-1-osk@google.com>
 <20180904202018.198707-2-osk@google.com>
 <CACRpkdamHdGH9bANugQchYLWFS_mde6MmcbvBgcG-hrhvGVFWQ@mail.gmail.com>
 <1536106554.3176480.1496936032.1C7BEEDC@webmail.messagingengine.com>
 <CABoTLcRpQhC7L+Yk2uR91TJSB21i0cp+3BH5cgZWYOWmN6PzVQ@mail.gmail.com>
Message-ID: <CABoTLcQpyaLUtdSPJQ4v5_Ds2o54sDJxk+9_etthwQwWRoYK-Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I just had a look at the upstream kernel - there's no drivers/soc/aspeed. I
did find drivers/soc, but no subdirectory for aspeed. Should I create that
with my commit?

Oskar.

On Tue, Sep 4, 2018 at 8:19 PM Oskar Senft <osk@google.com> wrote:

> Thanks for the input!
>
> I had a look at get_maintainer.pl, but thought I'd send it to you and
> Linus first to get initial input since we had already talked about it.
>
> I'll move it to drivers/soc/aspeed and will resend.
>
> For clarification: Should I send to ALL of the people and lists that
> get_maintainer.pl spits out?
>
> Thanks
> Oskar.
>
> On Tue, Sep 4, 2018 at 8:15 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>> On Wed, 5 Sep 2018, at 07:25, Linus Walleij wrote:
>> > On Tue, Sep 4, 2018 at 10:20 PM Oskar Senft <osk@google.com> wrote:
>> >
>> > > This driver adds sysfs files that allow the BMC userspace to configure
>> > > how UARTs and physical serial I/O ports are routed.
>> > >
>> > > Tested: Checked correct behavior (both read & write) on TYAN S7106
>> > > board by manually changing routing settings and confirming that bits
>> > > flow as expected. Tested for UART1 and UART3 as this board doesn't
>> have
>> > > the other UARTs wired up in a testable way.
>> > >
>> > > Signed-off-by: Oskar Senft <osk@google.com>
>> >
>> > After reading some other messages about this I realize it's not very
>> > much you can do with the standard frameworks and you definately
>> > need something like this. Not like I have any better idea.
>> >
>> > Arnd and Greg are misc maintainers so not you will need to
>> > talk to them.
>>
>> Yes. I'm certainly not a person that can merge them.
>>
>> Oskar: Please add at least Greg and Arnd as Linus suggests, and in the
>> future make use of ./scripts/get_maintainer.pl to identify people and
>> lists who should receive the patches.
>>
>> >
>> > I would opt to put it in drivers/soc/aspeed though.
>>
>> Yep, drivers/soc/aspeed seems like a better place. There are other
>> drivers in misc likely should be moved there as well.
>>
>> Thanks for your feedback Linus.
>>
>> Andrew
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180905/4c4250e1/attachment-0001.html>
