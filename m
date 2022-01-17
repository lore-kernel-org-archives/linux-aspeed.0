From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jan 2022 15:51:15 +0100
Subject: [PATCH 3/3] ARM: aspeed: Add secure boot controller support
In-Reply-To: <CACPK8XcSPiOoJZ4jyJySvCiW+EXxSVsxiEcK2eOZjGY9b1vrjA@mail.gmail.com>
References: <20211117035106.321454-1-joel@jms.id.au>
 <20211117035106.321454-4-joel@jms.id.au>
 <CACPK8XcSPiOoJZ4jyJySvCiW+EXxSVsxiEcK2eOZjGY9b1vrjA@mail.gmail.com>
Message-ID: <CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 11, 2022 at 12:29 AM Joel Stanley <joel@jms.id.au> wrote:
> On Wed, 17 Nov 2021 at 03:51, Joel Stanley <joel@jms.id.au> wrote:
> >
> > This reads out the status of the secure boot controller and exposes it
> > in sysfs.
> >
> > An example on a AST2600A3 QEMU model:
> >
> >  # grep . /sys/bus/soc/devices/soc0/*
> >  /sys/bus/soc/devices/soc0/abr_image:0
> >  /sys/bus/soc/devices/soc0/family:AST2600
> >  /sys/bus/soc/devices/soc0/low_security_key:0
> >  /sys/bus/soc/devices/soc0/machine:Rainier 2U
> >  /sys/bus/soc/devices/soc0/otp_protected:0
> >  /sys/bus/soc/devices/soc0/revision:A3
> >  /sys/bus/soc/devices/soc0/secure_boot:1
> >  /sys/bus/soc/devices/soc0/serial_number:888844441234abcd
> >  /sys/bus/soc/devices/soc0/soc_id:05030303
> >  /sys/bus/soc/devices/soc0/uart_boot:1
>
> Quoting from your response to my pull request:
>
> > - I actually want to avoid custom attributes on soc device instances as much
> >   as possible. I have not looked in detail at what you add here, but the
> >   number of custom attributes means we should discuss this properly.
>
> Can you explain the reasoning here?
>
> I am a bit surprised given we have this nice feature in struct
> soc_device_attribute:
>
> struct soc_device_attribute {
> ...
>         const struct attribute_group *custom_attr_group;
> };

I have two main concerns:

- any attribute that makes sense across multiple SoC families should probably be
  part of the standard set of attributes. Ideally this could fit
within the existing
  attributes, but if you can make a reasonable case for adding further
ones, that
  is fine as well. The standard attributes can then also be accessed from within
  the kernel with soc_device_match(), rather than just being available
to user space.

- The attributes should all be used to identify the SoC, not a
particular part of
  the SoC that is better represented as a separate device.

If you are adding five attributes at once, it's likely that these
don't all fit the
constraints, though I had not yet looked at the implementation.

From what I see in

+static ssize_t abr_image_show(struct device *dev, struct
device_attribute *attr, char *buf)
+{
+       return sprintf(buf, "%d\n", !!(security_status & ABR_IMAGE_SOURCE));
+}
+
+static ssize_t low_security_key_show(struct device *dev, struct
device_attribute *attr, char *buf)
+{
+       return sprintf(buf, "%d\n", !!(security_status & LOW_SEC_KEY));
+}
+
+static ssize_t otp_protected_show(struct device *dev, struct
device_attribute *attr, char *buf)
+{
+       return sprintf(buf, "%d\n", !!(security_status & OTP_PROTECTED));
+}
+
+static ssize_t secure_boot_show(struct device *dev, struct
device_attribute *attr, char *buf)
+{
+       return sprintf(buf, "%d\n", !!(security_status & SECURE_BOOT));
+}
+
+static ssize_t uart_boot_show(struct device *dev, struct
device_attribute *attr, char *buf)
+{
+       return sprintf(buf, "%d\n", !(security_status & UART_BOOT));
+}

it appears that these are related to how the system was started, which doesn't
fit either of the requirements: the same information may be useful for
non-aspeed
systems, so it would be good to have it in a standardized interface rather than
vendor extensions, and it doesn't really identify the SoC but instead provides
information from a device that is inside of the SoC.

Maybe this could be turned into a generalized interface similar to soc_device
that exposes the boot status in sysfs? We have a couple of files that
determine e.g. whether the kernel was booted securely, and those could
all hook up here. It doesn't have to be anything complex, just a node under
/sys/firmware or /sys/power that has a couple of documented attributes
that can be filled by drivers.

          Arnd
