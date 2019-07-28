From: Oskar Senft <osk@google.com>
Date: Sun, 28 Jul 2019 13:23:12 -0400
Subject: [PATCH] drivers/tty/serial/8250: Make Aspeed VUART SIRQ polarity
 configurable
In-Reply-To: <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
References: <20190727134242.49847-1-osk@google.com>
 <9fb8c99449cebd68fb5975890dedaa06ce7808ae.camel@kernel.crashing.org>
 <CABoTLcRPXffZuKy-DTFUVKJQRydSzMDynYRgBbZ_470iVN1KnA@mail.gmail.com>
Message-ID: <CABoTLcTSFvQruPRnoRPgiWjOXNDOCSnAXVesG7f1WAuLLLVSSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update: I just learned from Aspeed that the SIRQ polarity is actually
dependent on the interface mode, LPC vs. eSPI.

For LPC, the polarity should be set to 1, for eSPI the default of 0 is
correct.

I'll amend the patch to read the interface mode from the HW pin strap
register and day the default accordingly at driver load time.

If there are no objections, I'll leave the sysfs part in there in case it
does need to be changed.

Oskar.

On Sun, Jul 28, 2019, 12:00 AM Oskar Senft <osk@google.com> wrote:

> I was thinking exactly the same thing (which is why I pointed it out in
> the change description). Thanks for picking up on that :-D
>
> I considered both options but decided to follow what's been done for the
> sirq and lpc_address settings, as sirq_polarity should really go together
> with the other two. I guess we could argue that the sirq_polarity likely
> always has to have a specific setting for the specific platform, whereas
> the sirq and the lpc_address might be configurable in some way from the
> host at runtime.
>
> Another reason I decided against DTS is that the properties currently read
> from DTS are "standard properties" from the 8250 driver. So I wasn't sure
> if it's ok to add a property that clearly specific to the 8250_aspeed_vuart
> driver.
>
> If anyone has strong feelings I can either change it from sysfs to DTS or
> add DTS on top - it's quite easy to do. Thoughts?
>
> Thanks
> Oskar.
>
> On Sat, Jul 27, 2019 at 9:30 PM Benjamin Herrenschmidt <
> benh at kernel.crashing.org> wrote:
>
>> On Sat, 2019-07-27 at 09:42 -0400, Oskar Senft wrote:
>> > Make the SIRQ polarity for Aspeed 24xx/25xx VUART configurable via
>> > sysfs. It is required on some host platforms (e.g. TYAN S7106) to
>> > reconfigure this setting from the default to enable the host to
>> > receive
>> > interrupts from the VUART.
>> >
>> > The setting is configurable via sysfs rather than device-tree to stay
>> > in
>> > line with other related configurable settings.
>>
>> If it's a fixed platform configuration that never changes at runtime,
>> shouldn't it be in the device-tree instead ?
>>
>> Cheers,
>> Ben
>>
>> > Tested: Verified on TYAN S7106 mainboard.
>> > Signed-off-by: Oskar Senft <osk@google.com>
>> > ---
>> >  .../ABI/stable/sysfs-driver-aspeed-vuart      | 10 ++++-
>> >  drivers/tty/serial/8250/8250_aspeed_vuart.c   | 39
>> > +++++++++++++++++++
>> >  2 files changed, 48 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
>> > b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
>> > index 8062953ce77b..64fad87ad964 100644
>> > --- a/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
>> > +++ b/Documentation/ABI/stable/sysfs-driver-aspeed-vuart
>> > @@ -6,10 +6,18 @@ Description:        Configures which IO port the
>> > host side of the UART
>> >  Users:               OpenBMC.  Proposed changes should be mailed to
>> >               openbmc at lists.ozlabs.org
>> >
>> > -What:                /sys/bus/platform/drivers/aspeed-vuart*/sirq
>> > +What:                /sys/bus/platform/drivers/aspeed-vuart/*/sirq
>> >  Date:                April 2017
>> >  Contact:     Jeremy Kerr <jk@ozlabs.org>
>> >  Description: Configures which interrupt number the host side of
>> >               the UART will appear on the host <-> BMC LPC bus.
>> >  Users:               OpenBMC.  Proposed changes should be mailed to
>> >               openbmc at lists.ozlabs.org
>> > +
>> > +What:                /sys/bus/platform/drivers/aspeed-
>> > vuart/*/sirq_polarity
>> > +Date:                July 2019
>> > +Contact:     Oskar Senft <osk@google.com>
>> > +Description: Configures the polarity of the serial interrupt to the
>> > +             host via the BMC LPC bus.
>> > +Users:               OpenBMC.  Proposed changes should be mailed to
>> > +             openbmc at lists.ozlabs.org
>> > diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> > b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> > index 0438d9a905ce..ef0a6ff69841 100644
>> > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> > @@ -22,6 +22,7 @@
>> >
>> >  #define ASPEED_VUART_GCRA            0x20
>> >  #define ASPEED_VUART_GCRA_VUART_EN           BIT(0)
>> > +#define ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY BIT(1)
>> >  #define ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD BIT(5)
>> >  #define ASPEED_VUART_GCRB            0x24
>> >  #define ASPEED_VUART_GCRB_HOST_SIRQ_MASK     GENMASK(7, 4)
>> > @@ -131,8 +132,46 @@ static ssize_t sirq_store(struct device *dev,
>> > struct device_attribute *attr,
>> >
>> >  static DEVICE_ATTR_RW(sirq);
>> >
>> > +static ssize_t sirq_polarity_show(struct device *dev,
>> > +                               struct device_attribute *attr, char
>> > *buf)
>> > +{
>> > +     struct aspeed_vuart *vuart = dev_get_drvdata(dev);
>> > +     u8 reg;
>> > +
>> > +     reg = readb(vuart->regs + ASPEED_VUART_GCRA);
>> > +     reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
>> > +
>> > +     return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
>> > +}
>> > +
>> > +static ssize_t sirq_polarity_store(struct device *dev,
>> > +                                struct device_attribute *attr,
>> > +                                const char *buf, size_t count)
>> > +{
>> > +     struct aspeed_vuart *vuart = dev_get_drvdata(dev);
>> > +     unsigned long val;
>> > +     int err;
>> > +     u8 reg;
>> > +
>> > +     err = kstrtoul(buf, 0, &val);
>> > +     if (err)
>> > +             return err;
>> > +
>> > +     reg = readb(vuart->regs + ASPEED_VUART_GCRA);
>> > +     if (val != 0)
>> > +             reg |= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
>> > +     else
>> > +             reg &= ~ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
>> > +     writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
>> > +
>> > +     return count;
>> > +}
>> > +
>> > +static DEVICE_ATTR_RW(sirq_polarity);
>> > +
>> >  static struct attribute *aspeed_vuart_attrs[] = {
>> >       &dev_attr_sirq.attr,
>> > +     &dev_attr_sirq_polarity.attr,
>> >       &dev_attr_lpc_address.attr,
>> >       NULL,
>> >  };
>>
>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190728/cd289cb0/attachment-0001.htm>
