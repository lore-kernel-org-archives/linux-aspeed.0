From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 08 Apr 2021 10:27:46 +0930
Subject: [PATCH v2 00/21] ipmi: Allow raw access to KCS devices
In-Reply-To: <20210319061952.145040-1-andrew@aj.id.au>
References: <20210319061952.145040-1-andrew@aj.id.au>
Message-ID: <2db77e16-3f44-4c02-a7ba-a4fac8141ae3@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Corey,

On Fri, 19 Mar 2021, at 16:49, Andrew Jeffery wrote:
> Hello,
> 
> This series is a bit of a mix of things, but its primary purpose is to
> expose BMC KCS IPMI devices to userspace in a way that enables userspace
> to talk to host firmware using protocols that are not IPMI.
> 
> v1 can be found here:
> 
> https://lore.kernel.org/openbmc/20210219142523.3464540-1-andrew at aj.id.au/
> 
> Changes in v2 include:
> 
> * A rebase onto v5.12-rc2
> * Incorporation of off-list feedback on SerIRQ configuration from
>   Chiawei
> * Further validation on hardware for ASPEED KCS devices 2, 3 and 4
> * Lifting the existing single-open constraint of the IPMI chardev
> * Fixes addressing Rob's feedback on the conversion of the ASPEED KCS
>   binding to dt-schema
> * Fixes addressing Rob's feedback on the new aspeed,lpc-interrupts
>   property definition for the ASPEED KCS binding
> 
> A new chardev device is added whose implementation exposes the Input
> Data Register (IDR), Output Data Register (ODR) and Status Register
> (STR) via read() and write(), and implements poll() for event
> monitoring.
> 
> The existing /dev/ipmi-kcs* chardev interface exposes the KCS devices in
> a way which encoded the IPMI protocol in its behaviour. However, as
> LPC[0] KCS devices give us bi-directional interrupts between the host
> and a BMC with both a data and status byte, they are useful for purposes
> beyond IPMI.
> 
> As a concrete example, libmctp[1] implements a vendor-defined MCTP[2]
> binding using a combination of LPC Firmware cycles for bulk data
> transfer and a KCS device via LPC IO cycles for out-of-band protocol
> control messages[3]. This gives a throughput improvement over the
> standard KCS binding[4] while continuing to exploit the ease of setup of
> the LPC bus for early boot firmware on the host processor.
> 
> The series takes a bit of a winding path to achieve its aim:
> 
> 1. It begins with patches 1-5 put together by Chia-Wei, which I've
> rebased on v5.12-rc2. These fix the ASPEED LPC bindings and other
> non-KCS LPC-related ASPEED device drivers in a way that enables the
> SerIRQ patches at the end of the series. With Joel's review I'm hoping
> these 5 can go through the aspeed tree, and that the rest can go through
> the IPMI tree.
> 
> 2. Next, patches 6-13 fairly heavily refactor the KCS support in the
> IPMI part of the tree, re-architecting things such that it's possible to
> support multiple chardev implementations sitting on top of the ASPEED
> and Nuvoton device drivers. However, the KCS code didn't really have
> great separation of concerns as it stood, so even if we disregard the
> multiple-chardev support I think the cleanups are worthwhile.
> 
> 3. Patch 14 adds some interrupt management capabilities to the KCS
> device drivers in preparation for patch 16, which introduces the new
> "raw" KCS device interface. I'm not stoked about the device name/path,
> so if people are looking to bikeshed something then feel free to lay
> into that.
> 
> 4. The remaining patches switch the ASPEED KCS devicetree binding to
> dt-schema, add a new interrupt property to describe the SerIRQ behaviour
> of the device and finally clean up Serial IRQ support in the ASPEED KCS
> driver.
> 
> Rob: The dt-binding patches still come before the relevant driver
> changes, I tried to keep the two close together in the series, hence the
> bindings changes not being patches 1 and 2.
> 
> I've exercised the series under qemu with the rainier-bmc machine plus
> additional patches for KCS support[5]. I've also substituted this series in
> place of a hacky out-of-tree driver that we've been using for the
> libmctp stack and successfully booted the host processor under our
> internal full-platform simulation tools for a Rainier system.
> 
> Note that this work touches the Nuvoton driver as well as ASPEED's, but
> I don't have the capability to test those changes or the IPMI chardev
> path. Tested-by tags would be much appreciated if you can exercise one
> or both.
> 
> Please review!

Unfortunately the cover letter got detached from the rest of the series.

Any chance you can take a look at the patches?

https://lore.kernel.org/linux-arm-kernel/20210319062752.145730-1-andrew at aj.id.au/

Cheers,

Andrew
