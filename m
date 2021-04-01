From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu, 1 Apr 2021 02:36:11 -0500
Subject: [PATCH v2 2/3] drivers/tty/serial/8250: add DT property for
 aspeed vuart sirq polarity
In-Reply-To: <06aee58f-819b-4486-a5ea-22e6d45e2be5@beta.fastmail.com>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-3-zev@bewilderbeest.net>
 <CACPK8XdPVf1WMmo8C8RJtd-1cH5qV9odEDhDUHWRiMOk=dQNtg@mail.gmail.com>
 <YGVXuyqOyxc8kcQz@hatter.bewilderbeest.net>
 <06aee58f-819b-4486-a5ea-22e6d45e2be5@beta.fastmail.com>
Message-ID: <YGV368K00FHSj5aY@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 01, 2021 at 12:34:04AM CDT, Andrew Jeffery wrote:
>
>
>On Thu, 1 Apr 2021, at 15:48, Zev Weiss wrote:
>> On Wed, Mar 31, 2021 at 11:15:44PM CDT, Joel Stanley wrote:
>> >On Thu, 1 Apr 2021 at 00:57, Zev Weiss <zev@bewilderbeest.net> wrote:
>> >>
>> >> This provides a simple boolean to use instead of the deprecated
>> >> aspeed,sirq-polarity-sense property.
>> >>
>> >> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> >> ---
>> >>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> >> index c33e02cbde93..e5ef9f957f9a 100644
>> >> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> >> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> >> @@ -482,6 +482,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>> >>                 of_node_put(sirq_polarity_sense_args.np);
>> >>         }
>> >>
>> >> +       if (of_property_read_bool(np, "aspeed,sirq-active-high"))
>> >> +               aspeed_vuart_set_sirq_polarity(vuart, 1);
>> >
>> >This assumes the default is always low, so we don't need a property to
>> >set it to that state?
>> >
>> >Would it make more sense to have the property describe if it's high or
>> >low? (I'm happy for the answer to be "no", as we've gotten by for the
>> >past few years without it).
>> >
>>
>> Yeah, that sounds like better way to approach it -- I think I'll
>> rearrange as Andrew suggested in
>> https://lore.kernel.org/openbmc/d66753ee-7db2-41e5-9fe5-762b1ab678bc at www.fastmail.com/
>>
>> >This brings up another point. We already have the sysfs file for
>> >setting the lpc address, from userspace. In OpenBMC land this can be
>> >set with obmc-console-client (/etc/obmc-console.conf). Should we add
>> >support to that application for setting the irq polarity too, and do
>> >away with device tree descriptions?
>> >
>>
>> I guess I might lean slightly toward keeping the DT description so that
>> if for whatever reason obmc-console-server flakes out and doesn't start
>> you're better positioned to try banging on /dev/ttyS* manually if you're
>> desperate.  Though I suppose that in turn might imply that I'm arguing
>> for adding DT properties for lpc_address and sirq too,
>
>Why not just adopt exactly what I've done with KCS, where we have aspeed,lpc-io-reg and aspeed,lpc-interrupts?
>
>Andrew

Ah -- yes, that does sound like a sensible approach.  I'll send a v3 
with that worked in.


Zev

